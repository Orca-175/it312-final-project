import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class StudentDetails {
  int id;  
  String fullName;
  String dateOfBirth;
  String email;
  String phoneNumber;
  String address;

  StudentDetails(
    this.id, 
    this.fullName, 
    this.dateOfBirth, 
    this.email, 
    this.phoneNumber, 
    this.address
  ) {
    if (!phoneNumber.isNumeric() || phoneNumber.length > 11) {
      throw Exception('Phone Numbers must be numeric and in the 0********** format.');
    }
  }

  static Future<StudentDetails> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_student_details.php'), body: {'id': id});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String fullName = responseData['fullName'];
    String dateOfBirth = responseData['dateOfBirth'];
    String email = responseData['email'];
    String phoneNumber = responseData['phoneNumber'];
    String address = responseData['address'];

    return StudentDetails(id, fullName, dateOfBirth, email, phoneNumber, address);
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
}