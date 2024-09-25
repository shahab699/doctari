import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
class SettingsScreen extends StatelessWidget {
 const SettingsScreen({Key? key}) : super(key: key);

@override Widget build(BuildContext context) {
 return SafeArea(
     child: Scaffold(
         body: SizedBox(
             height: 783.v,
             width: 375.h,
             child: Stack(
                 alignment: Alignment.center,
                 children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20.h, 7.v, 20.h, 27.v),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Row(
                                   children: [
                                    CustomIconButton(
                                        height: 30.adaptSize,
                                        width: 30.adaptSize,
                                        padding: EdgeInsets.all(8.h),
                                        decoration: IconButtonStyleHelper.fillOnErrorContainer,
                                        onTap: () {
                                         onTapBtnArrowLeft(context);
                                         },
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgArrowLeftBlueGray500
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 19.h, top: 6.v), child: Text("Settings", style: CustomTextStyles.titleMediumRubikBluegray90005))]), SizedBox(height: 32.v), Text("Change Password", style: CustomTextStyles.titleLargeBlack900), SizedBox(height: 26.v), _buildNewPassword(context, newPassword: "Current Password"), SizedBox(height: 17.v), _buildNewPassword(context, newPassword: "New Password"), SizedBox(height: 20.v), _buildNewPassword(context, newPassword: "Confirm Password"), Spacer(), _buildChangePassword(context)]))),
                  Align(alignment: Alignment.center, child: SizedBox(height: 783.v, width: 375.h, child: Stack(alignment: Alignment.center, children: [Align(alignment: Alignment.center, child: Container(padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 304.v), decoration: AppDecoration.fillBlack, child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(height: 8.v), Container(height: 167.v, width: 335.h, decoration: BoxDecoration(color: theme.colorScheme.onErrorContainer.withOpacity(1), borderRadius: BorderRadius.circular(8.h)))]))), Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(left: 48.h, right: 57.h), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Password Changed!", style: CustomTextStyles.titleLargeBlack900), SizedBox(height: 67.v), Align(alignment: Alignment.centerRight, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("Cancel", style: CustomTextStyles.titleMediumPrimary_1), Padding(padding: EdgeInsets.only(left: 32.h), child: Text("Ok", style: CustomTextStyles.titleMediumPrimary_1))]))])))])))])))); }
/// Section Widget
Widget _buildChangePassword(BuildContext context) { return Container(width: 335.h, padding: EdgeInsets.symmetric(horizontal: 94.h, vertical: 15.v), decoration: AppDecoration.fillPrimary.copyWith(borderRadius: BorderRadiusStyle.roundedBorder12), child: Text("Change Password", style: CustomTextStyles.titleMediumOnErrorContainer_1)); } 
/// Common widget
Widget _buildNewPassword(BuildContext context, {required String newPassword, }) { return Container(padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 14.v), decoration: AppDecoration.outlineBlueGray.copyWith(borderRadius: BorderRadiusStyle.roundedBorder12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: EdgeInsets.only(bottom: 1.v), child: Text(newPassword, style: CustomTextStyles.titleMediumBluegray500.copyWith(color: appTheme.blueGray500))), CustomImageView(imagePath: ImageConstant.imgEye, height: 14.v, width: 18.h, margin: EdgeInsets.only(top: 3.v, bottom: 5.v))])); } 

/// Navigates back to the previous screen.
onTapBtnArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
