import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        child: Form(
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
                onPressed: () {
                  // TODO: Actually register account
                  context.go('/login');
                }, 
                child: Text('Register'),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account? '),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    }, 
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}