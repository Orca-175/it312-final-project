import 'package:flutter/material.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:  [
        // Profile Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Profile:', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 12.0),
                Column(
                  children: [
                    // Student Details Summary
                    StudentInfo(),
                    SizedBox(height: 30.0),
                    // Guardian Details Summary
                    GuardianInfo(),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Request Status Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Request Status:', style: TextStyle(fontSize: 20.0)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NoRequestPlaceholder(),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomLabeledHeader(data: 'Stephen Gabriel L. Orca', label: 'Student'),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              child: Column(
                children: [
                  LabeledField(data: '3-23-010', label: 'School ID'),
                  LabeledField(data: '3', label: 'Year'),
                  LabeledField(data: 'BSIT', label: 'Strand/Course'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GuardianInfo extends StatelessWidget {
  const GuardianInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomLabeledHeader(data: 'Raphael Owen T. Oduya', label: 'Guardian'),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              child: Column(
                children: [
                  LabeledField(data: 'Mother', label: 'Relationship'),
                  LabeledField(data: 'Ninja', label: 'Occupation'),
                  LabeledField(data: 'P50,000', label: 'Monthly Income'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BottomLabeledHeader extends StatelessWidget {
  final String data;
  final String label;
  const BottomLabeledHeader({super.key, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data, style: TextStyle(fontSize: 20.0)),
        Text(label),
      ],
    );
  }
}

class ApprovedRequestPlaceholder extends StatelessWidget {
  const ApprovedRequestPlaceholder({super.key});

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
            Text('Your request has been approved!'),
            SizedBox(height: 30.0),
            Text('Your next payment of P60,000 is due on:'),
            Text('2025-11-20', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}

class RejectedRequestPlaceholder extends StatelessWidget {
  const RejectedRequestPlaceholder({super.key});

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

class NoRequestPlaceholder extends StatelessWidget {
  const NoRequestPlaceholder({super.key});

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
            Text('You have yet to make a loan request. Complete your profile and head to the Loan Request tab!', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}