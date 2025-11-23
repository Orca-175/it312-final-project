import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/guardian_details_provider.dart';
import 'package:it312_final_project/providers/requests_provider.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';
import 'package:it312_final_project/widgets/root_card.dart';
import 'package:it312_final_project/widgets/root_column.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  String studentDetailsError = '';
  String guardianDetailsError = '';
  bool requestHasLoaded = false;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    await ref.read(studentDetailsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((error) {
        setState(() {
          studentDetailsError = error.toString().removeExceptionPrefix(); // Will be displayed to user if not found.
        });
      });  

    await ref.read(guardianDetailsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((error) {
        setState(() {
          guardianDetailsError = error.toString().removeExceptionPrefix(); // Will be displayed to user if not found.
        });
      });  

    await ref.read(requestsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((_) {
        setState(() {
          requestHasLoaded = true; // Request has its own way showing it hasn't been found.
        });
      }); 
    
    return; 
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = ref.watch(studentDetailsProvider(globalUserAccountId));
    final guardianDetails = ref.watch(guardianDetailsProvider(globalUserAccountId));
    final requestDetails = ref.watch(requestsProvider(globalUserAccountId));
    Widget request = Text('');

    if (requestDetails.anyEmptyFields() && requestHasLoaded) {
      request = _NoRequest(); // Checks if request has been loaded so the user doesn't see _NoRequest beforehand.
    } else if (requestDetails.requestStatus == 'pending') {
      request = _PendingRequest();
    } else if (requestDetails.requestStatus == 'rejected') {
      request = _RejectedRequest();
    } else if (requestDetails.requestStatus == 'approved') {
      request = _ApprovedRequest(
        amountDue: requestDetails.getAmountDue(), 
        date: requestDetails.paymentNextDue!,
      );
    }

    return RefreshIndicator(
      onRefresh: () async => await getUserDetails(),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              RootCard(
                child: RootColumn(
                  header: 'Profile', 
                  children: [
                    if (studentDetails.anyEmptyFields()) ...[
                      Text(studentDetailsError, textAlign: TextAlign.center),
                    ] else ...[
                      _ProfileDetails(
                        label: 'Student',
                        name: studentDetails.fullName, 
                        children: [
                          LabeledField(data: studentDetails.studentId, label: 'Student ID'),
                          if (!requestDetails.anyEmptyFields()) ...[
                            LabeledField(data: requestDetails.gradeLevel, label: 'Year'),
                            LabeledField(data: requestDetails.course, label: 'Strand/Course'),
                          ],
                          LabeledField(data: studentDetails.email, label: 'Email'),
                          LabeledField(data: studentDetails.phoneNumber, label: 'Phone Number'),
                        ],
                      ),
                    ],
                    Divider(height: 30.0),
                    if (guardianDetails.anyEmptyFields()) ...[
                      Text(guardianDetailsError, textAlign: TextAlign.center),
                    ] else ...[
                      _ProfileDetails(
                        label: 'Guardian',
                        name: guardianDetails.fullName, 
                        children: [
                          LabeledField(data: guardianDetails.relationship, label: 'Relationship'),
                          LabeledField(data: guardianDetails.occupation, label: 'Occupation'),
                          LabeledField(
                            data: '₱${guardianDetails.monthlyIncome.seperateNumberByThousands()}', 
                            label: 'Monthly Income',
                          ),
                          LabeledField(data: guardianDetails.email, label: 'Email'),
                          LabeledField(data: guardianDetails.phoneNumber, label: 'Phone Number'),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              RootCard(
                child: RootColumn(
                  header: 'Request Status',
                  children: [
                    request,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final String label;
  final String name;
  final List<Widget> children;

  const _ProfileDetails({required this.label, required this.name, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BottomLabeledHeader(data: name, label: label),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  ...children,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BottomLabeledHeader extends StatelessWidget {
  final String data;
  final String label;
  const _BottomLabeledHeader({required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data, style: const TextStyle(fontSize: 20.0)),
        Text(label),
      ],
    );
  }
}

class _ApprovedRequest extends StatelessWidget {
  final String amountDue;
  final String date;
  const _ApprovedRequest({required this.amountDue, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Your request has been approved!'),
            const SizedBox(height: 20.0),
            Text('Your next payment of ₱${amountDue.seperateNumberByThousands()} is due on:'),
            Text(date, style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}

class _RejectedRequest extends StatelessWidget {
  const _RejectedRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Your request has been rejected.'),
          ],
        ),
      ),
    );
  }
}

class _PendingRequest extends StatelessWidget {
  const _PendingRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Your loan request has been submitted.', 
              textAlign: TextAlign.center,
            ),
            const Text(
              'Your request status will be updated here once we review it!', 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoRequest extends StatelessWidget {
  const _NoRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('You have yet to make a loan request.', textAlign: TextAlign.center),
            const Text('Complete your profile and head to the Loan Request tab!', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}