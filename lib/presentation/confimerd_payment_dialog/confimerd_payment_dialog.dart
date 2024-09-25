import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ConfimerdPaymentDialog extends StatelessWidget {
  const ConfimerdPaymentDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341.h,
      padding: EdgeInsets.symmetric(
        horizontal: 44.h,
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
            padding: EdgeInsets.all(29.h),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder65,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgCheckmarkOnerrorcontainer,
              height: 72.adaptSize,
              width: 72.adaptSize,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 35.v),
          Text(
            "Payment Successful!",
            style: CustomTextStyles.titleLargeInterBluegray90002,
          ),
          SizedBox(height: 11.v),
          SizedBox(
            width: 252.h,
            child: Text(
              "Your appointment with Dr. Aaron is confirmed for September 30, 2024, at 10:00 AM.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyMediumInterGray600.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 29.v),
          CustomElevatedButton(
            text: "Done",
            margin: EdgeInsets.symmetric(horizontal: 3.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleMediumInterOnErrorContainer,
          ),
          SizedBox(height: 19.v),
          Text(
            "Reschedule appointment ",
            style: CustomTextStyles.bodyMediumInterGray600,
          ),
        ],
      ),
    );
  }
}
