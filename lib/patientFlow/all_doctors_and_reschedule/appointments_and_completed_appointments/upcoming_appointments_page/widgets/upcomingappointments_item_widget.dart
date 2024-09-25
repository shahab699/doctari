import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class UpcomingappointmentsItemWidget extends StatelessWidget {
  const UpcomingappointmentsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 25.v),
          Padding(
            padding: EdgeInsets.only(right: 22.h),
            child: Row(
              children: [
                SizedBox(
                  height: 109.adaptSize,
                  width: 109.adaptSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage,
                        height: 109.adaptSize,
                        width: 109.adaptSize,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage109x109,
                        height: 109.adaptSize,
                        width: 109.adaptSize,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 5.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sep 30, 2024 ",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "10:00 AM",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 5.v),
                      Text(
                        "Abdul Rehman",
                        style: CustomTextStyles.titleSmallBluegray700,
                      ),
                      SizedBox(height: 10.v),
                      Text(
                        "Age: 22yrs    Gender: Male",
                        style: CustomTextStyles.bodyMediumBluegray700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCancel(context),
              _buildReschedule(context),
            ],
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 37.v,
        text: "Cancel",
        margin: EdgeInsets.only(right: 8.h),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildReschedule(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 37.v,
        text: "Reschedule",
        margin: EdgeInsets.only(left: 8.h),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }
}
