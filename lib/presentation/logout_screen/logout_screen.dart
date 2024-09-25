import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
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
          child: SizedBox(
            height: 783.v,
            width: 375.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.h,
                      top: 17.v,
                      right: 20.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfile(context),
                        SizedBox(height: 70.v),
                        Container(
                          margin: EdgeInsets.only(right: 123.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 18.v,
                          ),
                          decoration:
                              AppDecoration.fillOnErrorContainer.copyWith(
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
                                      .bodyLargeOnErrorContainer,
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
                                      .bodyLargeOnErrorContainer,
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
                        SizedBox(height: 42.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.h,
                            right: 138.h,
                          ),
                          child: _buildEightyOne(
                            context,
                            profile: ImageConstant.imgTelevision,
                            helpCenter: "Payments ",
                          ),
                        ),
                        SizedBox(height: 42.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.h,
                            right: 138.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUp,
                                height: 20.v,
                                width: 17.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 22.h),
                                child: Text(
                                  "Consultations",
                                  style: CustomTextStyles
                                      .bodyLargeRubikOnErrorContainer,
                                ),
                              ),
                              Spacer(),
                              CustomImageView(
                                imagePath: ImageConstant.imgForward,
                                height: 12.v,
                                width: 7.h,
                                margin: EdgeInsets.only(
                                  top: 4.v,
                                  bottom: 3.v,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 43.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.h,
                            right: 138.h,
                          ),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgCalendar,
                                height: 21.v,
                                width: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.h,
                                  top: 2.v,
                                ),
                                child: Text(
                                  "Appointments",
                                  style: CustomTextStyles
                                      .bodyLargeRubikOnErrorContainer,
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
                          padding: EdgeInsets.only(left: 10.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgUserOnerrorcontainer22x16,
                                height: 22.v,
                                width: 16.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24.h),
                                child: Text(
                                  "Privacy & Policy",
                                  style: CustomTextStyles
                                      .bodyLargeRubikOnErrorContainer,
                                ),
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgForward,
                                height: 12.v,
                                width: 7.h,
                                margin: EdgeInsets.only(
                                  left: 25.h,
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
                          child: _buildEightyOne(
                            context,
                            profile: ImageConstant.imgProfile,
                            helpCenter: "Help Center",
                          ),
                        ),
                        SizedBox(height: 43.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.h,
                            right: 138.h,
                          ),
                          child: _buildEightyOne(
                            context,
                            profile: ImageConstant.imgSearch,
                            helpCenter: "Settings",
                          ),
                        ),
                        SizedBox(height: 97.v),
                        Padding(
                          padding: EdgeInsets.only(left: 9.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgUserOnerrorcontainer15x15,
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
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 783.v,
                    width: 375.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                              vertical: 304.v,
                            ),
                            decoration: AppDecoration.fillBlack,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 8.v),
                                Container(
                                  height: 167.v,
                                  width: 335.h,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onErrorContainer
                                        .withOpacity(1),
                                    borderRadius: BorderRadius.circular(
                                      8.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 48.h,
                              right: 57.h,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Log Out",
                                  style:
                                      CustomTextStyles.headlineMediumBlack900,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3.h),
                                  child: Text(
                                    "Are you sure you want to logout?",
                                    style: CustomTextStyles.bodyLargeRegular,
                                  ),
                                ),
                                SizedBox(height: 36.v),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Cancel",
                                        style: CustomTextStyles
                                            .titleMediumPrimary_1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32.h),
                                        child: Text(
                                          "Ok",
                                          style: CustomTextStyles
                                              .titleMediumPrimary_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
  Widget _buildProfile(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgPlay,
          height: 44.adaptSize,
          width: 44.adaptSize,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 12.h,
            top: 2.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Abdul Rehman",
                style: CustomTextStyles.titleMediumOnErrorContainerSemiBold_1,
              ),
              SizedBox(height: 3.v),
              Text(
                "abd@gmail.com",
                style: CustomTextStyles.bodySmallOnErrorContainer,
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 7.v,
            bottom: 8.v,
          ),
          child: CustomIconButton(
            height: 30.adaptSize,
            width: 30.adaptSize,
            padding: EdgeInsets.all(8.h),
            decoration: IconButtonStyleHelper.fillRedA,
            child: CustomImageView(
              imagePath: ImageConstant.imgClose,
            ),
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildEightyOne(
    BuildContext context, {
    required String profile,
    required String helpCenter,
  }) {
    return Row(
      children: [
        CustomImageView(
          imagePath: profile,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
        Padding(
          padding: EdgeInsets.only(left: 23.h),
          child: Text(
            helpCenter,
            style: CustomTextStyles.bodyLargeRubikOnErrorContainer.copyWith(
              color: theme.colorScheme.onErrorContainer.withOpacity(1),
            ),
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgForward,
          height: 12.v,
          width: 7.h,
          margin: EdgeInsets.symmetric(vertical: 3.v),
        ),
      ],
    );
  }
}
