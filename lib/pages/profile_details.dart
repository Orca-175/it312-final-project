import 'package:flutter/material.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StudentDetails(),
        GuardianDetails(),
      ],
    );
  }
}

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () { 

            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Student Details:', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 8.0),
                  LabeledField(data: 'Stephen Gabriel L. Orca', label: 'Name'),
                  LabeledField(data: '2004-12-17', label: 'Date of Birth'),
                  LabeledField(data: 'sglorca@dbtcmandaluyong.one-bosco.org', label: 'Email'),
                  LabeledField(data: '09999999999', label: 'Phone'),
                  LabeledField(data: 'Mandaluyong City, Metro Manila', label: 'Address')
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GuardianDetails extends StatelessWidget {
  const GuardianDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Guardian Details:', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 8.0),
                  LabeledField(data: 'Raphael Owen T. Oduya', label: 'Name'),
                  LabeledField(data: 'Mother', label: 'Relationship'),
                  LabeledField(data: 'rotoduya@dbtcmandaluyong.one-bosco.org', label: 'Email'),
                  LabeledField(data: '09999999999', label: 'Phone'),
                  LabeledField(data: 'Mandaluyong City, Metro Manila', label: 'Address'),
                  LabeledField(data: 'Ninja', label: 'Occupation'),
                  LabeledField(data: 'P50,000', label: 'Monthly Income'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

