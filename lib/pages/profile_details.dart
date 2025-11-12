import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:it312_final_project/extensions/string_utilities.dart';
import 'package:it312_final_project/globals/globals.dart';
import 'package:it312_final_project/providers/guardian_details_provider.dart';
import 'package:it312_final_project/providers/student_details_provider.dart';
import 'package:it312_final_project/widgets/labeled_field.dart';
import 'package:it312_final_project/widgets/root_card_clickable.dart';
import 'package:it312_final_project/widgets/root_column.dart';

class ProfileDetails extends ConsumerStatefulWidget {
  const ProfileDetails({super.key});

  @override
  ConsumerState<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends ConsumerState<ProfileDetails> {
  String studentDetailsError = '';
  String guardianDetailsError = '';

  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }

  Future<void> getProfileDetails() async {
    await ref.read(studentDetailsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((error) {
        setState(() {
          studentDetailsError = error.toString().removeExceptionPrefix(); // Will be displayed to user if not found.
        });
      });  

    await ref.read(guardianDetailsProvider(globalUserAccountId).notifier)
      .getDetails()
      .catchError((error) {
        setState(() {
          guardianDetailsError = error.toString().removeExceptionPrefix(); // Will be displayed to user if not found.
        });
      });

    return;  
  }

  @override
  Widget build(BuildContext context) {
    final studentDetails = ref.watch(studentDetailsProvider(globalUserAccountId));
    final guardianDetails = ref.watch(guardianDetailsProvider(globalUserAccountId));

    return RefreshIndicator(
      onRefresh: () async => await getProfileDetails(),
      child: ListView(
        children: [
          Column(
            children: [
              RootCardClickable(
                onTap: () => context.go('/profile_details/student_details_form'),
                child: RootColumn(
                  header: 'Student Details',
                  children: [
                    if (studentDetails.anyEmptyFields()) ...[
                      Text(studentDetailsError, textAlign: TextAlign.center),
                    ] else ...[
                      LabeledField(data: studentDetails.fullName, label: 'Full Name'),
                      LabeledField(data: studentDetails.dateOfBirth, label: 'Date of Birth'),
                      LabeledField(data: studentDetails.email, label: 'Email'),
                      LabeledField(data: studentDetails.phoneNumber, label: 'Phone Number'),
                      LabeledField(data: studentDetails.address, label: 'Address'),
                    ]
                  ]
                ),
              ),
              RootCardClickable(
                onTap: () => context.go('/profile_details/guardian_details_form'),
                child: RootColumn(
                  header: 'Guardian Details',
                  children: [
                    if (guardianDetails.anyEmptyFields()) ...[
                      Text(guardianDetailsError, textAlign: TextAlign.center),
                    ] else ...[
                      LabeledField(data: guardianDetails.fullName, label: 'Full Name'),
                      LabeledField(data: guardianDetails.relationship, label: 'Date of Birth'),
                      LabeledField(data: guardianDetails.email, label: 'Email'),
                      LabeledField(data: guardianDetails.phoneNumber, label: 'Phone Number'),
                      LabeledField(data: guardianDetails.address, label: 'Address'),
                      LabeledField(data: guardianDetails.occupation, label: 'Occupation'),
                      LabeledField(data: guardianDetails.employer, label: 'Employer'),
                      LabeledField(data: guardianDetails.employerPhoneNumber, label: 'Employer Phone Number'),
                      LabeledField(
                        data: '₱${guardianDetails.monthlyIncome.seperateNumberByThousands()}', 
                        label: 'Monthly Income',
                      ),
                    ]
                  ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
