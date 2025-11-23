import 'package:it312_final_project/classes/student_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_details_provider.g.dart';

@riverpod
class StudentDetailsNotifier extends _$StudentDetailsNotifier {
  @override
  StudentDetails build(int id) {
    return StudentDetails(id); // Initializes with globalUserAccountId from lib/globals/globals.dart
  }

  Future<String> submitDetails(
    String studentId,
    String firstName,
    String lastName,
    String middleName,
    String dateOfBirth, 
    String email, 
    String phoneNumber, 
    String apartmenNumber,
    String unitNumber,
    String street,
    String barangay,
    String city,
    String region,
    String operation
  ) async {
    final details = StudentDetails(
      state.id, 
      studentId: studentId, 
      firstName: firstName, 
      lastName: lastName, 
      middleName: middleName, 
      dateOfBirth: dateOfBirth, 
      email: email, 
      phoneNumber: phoneNumber, 
      apartmentNumber: apartmenNumber,
      unitNumber: unitNumber,
      street: street,
      barangay: barangay,
      city: city,
      region: region,
    );

    String success = await details.submit(operation);
    state = details;

    return success;
  }

  Future<void> getDetails() async {
    state = await StudentDetails.fromId(state.id);
  }
}
