import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatboxOneScreen extends StatelessWidget {
  const ChatboxOneScreen({Key? key})
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
            vertical: 4.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 10.v),
              _buildContrast(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast1(context),
              SizedBox(height: 11.v),
              Divider(),
              SizedBox(height: 16.v),
              _buildContrast2(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast3(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast4(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast5(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast6(context),
              SizedBox(height: 11.v),
              Divider(),
              SizedBox(height: 17.v),
              _buildContrast7(context),
              SizedBox(height: 10.v),
              Divider(),
              SizedBox(height: 16.v),
              _buildContrast8(context),
              SizedBox(height: 10.v),
              Divider(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarSubtitleSeven(
        text: "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
      ),
    );
  }

  /// Section Widget
  Widget _buildContrast(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(
            top: 2.v,
            bottom: 3.v,
          ),
        ),
        Container(
          height: 46.v,
          width: 77.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 14.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Cardiology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Aaron",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 14.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 2.v),
        ),
        Container(
          height: 43.v,
          width: 110.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Dentist",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Cindy Hsu",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 14.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(
            top: 2.v,
            bottom: 3.v,
          ),
        ),
        Container(
          height: 46.v,
          width: 139.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 14.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Gynecologists",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Jessica Brown",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 14.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast3(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
        Container(
          height: 44.v,
          width: 200.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Endocrinology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Bryan John McColgan",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast4(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
        Container(
          height: 44.v,
          width: 186.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Neuroanesthesiology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Gary Alan Goldman",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast5(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
        Container(
          height: 44.v,
          width: 151.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Anesthesiology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Nancy L Bruder",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast6(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 2.v),
        ),
        Container(
          height: 43.v,
          width: 148.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Dentist",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Lily Heidi Chen",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 14.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast7(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
        Container(
          height: 44.v,
          width: 204.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 13.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Gynecology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Philip Larry Zemansky",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 13.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildContrast8(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgContrast40x40,
          height: 40.adaptSize,
          width: 40.adaptSize,
          margin: EdgeInsets.only(
            top: 2.v,
            bottom: 3.v,
          ),
        ),
        Container(
          height: 46.v,
          width: 209.h,
          margin: EdgeInsets.only(left: 15.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 14.v),
                  child: IntrinsicWidth(
                    child: _buildDentist(
                      context,
                      dentist: "Gynecology",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Dr. Timur Jonathan Karaca",
                  style: CustomTextStyles.titleMediumPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray300,
          height: 16.adaptSize,
          width: 16.adaptSize,
          margin: EdgeInsets.only(
            top: 14.v,
            bottom: 15.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgGroupPrimary48x282,
        height: 48.v,
        width: 282.h,
        margin: EdgeInsets.symmetric(
          horizontal: 54.h,
          vertical: 13.v,
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildDentist(
    BuildContext context, {
    required String dentist,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(left: 55.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.v),
                  child: Text(
                    dentist,
                    style: CustomTextStyles.bodyMediumBluegray300.copyWith(
                      color: appTheme.blueGray300,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightBlueGray300,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(bottom: 14.v),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 11.v),
        Divider(),
      ],
    );
  }
}
