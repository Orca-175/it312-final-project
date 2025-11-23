import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/pages/dashboard.dart';
import 'package:it312_final_project/pages/guardian_details_form.dart';
import 'package:it312_final_project/pages/loan_request.dart';
import 'package:it312_final_project/pages/login.dart';
import 'package:it312_final_project/pages/profile_details.dart';
import 'package:it312_final_project/pages/register.dart';
import 'package:it312_final_project/pages/requests_form.dart';
import 'package:it312_final_project/pages/student_details_form.dart';
import 'package:it312_final_project/tests/test.dart';

GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/test',
      builder: (context, state) => RootScaffold(body: Test())
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RootScaffold(body: Register()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => RootScaffold(body: Login()),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Dashboard()
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile_details',
              builder: (context, state) => ProfileDetails(),
              routes: [
                GoRoute(
                  path: 'student_details_form',
                  builder: (context, state) => StudentDetailsForm(),
                ),
                GoRoute(
                  path: 'guardian_details_form',
                  builder: (context, state) => GuardianDetailsForm(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/loan_request',
              builder: (context, state) => LoanRequest(),
              routes: [
                GoRoute(
                  path: 'requests_form',
                  builder: (context, state) => RequestsForm(),
                ),
              ],
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return RootScaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: navigationShell,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              return navigationShell.goBranch(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile Details',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Loan Request',
              ),
            ],
          ),
        );
      }
    ),
  ],
);

class RootScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  const RootScaffold({super.key, required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(7.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 5.0, 
                    spreadRadius: -4.0),
                ]
              ),
              child: Image.asset('assets/brand/scholarpay_logo.png'),
              ), 
            Text(' | '), 
            Text('ScholarPay'),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}