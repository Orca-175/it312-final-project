import 'dart:convert';

import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';

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
  );

  static Future<StudentDetails> fromId(int id) async {
    Response response = await post(Uri.parse('localhost/$requestUrl/get_student_details.php'), body: {'id': id});
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

  static Future<String> submit(StudentDetails studentDetails) async {
    Response response = await post(Uri.parse('localhost/$requestUrl/add_student_details.php'),
      body: {
        'id': studentDetails.id,
        'fullName': studentDetails.fullName,
        'dateOfBirth': studentDetails.dateOfBirth,
        'email': studentDetails.email,
        'phoneNumber': studentDetails.phoneNumber,
        'address': studentDetails.address,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body;
  }
}