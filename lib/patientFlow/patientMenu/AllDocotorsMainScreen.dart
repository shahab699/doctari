import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/all_doctors_page/all_doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllDocotrsMainScreen extends StatelessWidget {
  const AllDocotrsMainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllDoctorsScreen(),
    );
  }
}
