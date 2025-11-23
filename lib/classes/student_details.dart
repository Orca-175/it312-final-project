import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class StudentDetails {
  late final int id;  
  late String studentId;
  late String firstName;
  late String lastName;
  late String middleName;
  late String dateOfBirth;
  late String email;
  late String phoneNumber;
  late String address;

  StudentDetails._internal(
    this.id, 
    this.studentId, 
    this.firstName, 
    this.lastName, 
    this.middleName, 
    this.dateOfBirth, 
    this.email, 
    this.phoneNumber, 
    this.address
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
      String address = '',
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
      address,
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
    String address = responseData['address'];

    return StudentDetails._internal(
      id,
      studentId,
      firstName,
      lastName,
      middleName,
      dateOfBirth,
      email,
      phoneNumber,
      address,
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
        'address': address,
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

  bool anyEmptyFields() {
    if (id == 0 || studentId == '' || firstName == '' || lastName == '' || middleName == '' || dateOfBirth == '' || 
      email == '' || phoneNumber == '' || address == '') {
        return true;
    }
    
    return false;
  }

  static bool isValidSchoolId(String schoolId) {
    return RegExp(r'^[1-9]-\d{2}-\d{3}$').hasMatch(schoolId);
  }
}