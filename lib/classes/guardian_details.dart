import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class GuardianDetails {
  int id;  
  String firstName;
  String lastName;
  String middleName; // Optional
  String relationship;
  String email;
  String phoneNumber;
  late String apartmentNumber; // Optional
  late String unitNumber;
  late String street;
  late String barangay;
  late String city;
  late String region;
  String occupation;
  String employer;
  String employerPhoneNumber;
  String monthlyIncome;


  GuardianDetails._internal(
    this.id, 
    this.firstName, 
    this.lastName, 
    this.middleName, 
    this.relationship, 
    this.email, 
    this.phoneNumber, 
    this.apartmentNumber,
    this.unitNumber,
    this.street,
    this.barangay,
    this.city,
    this.region,
    this.occupation, 
    this.employer, 
    this.employerPhoneNumber,
    this.monthlyIncome,
  );

  factory GuardianDetails(
    int id,
    {
      String firstName = '',
      String lastName= '',
      String middleName= '',
      String relationship = '',
      String email = '',
      String phoneNumber = '',
      String apartmentNumber= '',
      String unitNumber = '',
      String street = '',
      String barangay = '',
      String city = '',
      String region = '',
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
      firstName,
      lastName,
      middleName,
      relationship,
      email,
      phoneNumber,
      apartmentNumber,
      unitNumber,
      street,
      barangay,
      city,
      region,
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

    String firstName = responseData['first_name'];
    String lastName = responseData['last_name'];
    String middleName = responseData['middle_name'];
    String relationship = responseData['relationship'];
    String email = responseData['email'];
    String phoneNumber = responseData['phone_number'];
    String apartmentNumber = responseData['apartment_number'];
    String unitNumber = responseData['unit_number'];
    String street = responseData['street'];
    String barangay = responseData['barangay'];
    String city = responseData['city'];
    String region = responseData['region'];
    String occupation = responseData['occupation'];
    String employer= responseData['employer'];
    String employerPhoneNumber = responseData['employer_phone_number'];
    String monthlyIncome = responseData['monthly_income'];

    return GuardianDetails._internal(
      id, 
      firstName,
      lastName,
      middleName,  
      relationship, 
      email, 
      phoneNumber, 
      apartmentNumber,
      unitNumber,
      street,
      barangay,
      city,
      region,
      occupation, 
      employer, 
      employerPhoneNumber, 
      monthlyIncome,
    );
  }

  Future<String> submit(String operation) async {
    if (!(operation == 'add' ||  operation == 'update')) {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('$requestUrl/${operation}_guardian_details.php'),
      body: {
        'id': id.toString(),
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'relationship': relationship,
        'email': email,
        'phoneNumber': phoneNumber,
        'apartmentNumber': apartmentNumber,
        'unitNumber': unitNumber,
        'street': street,
        'barangay': barangay,
        'city': city,
        'region': region,
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

  String get fullName {
    String middleInitial = middleName == '' ? '' : '${middleName.substring(0, 1)}.';
    return '$firstName $middleInitial $lastName';
  }

  String get address {
    final tempApartmentNumber = apartmentNumber != '' ? '$apartmentNumber, ' : '';
    // ignore: prefer_interpolation_to_compose_strings
    return tempApartmentNumber + '$unitNumber $street St., $barangay, $city, $region';
  }

  bool anyEmptyFields() {
    if (
      firstName == '' || 
      lastName == '' || 
      relationship == '' || 
      email == '' || 
      phoneNumber == '' || 
      unitNumber == '' || 
      street == '' || 
      barangay == '' || 
      city == '' || 
      region == '' ||
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