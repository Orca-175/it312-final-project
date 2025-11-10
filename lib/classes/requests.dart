import 'dart:convert';
import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';

class Requests {
  int id;
  String studentId;
  double generalWeightedAverage;
  String loanAmount;
  String paymentTerm;
  String paymentSchedule;
  String gradeLevel;
  String course;
  String enrollmentStatus;

  String? paymentNextDue;
  String? requestStatus;

  Requests._internal(
    this.id,
    this.studentId, 
    this.generalWeightedAverage,
    this.loanAmount,
    this.paymentTerm,
    this.paymentSchedule,
    this.gradeLevel,
    this.course,
    this.enrollmentStatus,
    this.paymentNextDue, 
    this.requestStatus,
  );

  factory Requests(
    int id,
    {
      String studentId = '',
      double generalWeightedAverage = 0.0,
      String loanAmount = '',
      String paymentTerm = '',
      String paymentSchedule = '',
      String gradeLevel = '',
      String course = '',
      String enrollmentStatus = '',
      String? paymentNextDue,
      String? requestStatus,
    }
  ) {
    if (studentId != '' && !Requests._isValidSchoolId(studentId)) {
      throw Exception('Invalid Student ID.');
    }

    if (generalWeightedAverage != 0.0) {
      if (generalWeightedAverage > 5 && !(generalWeightedAverage > 75 && generalWeightedAverage <= 100)) {
        throw Exception('Invalid General Weighted Average.');
      } else if (generalWeightedAverage < 75 && !(generalWeightedAverage > 1 && generalWeightedAverage <= 5)) {
        throw Exception('Invalid General Weighted Average.');
      }
    }

    return Requests._internal(
      id,
      studentId,
      generalWeightedAverage,
      loanAmount,
      paymentTerm,
      paymentSchedule,
      gradeLevel,
      course,
      enrollmentStatus,
      paymentNextDue,
      requestStatus,
    ); 
  }

  static Future<Requests> fromId(int id) async {
    Response response = await post(Uri.parse('$requestUrl/get_requests.php'), body: {'id': id.toString()}); 
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map responseData = jsonDecode(response.body);

    String studentId = responseData['student_id'];
    double generalWeightedAverage = double.parse(responseData['general_weighted_average'].toString());
    String loanAmount = responseData['loan_amount'].toString();
    String paymentTerm = responseData['payment_term'];
    String paymentSchedule = responseData['payment_schedule'];
    String gradeLevel = responseData['grade_level'].toString();
    String course = responseData['course'];
    String enrollmentStatus = responseData['enrollment_status'];
    String? paymentNextDue = responseData['payment_next_due'];
    String? requestStatus = responseData['request_status'];

    return Requests(
      id,
      studentId: studentId,
      generalWeightedAverage: generalWeightedAverage,
      loanAmount: loanAmount,
      paymentTerm: paymentTerm,
      paymentSchedule: paymentSchedule,
      gradeLevel: gradeLevel,
      course: course,
      enrollmentStatus: enrollmentStatus,
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
        'id': id.toString(),
        'studentId': studentId,
        'generalWeightedAverage': generalWeightedAverage.toString(),
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

  bool anyEmptyFields() {
    if (
      studentId == '' ||
      generalWeightedAverage == 0.0 ||
      loanAmount == '' ||
      paymentTerm == '' ||
      paymentSchedule == '' ||
      gradeLevel == '' ||
      course == '' ||
      enrollmentStatus == ''
    ) {
      return true;
    }

    return false;
  }

  static bool verifyLoanAmount(int generalWeightedAverage, int loanAmount) {
    if (generalWeightedAverage <= 1.25 && loanAmount <= 75000) {
        return true;
    } else if (generalWeightedAverage <= 1.75 && loanAmount <= 60000) {
        return true;
    } else if (generalWeightedAverage <= 2 && loanAmount <= 50000) {
        return true;
    } else if (generalWeightedAverage <= 2.25 && loanAmount <= 40000) {
        return true;
    } else if (generalWeightedAverage <= 2.5 && loanAmount <= 30000) {
        return true;
    } else if (generalWeightedAverage <= 2.75 && loanAmount <= 15000) {
        return true;
    } else if (generalWeightedAverage <= 3 && loanAmount <= 10000) {
        return true;
    }
    return false;
}

  static double shsGwaToCollegeGwaRange(double generalWeightedAverage) {
    if (generalWeightedAverage > 5) {
        if (generalWeightedAverage >= 75 && generalWeightedAverage < 79) {
            return 3;
        } else if (generalWeightedAverage >= 79 && generalWeightedAverage < 82) {
            return 2.75;
        } else if (generalWeightedAverage >= 82 && generalWeightedAverage < 85) {
            return 2.5;
        } else if (generalWeightedAverage >= 85 && generalWeightedAverage < 88) {
            return 2;
        } else if (generalWeightedAverage >= 88 && generalWeightedAverage < 91) {
            return 1.75;
        } else if (generalWeightedAverage >= 91 && generalWeightedAverage < 94) {
            return 1.5;
        } else if (generalWeightedAverage >= 94 && generalWeightedAverage < 97) {
            return 1.25;
        } else if (generalWeightedAverage >= 97 && generalWeightedAverage <= 100) {
            return 1;
        }
    }
    return generalWeightedAverage;
  }

  static bool _isValidSchoolId(String schoolId) {
    return RegExp(r'^[1-9]-\d{2}-\d{3}$').hasMatch(schoolId);
  }
}

