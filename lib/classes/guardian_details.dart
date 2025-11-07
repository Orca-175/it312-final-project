import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class GuardianDetails {
  int id;  
  String fullName;
  String relationship;
  String email;
  String phoneNumber;
  String address;
  String occupation;
  String employer;
  String employerPhoneNumber;
  String monthlyIncome;

  GuardianDetails(
    this.id, 
    this.fullName, 
    this.relationship, 
    this.email, 
    this.phoneNumber, 
    this.address,
    this.occupation, 
    this.employer, 
    this.employerPhoneNumber,
    this.monthlyIncome,
  ) {
    if (!phoneNumber.isNumeric() || !employerPhoneNumber.isNumeric() || 
        phoneNumber.length > 11 || employerPhoneNumber.length > 11) {
      throw Exception('Phone Numbers must be numeric and in the 0********** format.');
    } else if (!monthlyIncome.isNumeric()) {
      throw Exception('Monthly Income must be numeric.');
    }
  }

  static Future<GuardianDetails> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_guardian_details.php'), body: {'id': id});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String fullName = responseData['fullName'];
    String relationship = responseData['relationship'];
    String email = responseData['email'];
    String phoneNumber = responseData['phoneNumber'];
    String address = responseData['address'];
    String occupation = responseData['occupation'];
    String employer= responseData['employer'];
    String employerPhoneNumber = responseData['employerPhoneNumber'];
    String monthlyIncome = responseData['monthlyIncome'];

    return GuardianDetails(
      id, 
      fullName, 
      relationship, 
      email, 
      phoneNumber, 
      address, 
      occupation, 
      employer, 
      employerPhoneNumber, 
      monthlyIncome
    );
  }

  Future<String> submit(String operation) async {
    if (operation != 'add' || operation != 'update') {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('$requestUrl/${operation}_guardian_details.php'),
      body: {
        'id': id,
        'fullName': fullName,
        'relationship': relationship,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'occupation': occupation,
        'employer': employer,
        'employerPhoneNumber': employerPhoneNumber,
        'monthlyIncome': monthlyIncome,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body;
  }
}