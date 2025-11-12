import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';

class StudentDetailsForm extends ConsumerStatefulWidget {
  const StudentDetailsForm({super.key});

  @override
  ConsumerState<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends ConsumerState<StudentDetailsForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _dateOfBirthController = TextEditingController();


  String _fullName = '';
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

    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          key: _formGlobalKey,
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const Text('Student Details', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                initialValue: studentDetails.fullName,
                decoration: const InputDecoration(label: Text('Full Name')),
                onSaved: (value) => _fullName = value!,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
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
                  print('selected date: $selectedDate');
                  setState(() {
                    _dateOfBirthController.text = selectedDate != null ? 
                      '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}' : '';
                  });
                },
                readOnly: true,
                decoration: InputDecoration(label: Text('Date of Birth')),
                onSaved: (value) => _dateOfBirth = value!,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: studentDetails.email,
                decoration: const InputDecoration(label: Text('Email')),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: studentDetails.phoneNumber,
                decoration: const InputDecoration(label: Text('Phone Number')),
                onSaved: (value) => _phoneNumber = value!,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: studentDetails.address ,
                decoration: const InputDecoration(label: Text('Address')),
                onSaved: (value) => _address = value!,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
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
                    await ref.read(studentDetailsProvider(globalUserAccountId).notifier).
                      submitDetails(_fullName, _dateOfBirth, _email, _phoneNumber, _address, operation); 
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
    );
  }
}