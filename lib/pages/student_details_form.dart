import 'package:flutter/material.dart';

class StudentDetailsForm extends StatefulWidget {
  const StudentDetailsForm({super.key});

  @override
  State<StudentDetailsForm> createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends State<StudentDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Text('Student Details', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                decoration: InputDecoration(label: Text('Name')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Date of Birth')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Email')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Phone Number')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Address')),
              ),
              SizedBox(height: 24.0),
              FilledButton(
                onPressed: () {}, 
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}