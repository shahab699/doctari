import 'package:doctari/theme/custom_button_style.dart';
import 'package:doctari/theme/custom_text_style.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPopupReschedule extends StatelessWidget {
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
                'Appointment Rescheduled!',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your appointment with Dr. Aaron is confirmed for September 30, 2024, at 03:00 PM.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                text: "Done",
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle:
                    CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // SizedBox(height: 10),
              // Text(
              //   'Reschedule Appointment',
              //   style: TextStyle(fontSize: 16, color: Colors.blue),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
