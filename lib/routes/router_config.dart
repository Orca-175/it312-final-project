import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/pages/dashboard.dart';
import 'package:it312_final_project/pages/guardian_details_form.dart';
import 'package:it312_final_project/pages/loan_request.dart';
import 'package:it312_final_project/pages/profile_details.dart';
import 'package:it312_final_project/pages/requests_form.dart';
import 'package:it312_final_project/pages/student_details_form.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text('ScholarPay'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
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
}