import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class StudentDetails {
  late final int id;  
  late String fullName;
  late String dateOfBirth;
  late String email;
  late String phoneNumber;
  late String address;

  StudentDetails._internal(
    this.id, 
    {
      required this.fullName, 
      required this.dateOfBirth, 
      required this.email, 
      required this.phoneNumber, 
      required this.address
    }
  );

  factory StudentDetails(
    int id, 
    {
      String fullName = '', 
      String dateOfBirth = '', 
      String email = '', 
      String phoneNumber = '', 
      String address = '',
    }
  ) {
    if (phoneNumber != '' && (!phoneNumber.isNumeric() || phoneNumber.length > 11)) {
      throw Exception('Phone Numbers must be numeric and in the 0********** format.');
    }

    return StudentDetails._internal(
      id,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  static Future<StudentDetails> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_student_details.php'), body: {'id': id.toString()});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String fullName = responseData['full_name'];
    String dateOfBirth = responseData['date_of_birth'];
    String email = responseData['email'];
    String phoneNumber = responseData['phone_number'];
    String address = responseData['address'];

    return StudentDetails._internal(
      id,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  Future<String> submit(String operation) async {
    if (operation != 'add' || operation != 'update') {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('$requestUrl/${operation}_student_details.php'),
      body: {
        'id': id,
        'fullName': fullName,
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

  bool anyEmptyFields() {
    if (fullName == '' || dateOfBirth == '' || email == '' || phoneNumber == '' || address == '') {
      return true;
    }
    
    return false;
  }
}