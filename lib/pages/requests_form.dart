import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/classes/requests.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/requests_provider.dart';

class RequestsForm extends ConsumerStatefulWidget {
  const RequestsForm({super.key});

  @override
  ConsumerState<RequestsForm> createState() => _RequestsFormState();
}

class _RequestsFormState extends ConsumerState<RequestsForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  final List<String> _paymentTermOptions = ['Monthly', 'Full Payment'];
  final List<String> _paymentScheduleOptions = ['3 Months', '6 Months', '12 Months'];
  final List<String> _enrollmentStatusOptions = ['Regular', 'Irregular'];
  double _maxLoanAmount = 10000.0;

  String _studentId = '';
  String _generalWeightedAverage = '';
  double _loanAmount = 10000.0;
  String _paymentTerm = '';
  String _paymentSchedule = '';
  String _gradeLevel = '';
  String _course = '';
  String _enrollmentStatus = '';

  @override
  void initState() {
    super.initState();
    final requestDetails = ref.read(requestsProvider(globalUserAccountId));
    if (!requestDetails.anyEmptyFields()) {
      double convertedGwa = Requests.shsGwaToCollegeGwaRange(requestDetails.generalWeightedAverage);
      _maxLoanAmount = Requests.getMaxLoanAmount(convertedGwa);
      _loanAmount = double.parse(requestDetails.loanAmount);
    }
  }

  @override
  Widget build(BuildContext context) { 
    final requestDetails = ref.watch(requestsProvider(globalUserAccountId));

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300.0,
          child: Form(
            key: _formGlobalKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const Text('Requests Details', style: TextStyle(fontSize: 20.0)),
                TextFormField(
                  initialValue: requestDetails.studentId,
                  decoration: const InputDecoration(label: Text('Student ID')),
                  onSaved: (value) => _studentId = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } else if (!Requests.isValidSchoolId(value!)) {
                      return studentIdFormatError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: requestDetails.generalWeightedAverage == 0.0 ? '' : 
                    requestDetails.generalWeightedAverage.toString(),
                  decoration: const InputDecoration(label: Text('General Weighted Average')),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSaved: (value) => _generalWeightedAverage = value!,
                  onChanged: (value) {
                    _generalWeightedAverage = value;
                    if (value.isNumeric()) {
                      double convertedGwa = Requests.shsGwaToCollegeGwaRange(double.parse(_generalWeightedAverage));
                      setState(() {
                        _maxLoanAmount = Requests.getMaxLoanAmount(convertedGwa);
                      });
                    } else if (value == '') {
                      setState(() {
                        _maxLoanAmount = 10000.0;
                      });
                    }
                    setState(() {
                      _loanAmount = 10000.0;
                    });
                  },
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } else if (value!.isNumeric()) { 
                      if (Requests.shsGwaToCollegeGwaRange(double.parse(value)) > 3) {
                        return 'Your GWA does not qualify you for this service.';
                      }
                    } else {
                      return 'GWA must be numeric.';
                    }
                    return null;
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    const Text('Loan Amount', style: TextStyle(fontSize: 16.0),),
                    Slider(
                      value: _loanAmount,
                      onChanged: _maxLoanAmount == 10000.0 ? null : (value) {
                        setState(() {
                          _loanAmount = value;
                        });
                      },
                      min: 10000.0,
                      max: _maxLoanAmount,
                      divisions: _maxLoanAmount == 10000.0 ? 1 : ((_maxLoanAmount.toInt() - 10000) / 500).toInt(),
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(_loanAmount.round().toString())),
                        Text(_maxLoanAmount.toInt().toString()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                DropdownButtonFormField(
                  initialValue: requestDetails.paymentTerm == '' ? null : requestDetails.paymentTerm,
                  decoration: const InputDecoration(label: Text('Payment Term')),
                  items: _paymentTermOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onSaved: (value) => _paymentTerm = value!,
                  onChanged: (value) {
                    setState(() {
                      _paymentTerm = value!;
                    });
                  }
                ),
                DropdownButtonFormField(
                  initialValue: requestDetails.paymentSchedule == '' ? null : requestDetails.paymentSchedule,
                  decoration: const InputDecoration(label: Text('Payment Schedule')),
                  items: _paymentScheduleOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onSaved: (value) => _paymentSchedule = _paymentTerm == 'Full Payment' ? '3 Months' : value!,
                  onChanged: _paymentTerm == 'Full Payment' ? null : (value) {
                    setState(() {
                      _paymentSchedule = value.toString();
                    });
                  }
                ),
                TextFormField(
                  initialValue: requestDetails.gradeLevel,
                  decoration: const InputDecoration(label: Text('Year')),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (value) => _gradeLevel = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: requestDetails.course,
                  decoration: const InputDecoration(label: Text('Strand/Course')),
                  onSaved: (value) => _course = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  initialValue: requestDetails.enrollmentStatus == '' ? null : requestDetails.enrollmentStatus,
                  decoration: const InputDecoration(label: Text('Enrollment Status')),
                  items: _enrollmentStatusOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onSaved: (value) => _enrollmentStatus = value!,
                  onChanged: (value) {
                    setState(() {
                      _enrollmentStatus = value!;
                    });
                  }
                ),
                const SizedBox(height: 24.0),
                FilledButton(
                  onPressed: () async {
                    if (_formGlobalKey.currentState!.validate()) {
                      _formGlobalKey.currentState!.save();
                      String operation = requestDetails.anyEmptyFields() ? 'add' : 'update';
                      final requestProvider = ref.read(requestsProvider(globalUserAccountId).notifier);
                      await requestProvider.submitDetails(
                        _studentId, 
                        double.parse(_generalWeightedAverage), 
                        _loanAmount.toInt().toString(), 
                        _paymentTerm, 
                        _paymentSchedule, 
                        _gradeLevel, 
                        _course, 
                        _enrollmentStatus, 
                        operation
                      );
                      await requestProvider.getDetails();
                      if (!context.mounted) return;
                      context.go('/loan_request');
                    }
                  }, 
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}