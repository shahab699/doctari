import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController emailController1 = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 785.v,
                width: 375.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.h, 78.v, 20.h, 20.v),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgDoctariIcon51,
                              height: 54.v,
                              width: 214.h,
                            ),
                            SizedBox(height: 14.v),
                            Text(
                              "Welcome back!",
                              style: CustomTextStyles.titleLargeBlack900,
                            ),
                            SizedBox(height: 79.v),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: "abdulrehman@gmail.com",
                              textInputType: TextInputType.emailAddress,
                              suffix: Container(
                                margin:
                                    EdgeInsets.fromLTRB(30.h, 21.v, 15.h, 21.v),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgCheckmark,
                                  height: 11.v,
                                  width: 15.h,
                                ),
                              ),
                              suffixConstraints: BoxConstraints(
                                maxHeight: 54.v,
                              ),
                            ),
                            SizedBox(height: 18.v),
                            _buildPassword(context),
                            SizedBox(height: 32.v),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 19.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 123.h,
                                vertical: 10.v,
                              ),
                              decoration: AppDecoration.fillPrimary.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.v),
                                  Text(
                                    "Login",
                                    style: CustomTextStyles
                                        .titleMediumOnErrorContainerSemiBold,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.v),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 19.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 69.h,
                                vertical: 15.v,
                              ),
                              decoration: AppDecoration.outlineBlack.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgGroup18x18,
                                    height: 18.adaptSize,
                                    width: 18.adaptSize,
                                    margin: EdgeInsets.symmetric(vertical: 2.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.h,
                                      top: 1.v,
                                    ),
                                    child: Text(
                                      "Login with Google",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.v),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 19.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 72.h,
                                vertical: 15.v,
                              ),
                              decoration: AppDecoration.outlineBlack.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgApplelogo1,
                                    height: 18.v,
                                    width: 15.h,
                                    margin: EdgeInsets.symmetric(vertical: 2.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.h,
                                      top: 1.v,
                                    ),
                                    child: Text(
                                      "Login with Apple",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don’t have an account? ",
                                    style: CustomTextStyles.bodyMediumff000000,
                                  ),
                                  TextSpan(
                                    text: "Join us",
                                    style: CustomTextStyles.bodyMediumff004687,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 785.v,
                        width: 375.h,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: AppDecoration.fillOnPrimary,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Spacer(),
                                    Container(
                                      height: 390.v,
                                      width: 375.h,
                                      decoration: BoxDecoration(
                                        color: theme
                                            .colorScheme.onErrorContainer
                                            .withOpacity(1),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30.h),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _buildEmail(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 19.v,
      ),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgGroup11011,
        height: 14.v,
        width: 303.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: 19.h,
          right: 19.h,
          bottom: 50.v,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 130.h,
                child: Divider(
                  color: appTheme.gray400,
                ),
              ),
            ),
            SizedBox(height: 56.v),
            Text(
              "Forgot password",
              style: CustomTextStyles.headlineSmallBlack900,
            ),
            SizedBox(height: 7.v),
            Container(
              width: 274.h,
              margin: EdgeInsets.only(
                left: 1.h,
                right: 61.h,
              ),
              child: Text(
                "Enter your email for the verification proccesss,\nwe will send 4 digits code to your email.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyMediumBluegray50014_1.copyWith(
                  height: 1.66,
                ),
              ),
            ),
            SizedBox(height: 33.v),
            Padding(
              padding: EdgeInsets.only(left: 1.h),
              child: CustomTextFormField(
                controller: emailController1,
                hintText: "Email",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
                obscureText: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25.h,
                  vertical: 16.v,
                ),
              ),
            ),
            SizedBox(height: 30.v),
            CustomElevatedButton(
              text: "Continue",
              margin: EdgeInsets.only(
                left: 21.h,
                right: 20.h,
              ),
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle:
                  CustomTextStyles.titleMediumOnErrorContainerSemiBold,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
