import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';

class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  @override
  ConsumerState<Test> createState() => _TestState();
}

class _TestState extends ConsumerState<Test> {
  @override
  void initState() {
    super.initState();
    ref.read(studentDetailsProvider(globalUserAccountId).notifier).requestStudentDetails(globalUserAccountId);
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = ref.watch(studentDetailsProvider(globalUserAccountId));

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80.0),
          Text('Test', style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 8.0),
          Text('Name: ${studentDetails.fullName}'),
          Text('Date of Birth: ${studentDetails.dateOfBirth}'),
          Text('Email: ${studentDetails.email}'),
          Text('Phone Number: ${studentDetails.phoneNumber}'),
          Text('Address: ${studentDetails.address}'),
        ],
      ),
    );
  }
}
