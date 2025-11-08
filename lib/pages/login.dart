import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/classes/authentication.dart';
import 'package:it312_final_project/globals/globals.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginGlobalKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          key: _loginGlobalKey,
          child: Column(
            children: [
              const SizedBox(height: 80.0),
              Text('Login', style: const TextStyle(fontSize: 20.0)),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(label: Text(('Username'))),
                initialValue: _username,
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(label: Text(('Password'))),
                initialValue: _username,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 24.0),
              FilledButton(
                    onPressed: () async {
                      _loginGlobalKey.currentState!.save();
                      try {
                        globalUserAccountId =  await Authentication.login(_username, _password);
                        if (!context.mounted) return;
                        context.go('/test');
                      } catch (exception) {
                        // TODO: Add exception message
                        print(exception);
                      }
                    }, 
                child: const Text('Login'),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    }, 
                    child: const Text('Register'),
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