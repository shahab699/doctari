import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_nine.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 23.h,
            vertical: 46.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 12.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse181,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    radius: BorderRadius.circular(
                      20.h,
                    ),
                    margin: EdgeInsets.only(
                      top: 75.v,
                      bottom: 412.v,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 64.h),
                            child: Text(
                              "Today, Sep29, 2024",
                              style: CustomTextStyles.labelLargeBluegray300,
                            ),
                          ),
                          SizedBox(height: 20.v),
                          Container(
                            width: 236.h,
                            margin: EdgeInsets.only(right: 53.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 17.h,
                              vertical: 12.v,
                            ),
                            decoration: AppDecoration.fillPrimary.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 2.v),
                                Container(
                                  width: 172.h,
                                  margin: EdgeInsets.only(right: 29.h),
                                  child: Text(
                                    "Good day! I need help \nwith my test results",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .titleMediumOnErrorContainerSemiBold
                                        .copyWith(
                                      height: 1.33,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "10:24 AM",
                            style: CustomTextStyles.bodyMediumBluegray300,
                          ),
                          SizedBox(height: 11.v),
                          Container(
                            margin: EdgeInsets.only(right: 53.h),
                            decoration: AppDecoration.fillPrimary.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL101,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 14.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 17.h),
                                  child: Text(
                                    "Here it is",
                                    style: CustomTextStyles
                                        .titleMediumOnErrorContainerSemiBold,
                                  ),
                                ),
                                SizedBox(height: 12.v),
                                CustomImageView(
                                  imagePath: ImageConstant.imgImg,
                                  height: 160.v,
                                  width: 236.h,
                                  radius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.h),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.v),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              "10:25 AM",
                              style: CustomTextStyles.bodyMediumBluegray300,
                            ),
                          ),
                          SizedBox(height: 13.v),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 52.h,
                                right: 1.h,
                              ),
                              padding: EdgeInsets.all(12.h),
                              decoration: AppDecoration.fillGray10002.copyWith(
                                borderRadius:
                                    BorderRadiusStyle.customBorderTL10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 2.v),
                                  Container(
                                    width: 207.h,
                                    margin: EdgeInsets.only(left: 4.h),
                                    child: Text(
                                      "Hello, John!\nJust give me 5 min, please",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .titleMediumBlack900SemiBold
                                          .copyWith(
                                        height: 1.33,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.v),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgIconStatusReaded,
                                  height: 16.adaptSize,
                                  width: 16.adaptSize,
                                  margin: EdgeInsets.only(
                                    top: 1.v,
                                    bottom: 2.v,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.h),
                                  child: Text(
                                    "10:27 AM",
                                    style:
                                        CustomTextStyles.bodyMediumBluegray300,
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
              SizedBox(height: 55.v),
              _buildMessage(context),
            ],
          ),
        ),
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
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: Row(
        children: [
          AppbarTitleCircleimage(
            imagePath: ImageConstant.imgEllipse181,
          ),
          AppbarSubtitleNine(
            text: "Abdul Rehman",
            margin: EdgeInsets.only(
              left: 14.h,
              top: 5.v,
              bottom: 6.v,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: messageController,
            hintText: "Type your message here",
            hintStyle: CustomTextStyles.bodyLargeBluegray300,
            textInputAction: TextInputAction.done,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 11.v, 10.h, 11.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgButtonattachfile,
                height: 22.adaptSize,
                width: 22.adaptSize,
              ),
            ),
            suffixConstraints: BoxConstraints(
              maxHeight: 44.v,
            ),
            contentPadding: EdgeInsets.only(
              left: 11.h,
              top: 9.v,
              bottom: 9.v,
            ),
            borderDecoration: TextFormFieldStyleHelper.fillGray,
            filled: true,
            fillColor: appTheme.gray10001,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.h),
          child: CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            padding: EdgeInsets.all(11.h),
            decoration: IconButtonStyleHelper.outlineBlueGrayTL10,
            child: CustomImageView(
              imagePath: ImageConstant.imgButtonSend,
            ),
          ),
        ),
      ],
    );
  }
}
