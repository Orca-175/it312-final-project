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
    String address,
    String occupation,
    String empoloyer,
    String employerPhoneNumber,
    String monthlyIncome,
    String operation
  ) async {
    state = GuardianDetails(
      state.id, 
      firstName: firstName, 
      lastName: lastName, 
      middleName: middleName, 
      relationship: relationship, 
      email: email, 
      phoneNumber: phoneNumber, 
      address: address,
      occupation: occupation,
      employer: empoloyer,
      employerPhoneNumber: employerPhoneNumber,
      monthlyIncome: monthlyIncome,
    );

    return await state.submit(operation);
  }

  Future<void> getDetails() async {
    state = await GuardianDetails.fromId(state.id);
  }
}