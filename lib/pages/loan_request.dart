import 'package:flutter/material.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';
import 'package:go_router/go_router.dart';

class LoanRequest extends StatefulWidget {
  const LoanRequest({super.key});

  @override
  State<LoanRequest> createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoanRequestDetails(),
      ],
    );
  }
}

class LoanRequestDetails extends StatelessWidget {
  const LoanRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () { 
              context.go('/loan_request/requests_form');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Loan Request Details:', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 8.0),
                  LabeledField(data: '3-23-010', label: 'School ID'),
                  LabeledField(data: '1.0', label: 'General Weighted Average'),
                  LabeledField(data: 'P75,000', label: 'Loan Amount'),
                  LabeledField(data: 'Monthly', label: 'Payment Term'),
                  LabeledField(data: '3 Months', label: 'Payment Schedule'),
                  LabeledField(data: '3', label: 'Year'),
                  LabeledField(data: 'BSIT', label: 'Strand/Course'),
                  LabeledField(data: 'Regular', label: 'Enrollment Status'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}