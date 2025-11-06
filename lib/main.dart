import 'package:flutter/material.dart';
import 'package:it312_final_project/pages/dashboard.dart';
import 'package:it312_final_project/pages/guardian_details_form.dart';
import 'package:it312_final_project/pages/loan_request.dart';
import 'package:it312_final_project/pages/login.dart';
import 'package:it312_final_project/pages/profile_details.dart';
import 'package:it312_final_project/pages/register.dart';
import 'package:it312_final_project/pages/requests_form.dart';
import 'package:it312_final_project/pages/student_details_form.dart';
import 'package:it312_final_project/routes/router_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}