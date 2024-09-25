import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:doctari/widgets/app_bar/appbar_trailing_circleimage.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'widgets/view_item_widget.dart';
import 'widgets/fiftyone_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildCancel2(context),
              SizedBox(height: 27.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTabBar(context),
                      SizedBox(height: 31.v),
                      _buildTitle(context),
                      SizedBox(height: 17.v),
                      _buildFiftyOne(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
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

  /// Section Widget
  Widget _buildCancel1(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 37.v,
        text: "Cancel",
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildReschedule1(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 37.v,
        text: "Reschedule",
        margin: EdgeInsets.only(left: 16.h),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildCancel2(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicWidth(
        child: SizedBox(
          height: 337.v,
          width: 375.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomAppBar(
                height: 127.v,
                title: Padding(
                  padding: EdgeInsets.only(
                    left: 19.h,
                    top: 16.v,
                    bottom: 43.v,
                  ),
                  child: Column(
                    children: [
                      AppbarSubtitleEight(
                        text: "Hi Dr. Aaron! ",
                        margin: EdgeInsets.only(right: 152.h),
                      ),
                      SizedBox(height: 6.v),
                      AppbarSubtitleOne(
                        text: "Upcoming Appointments",
                      ),
                    ],
                  ),
                ),
                actions: [
                  AppbarTrailingCircleimage(
                    imagePath: ImageConstant.imgEllipse26,
                    margin: EdgeInsets.fromLTRB(15.h, 14.v, 20.h, 53.v),
                  ),
                ],
                styleType: Style.bgGradientnamelightblueA200nameprimary,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
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
                          "In-Person Visit",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 13.v),
                      Divider(
                        color: appTheme.gray200,
                      ),
                      SizedBox(height: 11.v),
                      Padding(
                        padding: EdgeInsets.only(right: 21.h),
                        child: Row(
                          children: [
                            _buildFive(
                              context,
                              image: ImageConstant.imgImage109x109,
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
                                    style:
                                        CustomTextStyles.titleSmallBluegray700,
                                  ),
                                  SizedBox(height: 10.v),
                                  Text(
                                    "Age: 22yrs    Gender: Male",
                                    style:
                                        CustomTextStyles.bodyMediumBluegray700,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Divider(
                        color: appTheme.gray200,
                      ),
                      SizedBox(height: 11.v),
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
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(left: 362.h),
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
                          "Upcoming Consultation",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Divider(
                        color: appTheme.gray200,
                      ),
                      SizedBox(height: 11.v),
                      Row(
                        children: [
                          _buildFive(
                            context,
                            image: ImageConstant.imgImage1,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 12.h,
                                top: 4.v,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sep 30, 2024 - 10.00 AM",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 2.v),
                                  Text(
                                    "Dr. Aaron",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 4.v),
                                  Text(
                                    "Cardiologist",
                                    style:
                                        CustomTextStyles.titleSmallBluegray700,
                                  ),
                                  SizedBox(height: 8.v),
                                  Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgSettings,
                                        height: 14.adaptSize,
                                        width: 14.adaptSize,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 3.v),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.h),
                                        child: Text(
                                          "Cardiology Center, USA",
                                          style: CustomTextStyles
                                              .bodyMediumBluegray700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.v),
                      Divider(
                        color: appTheme.gray200,
                      ),
                      SizedBox(height: 11.v),
                      Row(
                        children: [
                          _buildCancel1(context),
                          _buildReschedule1(context),
                        ],
                      ),
                      SizedBox(height: 3.v),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOverview(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overview",
              style: CustomTextStyles.titleLargeBluegray90001,
            ),
            SizedBox(height: 12.v),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                  height: 9.v,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return ViewItemWidget();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabBar(BuildContext context) {
    return SizedBox(
      height: 271.v,
      width: 375.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgTabBar,
            height: 102.v,
            width: 375.h,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 54.v),
          ),
          _buildOverview(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 9.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Reviews",
            style: theme.textTheme.titleLarge,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 3.v,
              bottom: 4.v,
            ),
            child: Text(
              "See All",
              style: CustomTextStyles.titleSmallMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFiftyOne(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.h,
          right: 160.h,
        ),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 16.v,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return FiftyoneItemWidget();
          },
        ),
      ),
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
        imagePath: ImageConstant.imgGroupPrimary,
        height: 48.v,
        width: 207.h,
        margin: EdgeInsets.fromLTRB(84.h, 13.v, 83.h, 13.v),
      ),
    );
  }

  /// Common widget
  Widget _buildFive(
    BuildContext context, {
    required String image,
  }) {
    return SizedBox(
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
            imagePath: image,
            height: 109.adaptSize,
            width: 109.adaptSize,
            radius: BorderRadius.circular(
              12.h,
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
