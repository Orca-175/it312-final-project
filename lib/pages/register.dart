import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/classes/authentication.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/widgets/header_message_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerGlobalKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          key: _registerGlobalKey,
          child: Column(
            children: [
              const SizedBox(height: 80.0),
              Text('Register', style: const TextStyle(fontSize: 20.0)),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(label: Text(('Username'))),
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(label: Text(('Password'))),
                onChanged: (value) => _password = value,
                onSaved: (value) => _password = value!,
                validator: (value) {
                  if (value!.length < 8) {
                    return 'Password must be 8 characters or more.';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(label: Text(('Confirm Password'))),
                onSaved: (value) => _confirmPassword = value!,
                validator: (value) {
                  if (_password != value) {
                    return 'Confirm Password must match Password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              FilledButton(
                onPressed: () async {
                  if (_registerGlobalKey.currentState!.validate()) {
                    _registerGlobalKey.currentState!.save();
                    try {
                      String successMessage = await Authentication.register(_username, _password);
                      if (!context.mounted) return;
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return HeaderMessageDialog(
                            header: 'Successfully Registered', 
                            message: '$successMessage Once your account has been approved, you will be able to login.',
                            action: TextButton(
                              onPressed: () {
                                context.go('/login');
                              }, 
                              child: const Text('Go to Login'),
                            ),
                          );
                        },
                      );
                    } catch (exception) {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return HeaderMessageDialog(
                            header: 'Registration Failed', 
                            message: exception.toString().removeExceptionPrefix(),
                            action: TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Dismiss'),
                            ),
                          );
                        }
                      );
                    }
                  }
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