import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/requests_provider.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/widgets/root_card_clickable.dart';
import 'package:it312_final_project/widgets/root_column.dart';

class LoanRequest extends ConsumerStatefulWidget {
  const LoanRequest({super.key});

  @override
  ConsumerState<LoanRequest> createState() => _LoanRequestState();
}

class _LoanRequestState extends ConsumerState<LoanRequest> {
  String requestDetailsError = '';

  @override
  void initState() {
    super.initState();
    getRequestDetails();
  }

  Future<void> getRequestDetails() async {
    await ref.read(requestsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((error) {
        setState(() {
          requestDetailsError = error.toString().removeExceptionPrefix();
        });
      });

    return;
  }

  @override
  Widget build(BuildContext context) {
    final requestDetails = ref.watch(requestsProvider(globalUserAccountId));

    return RefreshIndicator(
      onRefresh: () async => await getRequestDetails(),
      child: ListView(
        children: [
          RootCardClickable(
            onTap: () => context.go('/loan_request/requests_form'), 
            child: RootColumn(
              header: 'Loan Request Details', 
              children: [
                if (requestDetails.anyEmptyFields()) ...[
                  Text(requestDetailsError, textAlign: TextAlign.center),
                ] else ...[
                  LabeledField(data: requestDetails.generalWeightedAverage.toString(), label: 'General Weighted Average'),
                  LabeledField(
                    data: '₱${requestDetails.loanAmount.seperateNumberByThousands()}', 
                    label: 'Loan Amount'
                  ),
                  LabeledField(data: requestDetails.paymentTerm, label: 'Payment Term'),
                  LabeledField(data: requestDetails.paymentSchedule, label: 'Payment Schedule'),
                  if (requestDetails.paymentNextDue != null) ...[
                    LabeledField(data: requestDetails.paymentNextDue!, label: 'Payment Due Date'),
                  ],
                  LabeledField(data: requestDetails.enrollmentStatus, label: 'Enrollment Status'),
                ]
              ],
            ),
          ),
        ],
      ),
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