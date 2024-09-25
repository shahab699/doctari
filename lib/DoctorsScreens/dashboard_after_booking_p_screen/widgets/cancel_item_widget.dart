import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CancelItemWidget extends StatelessWidget {
  const CancelItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 14.v,
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
            child: Expanded(
              child: Text(
                "${AppLocalizations.of(context)!.upcomingConsultationCancelItemWidgetSC}",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: 24.v),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 109.adaptSize,
                  width: 109.adaptSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Expanded(
                        child: CustomImageView(
                          imagePath: ImageConstant.imgImage1,
                          height: 100.adaptSize,
                          width: 100.adaptSize,
                          radius: BorderRadius.circular(
                            12.h,
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sep 30, 2024 - 10.00AM",
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "Dr. Aaron Smith",
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "${AppLocalizations.of(context)!.cardiologistCancelItemWidgetSC}",
                      style: CustomTextStyles.titleSmallBluegray700,
                    ),
                    SizedBox(height: 2.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 14.adaptSize,
                          width: 14.adaptSize,
                          color: Colors.black,
                          margin: EdgeInsets.only(
                            top: 2.v,
                            bottom: 17.v,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            bottom: 13.v,
                          ),
                          child: Text(
                            "${AppLocalizations.of(context)!.cardiologyCenterBooknow1ItemWidgetSC}, USA",
                            style: CustomTextStyles.bodyMediumBluegray700,
                          ),
                        ),
                      ],
                    ),
                  ],
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
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text:
            "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(right: 8.h),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildReschedule(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text:
            "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(left: 8.h),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }
}
