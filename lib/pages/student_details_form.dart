import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/classes/student_details.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';
import 'package:it312_final_project/widgets/header_message_dialog.dart';

class StudentDetailsForm extends ConsumerStatefulWidget {
  const StudentDetailsForm({super.key});

  @override
  ConsumerState<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends ConsumerState<StudentDetailsForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _dateOfBirthController = TextEditingController();


  String _studentId = '';
  String _firstName = '';
  String _lastName = '';
  String _middleName = '';
  String _dateOfBirth = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _dateOfBirthController.text = ref.read(studentDetailsProvider(globalUserAccountId)).dateOfBirth;
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = ref.watch(studentDetailsProvider(globalUserAccountId));

    return SingleChildScrollView(
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 300.0,
              child: Form(
                key: _formGlobalKey,
                child: Column(
                  children: [
                    const Text('Student Details', style: TextStyle(fontSize: 20.0)),
                    TextFormField(
                      initialValue: studentDetails.studentId,
                      decoration: const InputDecoration(label: Text('Student ID')),
                      onSaved: (value) => _studentId = value!,
                      validator: (value) {
                        if (value == '') {
                          return requiredFieldError;
                        } else if (!StudentDetails.isValidSchoolId(value!)) {
                          return studentIdFormatError;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: studentDetails.firstName,
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
                      initialValue: studentDetails.lastName,
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
                      initialValue: studentDetails.middleName,
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
                      controller: _dateOfBirthController,
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context, 
                          initialDate: studentDetails.dateOfBirth == '' ? DateTime(2000) : 
                            DateTime.parse(studentDetails.dateOfBirth),
                          firstDate: DateTime(1950), 
                          lastDate: DateTime(2025),
                        );
                        setState(() {
                          _dateOfBirthController.text = selectedDate != null ? 
                            '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}' : '';
                        });
                      },
                      readOnly: true,
                      decoration: const InputDecoration(label: Text('Date of Birth')),
                      onSaved: (value) => _dateOfBirth = value!,
                      validator: (value) {
                        if (value == '') {
                          return requiredFieldError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      initialValue: studentDetails.email,
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
                      initialValue: studentDetails.phoneNumber,
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
                    const SizedBox(height: 24.0),
                    TextFormField(
                      initialValue: studentDetails.address ,
                      decoration: const InputDecoration(label: Text('Address')),
                      onSaved: (value) => _address = value!,
                      validator: (value) {
                        if (value == '') {
                          return requiredFieldError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    FilledButton(
                      onPressed: () async {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          String operation = studentDetails.anyEmptyFields() ? 'add' : 'update';
                          try {
                            await ref.read(studentDetailsProvider(globalUserAccountId).notifier).
                              submitDetails(
                                _studentId, 
                                _firstName, 
                                _lastName, 
                                _middleName, 
                                _dateOfBirth, 
                                _email, 
                                _phoneNumber, 
                                _address, 
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
                          context.go('/profile_details');
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
    );
  }
}