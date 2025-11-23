import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/classes/requests.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/requests_provider.dart';
import 'package:it312_final_project/widgets/header_message_dialog.dart';
import 'package:mime/mime.dart';

class RequestsForm extends ConsumerStatefulWidget {
  const RequestsForm({super.key});

  @override
  ConsumerState<RequestsForm> createState() => _RequestsFormState();
}

class _RequestsFormState extends ConsumerState<RequestsForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _reportCardFieldController = TextEditingController();
  final _paymentTermOptions = ['Monthly', 'Full Payment'];
  final _paymentScheduleOptions = ['3 Months', '6 Months', '12 Months'];
  final _enrollmentStatusOptions = ['Regular', 'Irregular'];
  double _maxLoanAmount = 10000.0;

  String _generalWeightedAverage = '';
  File? _reportCard;
  bool _reportCardFieldEnabled = false;
  int _reportCardFileSize = 0;
  double _loanAmount = 10000.0;
  String _paymentTerm = '';
  String? _paymentSchedule = '';
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
    _reportCardFieldController.text = requestDetails.reportCardExistsInDatabase ? 
      'A file already exists. Replace?' : '';
    _paymentSchedule = requestDetails.paymentSchedule == '' ? null : requestDetails.paymentSchedule;
  }

  @override
  Widget build(BuildContext context) { 
    final requestDetails = ref.watch(requestsProvider(globalUserAccountId));

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 300.0,
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    children: [
                      const Text('Requests Details', style: TextStyle(fontSize: 20.0)),
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
                          const Text('Loan Amount', style: TextStyle(fontSize: 16.0)),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _reportCardFieldController,
                            readOnly: true,
                            enabled: _reportCardFieldEnabled,
                            decoration: const InputDecoration(label: Text('Report Card')),
                            validator: (value) {
                              if (_reportCard == null && !requestDetails.reportCardExistsInDatabase) {
                                return requiredFieldError;
                              } else if (_reportCard != null && !['image/png' ,'image/jpeg', 'application/pdf']
                                  .contains(lookupMimeType(_reportCard!.path))) {
                                return 'Report Card must be a .png, .jpg, or .pdf.';
                              } else if (_reportCard != null && _reportCardFileSize > 5 * 1000000) {
                                return 'Report Card must be less than 5 MB.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          FilledButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                PlatformFile file = result.files.single;
                                _reportCard = File(file.path!);
              
                                setState(() {
                                  _reportCardFieldController.text = file.name;
                                  _reportCardFieldEnabled = true;
                                });
                              }
                            }, 
                            child: Icon(Icons.upload)
                          ),
                        ],
                      ),
                      const Divider(height: 64.0),
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
                          if (value == 'Full Payment') {
                            setState(() {
                              _paymentTerm = value!;
                              _paymentSchedule = '3 Months';
                            });
                          }
                          setState(() {
                            _paymentTerm = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return requiredFieldError;
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField(
                        initialValue: _paymentSchedule,
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
                        },
                        validator: (value) {
                          if (value == null) {
                            return requiredFieldError;
                          }
                          return null;
                        },
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
                        },
                        validator: (value) {
                          if (value == null) {
                            return requiredFieldError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      FilledButton(
                        onPressed: () async {
                          if (_reportCard != null) {
                            _reportCardFileSize = await _reportCard!.length();
                          }
                      
                          if (_formGlobalKey.currentState!.validate()) {
                            _formGlobalKey.currentState!.save();
                            String operation = requestDetails.anyEmptyFields() ? 'add' : 'update';
                            try {
                              await ref.read(requestsProvider(globalUserAccountId).notifier)
                                .submitDetails(
                                  double.parse(_generalWeightedAverage), 
                                  _reportCard,
                                  _loanAmount.toInt().toString(), 
                                  _paymentTerm, 
                                  _paymentSchedule! , 
                                  _gradeLevel, 
                                  _course, 
                                  _enrollmentStatus, 
                                  operation
                                );
                            } catch (error) {
                              if (!context.mounted) return;
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return HeaderMessageDialog(
                                    header: 'Error', 
                                    message: error.toString(), 
                                    action: TextButton(
                                      onPressed: () {
                                        context.pop();
                                      }, 
                                      child: const Text('Dismiss'),
                                    ),
                                  );
                                },
                              );
                              return;
                            }
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
          ),
        ),
      ),
    );
  }
}