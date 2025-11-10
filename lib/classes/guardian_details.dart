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


  GuardianDetails._internal(
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
  );

  factory GuardianDetails(
    int id,
    {
      String fullName = '',
      String relationship = '',
      String email = '',
      String phoneNumber = '',
      String address = '',
      String occupation = '',
      String employer = '',
      String employerPhoneNumber = '',
      String monthlyIncome = '',
    }
  ) {
    if (phoneNumber != '' && (!phoneNumber.isNumeric() || !employerPhoneNumber.isNumeric() || 
        phoneNumber.length > 11 || employerPhoneNumber.length > 11)) {
      throw Exception('Phone numbers must be numeric and, at most, 11 digits long.');
    } else if (monthlyIncome != '' && !monthlyIncome.isNumeric()) {
      throw Exception('Monthly Income must be numeric.');
    }

    return GuardianDetails._internal(
      id,
      fullName,
      relationship,
      email,
      phoneNumber,
      address,
      occupation,
      employer,
      employerPhoneNumber,
      monthlyIncome,
    );
  }

  static Future<GuardianDetails> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_guardian_details.php'), body: {'id': id.toString()});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String fullName = responseData['full_name'];
    String relationship = responseData['relationship'];
    String email = responseData['email'];
    String phoneNumber = responseData['phone_number'];
    String address = responseData['address'];
    String occupation = responseData['occupation'];
    String employer= responseData['employer'];
    String employerPhoneNumber = responseData['employer_phone_number'];
    String monthlyIncome = responseData['monthly_income'];

    return GuardianDetails._internal(
      id, 
      fullName,  
      relationship, 
      email, 
      phoneNumber, 
      address, 
      occupation, 
      employer, 
      employerPhoneNumber, 
      monthlyIncome,
    );
  }

  Future<String> submit(String operation) async {
    if (operation != 'add' || operation != 'update') {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('$requestUrl/${operation}_guardian_details.php'),
      body: {
        'id': id.toString(),
        'full_name': fullName,
        'relationship': relationship,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,
        'occupation': occupation,
        'employer': employer,
        'employer_phone_number': employerPhoneNumber,
        'monthly_income': monthlyIncome,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body;
  }

  bool anyEmptyFields() {
    if (
      fullName == '' || 
      relationship == '' || 
      email == '' || 
      phoneNumber == '' || 
      address == '' || 
      occupation == '' ||
      employer == '' ||
      employerPhoneNumber == '' ||
      monthlyIncome == ''
    ) {
      return true;
    }

    return false;
  }
}