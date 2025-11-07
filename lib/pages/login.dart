import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 80.0),
              Text('Login', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(label: Text(('Username'))),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text(('Password'))),
              ),
              SizedBox(height: 24.0),
              FilledButton(
                    onPressed: () {
                      // TODO: Add actual authentication
                      context.go('/');
                    }, 
                child: Text('Login'),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? '),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    }, 
                    child: Text('Register'),
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