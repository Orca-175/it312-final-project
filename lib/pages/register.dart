import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Column(
          children: [
            SizedBox(height: 80.0),
            Text('Register', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(label: Text(('Username'))),
            ),
            TextField(
              decoration: InputDecoration(label: Text(('Password'))),
            ),
            TextField(
              decoration: InputDecoration(label: Text(('Confirm Password'))),
            ),
            SizedBox(height: 8.0),
            FilledButton(
              onPressed: () {}, 
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}