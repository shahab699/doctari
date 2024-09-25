import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ReviewAndRatingDialog extends StatelessWidget {
  const ReviewAndRatingDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341.h,
      padding: EdgeInsets.symmetric(
        horizontal: 39.h,
        vertical: 32.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder48,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 131.adaptSize,
            width: 131.adaptSize,
            padding: EdgeInsets.symmetric(
              horizontal: 33.h,
              vertical: 36.v,
            ),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder65,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgSignalGray10003,
              height: 58.v,
              width: 63.h,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 35.v),
          Text(
            "Thank you for your Review!",
            style: CustomTextStyles.titleLargeInterBluegray90002,
          ),
          SizedBox(height: 33.v),
          CustomElevatedButton(
            text: "Close",
            margin: EdgeInsets.symmetric(horizontal: 9.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleMediumInterOnErrorContainer,
          ),
        ],
      ),
    );
  }
}
