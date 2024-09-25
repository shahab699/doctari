import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 30.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(context),
              SizedBox(height: 28.v),
              _buildThirtySix(context),
              SizedBox(height: 27.v),
              Text(
                "${AppLocalizations.of(context)!.appiontTypeAppiontmentDetailDocSecSC}",
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 6.v),
              Text(
                "${AppLocalizations.of(context)!.inPersonDoctorSC}",
                style: CustomTextStyles.bodyLargeBluegray500,
              ),
              SizedBox(height: 19.v),
              Text(
                "${AppLocalizations.of(context)!.dayanddatePatientAppiontmentDetailsScrenSC}",
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 8.v),
              Text(
                "September 30, 2023 - Wednesday",
                style: CustomTextStyles.bodyMediumGray600,
              ),
              SizedBox(height: 20.v),
              Text(
                "${AppLocalizations.of(context)!.appointTimeAppiontmentDetailDocSecSC}",
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 7.v),
              Text(
                "10:00 AM",
                style: CustomTextStyles.bodyMediumGray600,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildThirtyEight(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlueGray800,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 20.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleSeven(
        text:
            "${AppLocalizations.of(context)!.appointDetailsAppiontmentDetailDocSecSC}",
      ),
    );
  }

  /// Section Widget
  Widget _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 109.adaptSize,
            width: 109.adaptSize,
            radius: BorderRadius.circular(
              12.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Aaron",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 9.v),
                SizedBox(
                  width: 197.h,
                  child: Divider(
                    color: appTheme.gray200,
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  "${AppLocalizations.of(context)!.cardiologistCancelItemWidgetSC}",
                  style: CustomTextStyles.titleSmallBluegray700,
                ),
                SizedBox(height: 11.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgSettings,
                      height: 14.adaptSize,
                      width: 14.adaptSize,
                      color: Colors.grey,
                      margin: EdgeInsets.only(bottom: 3.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "${AppLocalizations.of(context)!.goldenCardiologyPatientAppiontmentDetailsScrenSC}",
                        style: CustomTextStyles.bodyMediumInterBluegray700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChat(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 47.v,
        text: "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(right: 24.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 18.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgUserBlueGray40001,
            height: 19.v,
            width: 21.h,
            color: Color(0xff858EA9),
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildVideoCall(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 47.v,
        text:
            "${AppLocalizations.of(context)!.videoCallPatientAppiontmentDetailsScrenSC}",
        margin: EdgeInsets.only(left: 24.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 18.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgUpload,
            height: 15.v,
            width: 27.h,
            color: Color(0xff858EA9),
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtySix(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildChat(context),
        _buildVideoCall(context),
      ],
    );
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      width: 147.h,
      text: "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
      buttonStyle: CustomButtonStyles.fillGrayTL12,
      buttonTextStyle: CustomTextStyles.titleMediumPrimary,
    );
  }

  /// Section Widget
  Widget _buildReschedule(BuildContext context) {
    return CustomElevatedButton(
      width: 147.h,
      text:
          "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
      margin: EdgeInsets.only(left: 16.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
    );
  }

  /// Section Widget
  Widget _buildThirtyEight(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 40.h,
        right: 40.h,
        bottom: 34.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCancel(context),
          _buildReschedule(context),
        ],
      ),
    );
  }
}
