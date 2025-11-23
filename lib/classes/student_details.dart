import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class StudentDetails {
  late final int id;  
  late String studentId;
  late String firstName;
  late String lastName;
  late String middleName; // Optional
  late String dateOfBirth;
  late String email;
  late String phoneNumber;
  late String apartmentNumber; // Optional
  late String unitNumber;
  late String street;
  late String barangay;
  late String city;
  late String region;

  StudentDetails._internal(
    this.id, 
    this.studentId, 
    this.firstName, 
    this.lastName, 
    this.middleName, 
    this.dateOfBirth, 
    this.email, 
    this.phoneNumber, 
    this.apartmentNumber,
    this.unitNumber,
    this.street,
    this.barangay,
    this.city,
    this.region,
  );

  factory StudentDetails(
    int id, 
    {
      String studentId = '', 
      String firstName= '', 
      String lastName= '', 
      String middleName = '', 
      String dateOfBirth = '', 
      String email = '', 
      String phoneNumber = '', 
      String apartmentNumber= '',
      String unitNumber = '',
      String street = '',
      String barangay = '',
      String city = '',
      String region = '',
    }
  ) {
    if (studentId != '' && !StudentDetails.isValidSchoolId(studentId)) {
      throw Exception(studentIdFormatError);
    }
    if (phoneNumber != '' && (!phoneNumber.isNumeric() || phoneNumber.length > 11)) {
      throw Exception(phoneNumberFormatError);
    }
    if (email != '' && !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      throw Exception(emailFormatError);
    }

    return StudentDetails._internal(
      id,
      studentId,
      firstName,
      lastName,
      middleName,
      dateOfBirth,
      email,
      phoneNumber,
      apartmentNumber,
      unitNumber,
      street,
      barangay,
      city,
      region,
    );
  }

  static Future<StudentDetails> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_student_details.php'), body: {'id': id.toString()});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String studentId= responseData['student_id'];
    String firstName = responseData['first_name'];
    String lastName = responseData['last_name'];
    String middleName = responseData['middle_name'];
    String dateOfBirth = responseData['date_of_birth'];
    String email = responseData['email'];
    String phoneNumber = responseData['phone_number'];
    String apartmentNumber = responseData['apartment_number'];
    String unitNumber = responseData['unit_number'];
    String street = responseData['street'];
    String barangay = responseData['barangay'];
    String city = responseData['city'];
    String region = responseData['region'];

    return StudentDetails._internal(
      id,
      studentId,
      firstName,
      lastName,
      middleName,
      dateOfBirth,
      email,
      phoneNumber,
      apartmentNumber,
      unitNumber,
      street,
      barangay,
      city,
      region,
    );
  }

  Future<String> submit(String operation) async {
    if (!(operation == 'add' ||  operation == 'update')) {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('$requestUrl/${operation}_student_details.php'),
      body: {
        'id': id.toString(),
        'studentId': studentId,
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'phoneNumber': phoneNumber,
        'apartmentNumber': apartmentNumber,
        'unitNumber': unitNumber,
        'street': street,
        'barangay': barangay,
        'city': city,
        'region': region,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body;
  }

  String get fullName {
    final middleInitial = middleName == '' ? '' : '${middleName.substring(0, 1)}.'; 
    return '$firstName $middleInitial $lastName';
  }

  String get address {
    final tempApartmentNumber = apartmentNumber != '' ? '$apartmentNumber, ' : '';
    // ignore: prefer_interpolation_to_compose_strings
    return tempApartmentNumber + '$unitNumber $street St., $barangay, $city, $region';
  }

  bool anyEmptyFields() {
    if (id == 0 || studentId == '' || firstName == '' || lastName == '' || middleName == '' || dateOfBirth == '' || 
      email == '' || phoneNumber == '' || unitNumber == '' || street == '' || barangay == '' || city == '' || 
      region == '') {
        return true;
    }
    
    return false;
  }

  static bool isValidSchoolId(String schoolId) {
    return RegExp(r'^[1-9]-\d{2}-\d{3}$').hasMatch(schoolId);
  }
}