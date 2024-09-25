import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class VideoCallTwoDialog extends StatelessWidget {
  const VideoCallTwoDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.h,
      padding: EdgeInsets.symmetric(
        horizontal: 13.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Doctors Diagnosis",
              style: CustomTextStyles.titleLargeBlack900,
            ),
          ),
          SizedBox(height: 20.v),
          Text(
            "Treatment Recommendation",
            style: CustomTextStyles.titleMediumBlack900,
          ),
          SizedBox(height: 5.v),
          Container(
            width: 288.h,
            margin: EdgeInsets.only(right: 18.h),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc dictum a mauris ",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyLargeGray500.copyWith(
                height: 1.38,
              ),
            ),
          ),
          SizedBox(height: 14.v),
          Text(
            "Detailed Diagnosis",
            style: CustomTextStyles.titleMediumBlack900,
          ),
          SizedBox(height: 4.v),
          Container(
            width: 288.h,
            margin: EdgeInsets.only(right: 18.h),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc dictum a mauris Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc dictum a mauris ",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyLargeGray500.copyWith(
                height: 1.38,
              ),
            ),
          ),
          SizedBox(height: 20.v),
          CustomElevatedButton(
            height: 45.v,
            text: "Done",
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_2,
          ),
        ],
      ),
    );
  }
}
