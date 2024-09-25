import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class VideoCallOneDialog extends StatelessWidget {
  VideoCallOneDialog({Key? key})
      : super(
          key: key,
        );

  TextEditingController frameSixController = TextEditingController();

  TextEditingController detailedDiagnosisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.h,
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 11.v),
          Text(
            "Diagnosis of Patient",
            style: CustomTextStyles.titleLargeBlack900,
          ),
          SizedBox(height: 15.v),
          CustomTextFormField(
            controller: frameSixController,
            hintText: "Treatment Recommendation",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.h,
              vertical: 12.v,
            ),
          ),
          SizedBox(height: 16.v),
          CustomTextFormField(
            controller: detailedDiagnosisController,
            hintText: "Detailed Diagnosis",
            textInputAction: TextInputAction.done,
            maxLines: 8,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 12.v,
            ),
          ),
          SizedBox(height: 32.v),
          CustomElevatedButton(
            height: 45.v,
            text: "Send",
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_2,
          ),
        ],
      ),
    );
  }
}
