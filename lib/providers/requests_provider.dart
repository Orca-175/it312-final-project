import 'dart:io';

import 'package:it312_final_project/classes/requests.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'requests_provider.g.dart';

@riverpod
class RequestsNotifier extends _$RequestsNotifier {
  @override
  Requests build(int id) {
    return Requests(id); // Initializes with globalUserAccountId from lib/globals/globals.dart
  }

  Future<String> submitDetails(
    double generalWeightedAverage,
    File? reportCard,
    String loanAmount,
    String paymentTerm,
    String paymentSchedule,
    String gradeLevel,
    String course,
    String enrollmentStatus,
    String operation
  ) async {
    final details = Requests(
      state.id, 
      generalWeightedAverage: generalWeightedAverage,
      reportCard: reportCard,
      loanAmount: loanAmount,
      paymentTerm: paymentTerm,
      paymentSchedule: paymentSchedule,
      gradeLevel: gradeLevel,
      course: course,
      enrollmentStatus: enrollmentStatus,
    );

    final success = await details.submit(operation);
    state = details;
    getDetails();

    return success;
  }

  Future<void> getDetails() async {
    state = await Requests.fromId(state.id);
  }
}
