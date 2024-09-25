import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_twelve.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_thirteen.dart';
import 'package:doctari/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class MenuScreenOneScreen extends StatelessWidget {
  const MenuScreenOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, -0.28),
              end: Alignment(0.5, 1),
              colors: [
                appTheme.lightBlueA200,
                theme.colorScheme.primary,
              ],
            ),
          ),
          child: Container(
            width: 375.h,
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 41.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.v),
                Container(
                  margin: EdgeInsets.only(right: 123.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 18.v,
                  ),
                  decoration: AppDecoration.fillOnErrorContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgContrast,
                        height: 22.v,
                        width: 18.h,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 23.h,
                          bottom: 2.v,
                        ),
                        child: Text(
                          "Profile",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.only(
                          top: 5.v,
                          bottom: 7.v,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    right: 138.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUser,
                        height: 19.adaptSize,
                        width: 19.adaptSize,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22.h),
                        child: Text(
                          "Chat",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.symmetric(vertical: 4.v),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 41.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    right: 138.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCalendar,
                        height: 21.v,
                        width: 20.h,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Text(
                          "Appointments",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.only(
                          top: 4.v,
                          bottom: 6.v,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 38.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 9.h,
                    right: 138.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgNotification,
                        height: 20.v,
                        width: 16.h,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Notifications",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.only(
                          top: 4.v,
                          bottom: 5.v,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 42.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    right: 138.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUserOnerrorcontainer22x16,
                        height: 22.v,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Contact Us",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.only(
                          top: 4.v,
                          bottom: 5.v,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 38.v),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgSearch,
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 23.h),
                        child: Text(
                          "Change Password",
                          style: CustomTextStyles
                              .titleMediumOnErrorContainerSemiBold_1,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 12.v,
                        width: 7.h,
                        margin: EdgeInsets.only(
                          left: 11.h,
                          top: 3.v,
                          bottom: 5.v,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUserOnerrorcontainer15x15,
                        height: 15.adaptSize,
                        width: 15.adaptSize,
                        margin: EdgeInsets.only(
                          top: 5.v,
                          bottom: 7.v,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 27.h),
                        child: Text(
                          "Logout",
                          style: CustomTextStyles
                              .titleLargeOnErrorContainerSemiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgPlay,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 5.v,
          bottom: 6.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 12.h),
        child: Column(
          children: [
            AppbarSubtitleTwelve(
              text: "Dr. Aaron Smith",
            ),
            SizedBox(height: 3.v),
            AppbarSubtitleThirteen(
              text: "dr.aaron@gmail.com",
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.fromLTRB(20.h, 12.v, 20.h, 13.v),
        ),
      ],
    );
  }
}
