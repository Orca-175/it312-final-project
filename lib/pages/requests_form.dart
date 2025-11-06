import 'package:flutter/material.dart';

class RequestsForm extends StatefulWidget {
  const RequestsForm({super.key});

  @override
  State<RequestsForm> createState() => _RequestsFormState();
}

class _RequestsFormState extends State<RequestsForm> {
  double _loanAmount = 10000.0;
  final Map<String, String> _paymentTermOptions = {
    'Monthly': 'monthly',
    'Full Payment': 'full',
  };

  final Map<String, String> _paymentScheduleOptions = {
    '3 Months': '3m',
    '6 Months': '6m',
    '12 Months': '12m',
  };

  final Map<String, String> _enrollmentStatusOptions = {
    'Regular': 'regular',
    'Irregular': 'irregular',
  };

  String? _paymentTerm;
  String? _paymentSchedule;
  String? _enrollmentStatus;
 
 
  @override
  Widget build(BuildContext context) { 
    return Center(
      child: SizedBox(
        width: 300.0,
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Text('Requests Details', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                decoration: InputDecoration(label: Text('General Weighted Average')),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text('Loan Amount', style: TextStyle(fontSize: 16.0),),
                  Slider(
                    value: _loanAmount,
                    onChanged: (value) {
                      setState(() {
                        _loanAmount = value;
                      });
                    },
                    min: 10000.0,
                    max: 75000.0,
                    divisions: 130,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(_loanAmount.round().toString())),
                      Text('75000'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              DropdownButtonFormField(
                decoration: InputDecoration(label: Text('Payment Term')),
                items: _paymentTermOptions.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentTerm = value;
                  });
                }
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(label: Text('Payment Schedule')),
                items: _paymentScheduleOptions.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentSchedule = value;
                  });
                }
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Year')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Strand/Course')),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(label: Text('Enrollment Status')),
                items: _enrollmentStatusOptions.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _enrollmentStatus = value;
                  });
                }
              ),
              SizedBox(height: 24.0),
              FilledButton(
                onPressed: () {}, 
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}