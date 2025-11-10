import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/guardian_details_provider.dart';
import 'package:it312_final_project/providers/requests_provider.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';

class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  @override
  ConsumerState<Test> createState() => _TestState();
}

class _TestState extends ConsumerState<Test> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    // Get StudentDetails from database if it exists, set errorMessage otherwise
    ref.read(studentDetailsProvider(globalUserAccountId).notifier)
      .getDetails(globalUserAccountId)
      .catchError((error) {
        setState(() {
          errorMessage = '$errorMessage\n${error.toString()}';
        });
      });

    // Get GuardianDetails from database if it exists, set errorMessage otherwise
    ref.read(guardianDetailsProvider(globalUserAccountId).notifier)
      .getDetails(globalUserAccountId)
      .catchError((error) {
        setState(() {
          errorMessage = '$errorMessage\n${error.toString()}';
        });
      });

    // Get Requests from database if it exists, set errorMessage otherwise
    ref.read(requestsProvider(globalUserAccountId).notifier)
      .getDetails(globalUserAccountId)
      .catchError((error) {
        setState(() {
          errorMessage = '$errorMessage ${error.toString()}';
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = ref.watch(studentDetailsProvider(globalUserAccountId));
    final guardianDetails = ref.watch(guardianDetailsProvider(globalUserAccountId));
    final request = ref.watch(requestsProvider(globalUserAccountId));

    if (errorMessage != '') {
      return _RootColumn(
        children: [
          const SizedBox(height: 80.0),
          const Text('Error', style: TextStyle(fontSize: 20.0)),
          const SizedBox(height: 8.0),
          Text(errorMessage),
        ],
      );
    }

    return _RootColumn(
      children: [
        const SizedBox(height: 40.0),
        const Text('Test Widget', style: TextStyle(fontSize: 20.0)),
        if (!studentDetails.anyEmptyFields())
          ...[
            const SizedBox(height: 16.0),
            const Text('Student Details', style: TextStyle(fontSize: 20.0)),
            Text('Name: ${studentDetails.fullName}'),
            Text('Date of Birth: ${studentDetails.dateOfBirth}'),
            Text('Email: ${studentDetails.email}'),
            Text('Phone Number: ${studentDetails.phoneNumber}'),
            Text('Address: ${studentDetails.address}'),
          ],
        if (!guardianDetails.anyEmptyFields())
          ...[
            const SizedBox(height: 16.0),
            const Text('Guardian Details', style: TextStyle(fontSize: 20.0)),
            Text('Name: ${guardianDetails.fullName}'),
            Text('Relationship: ${guardianDetails.relationship}'),
            Text('Email: ${guardianDetails.email}'),
            Text('Phone Number: ${guardianDetails.phoneNumber}'),
            Text('Address: ${guardianDetails.address}'),
            Text('Occupation: ${guardianDetails.occupation}'),
            Text('Employer: ${guardianDetails.employer}'),
            Text('Employer Phone Number: ${guardianDetails.employerPhoneNumber}'),
            Text('Monthly Income: ${guardianDetails.monthlyIncome}'),
          ],
        if (!request.anyEmptyFields())
          ...[
            const SizedBox(height: 16.0),
            const Text('Loan Request Details', style: TextStyle(fontSize: 20.0)),
            Text('Studend ID: ${request.studentId}'),
            Text('GWA: ${request.generalWeightedAverage}'),
            Text('Loan Amount: ${request.loanAmount}'),
            Text('Payment Term: ${request.paymentTerm}'),
            Text('Payment Schedule: ${request.paymentSchedule}'),
            Text('Year: ${request.gradeLevel}'),
            Text('Strand/Course: ${request.course}'),
            Text('Enrollment Status: ${request.enrollmentStatus}'),
          ],
      ],
    );
  }
}

class _RootColumn extends StatelessWidget {
  final List<Widget> children;
  const _RootColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ...children,
        ],
      ),
    );
  }
}