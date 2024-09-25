import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctari/theme/custom_button_style.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'assets/myassets/paymentSuccess.svg',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(
                '${AppLocalizations.of(context)!.paymentSuccessfulPaymentSuccessPopupSC}!',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your appointment with Dr. Aaron is confirmed for September 30, 2024, at 10:00 AM.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                text:
                    "${AppLocalizations.of(context)!.donePaymentSuccessPopupSC}",
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle:
                    CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientBottomNavigation(),
                      ));
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorDetailsScreen()));
                },
                child: Text(
                  '${AppLocalizations.of(context)!.rescheduleAppointPaymentSuccessPopupSC}',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
