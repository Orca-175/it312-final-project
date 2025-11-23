import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/guardian_details_provider.dart';

class GuardianDetailsForm extends ConsumerStatefulWidget {
  const GuardianDetailsForm({super.key});

  @override
  ConsumerState<GuardianDetailsForm> createState() => _GuardianDetailsFormState();
}

class _GuardianDetailsFormState extends ConsumerState<GuardianDetailsForm> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _middleName = '';
  String _relationship = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';
  String _occupation = '';
  String _employer= '';
  String _employerPhoneNumber = '';
  String _monthlyIncome = '';


  @override
  Widget build(BuildContext context) {
    final guardianDetails = ref.watch(guardianDetailsProvider(globalUserAccountId));

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300.0,
          child: Form(
            key: _formGlobalKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const Text('Guardian Details', style: TextStyle(fontSize: 20.0)),
                TextFormField(
                  initialValue: guardianDetails.firstName,
                  decoration: const InputDecoration(label: Text('First Name')),
                  onSaved: (value) => _firstName = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.lastName,
                  decoration: const InputDecoration(label: Text('Last Name')),
                  onSaved: (value) => _lastName = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.middleName,
                  decoration: const InputDecoration(label: Text('Middle Name')),
                  onSaved: (value) => _middleName = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.relationship,
                  decoration: const InputDecoration(label: Text('Relationship')),
                  onSaved: (value) => _relationship = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.email,
                  decoration: const InputDecoration(label: Text('Email')),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _email = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!)) {
                      return emailFormatError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.phoneNumber,
                  decoration: const InputDecoration(label: Text('Phone Number')),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (value) => _phoneNumber = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } if (value!.length > 11) {
                      return phoneNumberFormatError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.address,
                  decoration: const InputDecoration(label: Text('Address')),
                  onSaved: (value) => _address = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.occupation,
                  decoration: const InputDecoration(label: Text('Occupation')),
                  onSaved: (value) => _occupation = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.employer,
                  decoration: const InputDecoration(label: Text('Employer')),
                  onSaved: (value) => _employer = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.employerPhoneNumber,
                  decoration: const InputDecoration(label: Text('Employer Phone Number')),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (value) => _employerPhoneNumber = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } if (value!.length > 11) {
                      return phoneNumberFormatError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: guardianDetails.monthlyIncome,
                  decoration: const InputDecoration(label: Text('Monthly Income')),
                  onSaved: (value) => _monthlyIncome = value!,
                  validator: (value) {
                    if (value == '') {
                      return requiredFieldError;
                    } 
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                FilledButton(
                  onPressed: () async {
                    if (_formGlobalKey.currentState!.validate()) {
                      _formGlobalKey.currentState!.save();
                      String operation = guardianDetails.anyEmptyFields() ? 'add' : 'update';
                      await ref.read(guardianDetailsProvider(globalUserAccountId).notifier).submitDetails(
                        _firstName, 
                        _lastName, 
                        _middleName, 
                        _relationship, 
                        _email, 
                        _phoneNumber, 
                        _address, 
                        _occupation, 
                        _employer, 
                        _employerPhoneNumber, 
                        _monthlyIncome, 
                        operation,
                      );
                      if (!context.mounted) return;
                      context.go('/profile_details');
                    }
                  }, 
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}