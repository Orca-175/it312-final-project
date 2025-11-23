import 'package:it312_final_project/classes/guardian_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guardian_details_provider.g.dart';

@riverpod
class GuardianDetailsNotifier extends _$GuardianDetailsNotifier {
  @override
  GuardianDetails build(int id) {
    return GuardianDetails(id);
  }

  Future<String> submitDetails(
    String firstName,
    String lastName,
    String middleName,
    String relationship, 
    String email, 
    String phoneNumber, 
    String apartmenNumber,
    String unitNumber,
    String street,
    String barangay,
    String city,
    String region,
    String occupation,
    String empoloyer,
    String employerPhoneNumber,
    String monthlyIncome,
    String operation
  ) async {
    final details = GuardianDetails(
      state.id, 
      firstName: firstName, 
      lastName: lastName, 
      middleName: middleName, 
      relationship: relationship, 
      email: email, 
      phoneNumber: phoneNumber, 
      apartmentNumber: apartmenNumber,
      unitNumber: unitNumber,
      street: street,
      barangay: barangay,
      city: city,
      region: region,
      occupation: occupation,
      employer: empoloyer,
      employerPhoneNumber: employerPhoneNumber,
      monthlyIncome: monthlyIncome,
    );

    String success = await details.submit(operation);
    state = details;

    return success;
  }

  Future<void> getDetails() async {
    state = await GuardianDetails.fromId(state.id);
  }
}