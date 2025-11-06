import 'package:flutter/material.dart';

class GuardianDetailsForm extends StatefulWidget {
  const GuardianDetailsForm({super.key});

  @override
  State<GuardianDetailsForm> createState() => _GuardianDetailsFormState();
}

class _GuardianDetailsFormState extends State<GuardianDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Text('Guardian Details', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                decoration: InputDecoration(label: Text('Name')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Relationship')),
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
              TextFormField(
                decoration: InputDecoration(label: Text('Occupation')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Monthly Income')),
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