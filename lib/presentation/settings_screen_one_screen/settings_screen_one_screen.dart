import 'package:doctari/widgets/app_bar/custom_app_bar.dart';import 'package:doctari/widgets/app_bar/appbar_leading_iconbutton.dart';import 'package:doctari/widgets/app_bar/appbar_subtitle_ten.dart';import 'package:doctari/widgets/custom_text_form_field.dart';import 'package:doctari/widgets/custom_elevated_button.dart';import 'package:flutter/material.dart';import 'package:doctari/core/app_export.dart';
// ignore_for_file: must_be_immutable
class SettingsScreenOneScreen extends StatelessWidget {SettingsScreenOneScreen({Key? key}) : super(key: key);

TextEditingController passwordController = TextEditingController();

TextEditingController newpasswordController = TextEditingController();

TextEditingController confirmpasswordController = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override Widget build(BuildContext context) { return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, appBar: _buildAppBar(context), body: SizedBox(width: SizeUtils.width, child: SingleChildScrollView(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), child: Form(key: _formKey, child: Container(width: 375.h, padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Change Password", style: CustomTextStyles.titleLargeBlack900), SizedBox(height: 26.v), _buildPassword(context), SizedBox(height: 17.v), _buildNewpassword(context), SizedBox(height: 20.v), _buildConfirmpassword(context), SizedBox(height: 5.v)]))))), bottomNavigationBar: _buildChangePassword(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(height: 44.v, leadingWidth: 50.h, leading: AppbarLeadingIconbutton(imagePath: ImageConstant.imgArrowLeftBlueGray500, margin: EdgeInsets.only(left: 20.h, top: 7.v, bottom: 7.v), onTap: () {onTapArrowLeft(context);}), title: AppbarSubtitleTen(text: "Settings", margin: EdgeInsets.only(left: 19.h))); } 
/// Section Widget
Widget _buildPassword(BuildContext context) { return CustomTextFormField(controller: passwordController, hintText: "Current Password", hintStyle: CustomTextStyles.titleMediumBluegray500, textInputType: TextInputType.visiblePassword, suffix: Container(margin: EdgeInsets.fromLTRB(30.h, 19.v, 23.h, 21.v), child: CustomImageView(imagePath: ImageConstant.imgEye, height: 14.v, width: 18.h)), suffixConstraints: BoxConstraints(maxHeight: 54.v), obscureText: true); } 
/// Section Widget
Widget _buildNewpassword(BuildContext context) { return CustomTextFormField(controller: newpasswordController, hintText: "New Password", hintStyle: CustomTextStyles.titleMediumBluegray500, textInputType: TextInputType.visiblePassword, suffix: Container(margin: EdgeInsets.fromLTRB(30.h, 19.v, 23.h, 21.v), child: CustomImageView(imagePath: ImageConstant.imgEye, height: 14.v, width: 18.h)), suffixConstraints: BoxConstraints(maxHeight: 54.v), obscureText: true); } 
/// Section Widget
Widget _buildConfirmpassword(BuildContext context) { return CustomTextFormField(controller: confirmpasswordController, hintText: "Confirm Password", hintStyle: CustomTextStyles.titleMediumBluegray500, textInputAction: TextInputAction.done, textInputType: TextInputType.visiblePassword, suffix: Container(margin: EdgeInsets.fromLTRB(30.h, 19.v, 23.h, 21.v), child: CustomImageView(imagePath: ImageConstant.imgEye, height: 14.v, width: 18.h)), suffixConstraints: BoxConstraints(maxHeight: 54.v), obscureText: true); } 
/// Section Widget
Widget _buildChangePassword(BuildContext context) { return CustomElevatedButton(text: "Change Password", margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 27.v), buttonStyle: CustomButtonStyles.fillPrimary, buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_1); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
