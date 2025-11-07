import 'dart:convert';

import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';

class Requests {
  int id;
  String studentId;
  String generalWeightedAverage;
  String loanAmount;
  String paymentTerm;
  String paymentSchedule;
  String gradeLevel;
  String course;
  String enrollmentStatus;

  String? paymentNextDue;
  String? requestStatus;

  Requests(
    this.id,
    this.studentId, 
    this.generalWeightedAverage,
    this.loanAmount,
    this.paymentTerm,
    this.paymentSchedule,
    this.gradeLevel,
    this.course,
    this.enrollmentStatus,
    {this.paymentNextDue, this.requestStatus}
  );

  static Future<Requests> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_requests.php'), body: {'id': id}); 
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map data = jsonDecode(response.body);

    String studentId = data['studentId'];
    String generalWeightedAverage = data['generalWeightedAverage'];
    String loanAmount = data['loanAmount'];
    String paymentTerm = data['paymentTerm'];
    String paymentSchedule = data['paymentSchedule'];
    String gradeLevel = data['gradeLevel'];
    String course = data['course'];
    String enrollmentStatus = data['enrollmentStatus'];
    String paymentNextDue = data['paymentNextDue'];
    String requestStatus = data['requestStatus'];

    return Requests(
      id,
      studentId,
      generalWeightedAverage,
      loanAmount,
      paymentTerm,
      paymentSchedule,
      gradeLevel,
      course,
      enrollmentStatus,
      paymentNextDue: paymentNextDue,
      requestStatus: requestStatus,
    );
  }

  Future<String> submit(String operation) async {
    if (operation != 'add' || operation != 'update') {
      throw Exception('Parameter:operation must be set to either "add" or "update".');
    }
    Response response = await post(Uri.parse('localhost/$requestUrl/${operation}_requests.php'),
      body: {
        'id': id,
        'studentId': studentId,
        'generalWeightedAverage': generalWeightedAverage,
        'loanAmount': loanAmount,
        'paymentTerm': paymentTerm,
        'paymentSchedule': paymentSchedule,
        'gradeLevel': gradeLevel,
        'course': course,
        'enrollmentStatus': enrollmentStatus,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body;
  }
}

