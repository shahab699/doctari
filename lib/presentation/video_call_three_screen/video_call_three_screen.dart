import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_iconbutton_one.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'package:doctari/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class VideoCallThreeScreen extends StatelessWidget {
  VideoCallThreeScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onErrorContainer.withOpacity(1),
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgVideoCallThree,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgImg1,
                  height: 180.v,
                  width: 100.h,
                  radius: BorderRadius.circular(
                    10.h,
                  ),
                  margin: EdgeInsets.only(right: 24.h),
                ),
                SizedBox(height: 27.v),
                _buildWidget3(context),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingIconbuttonOne(
        imagePath: ImageConstant.imgUserOnerrorcontainer30x30,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 13.v,
          bottom: 13.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleFour(
        text: "Video Call",
      ),
    );
  }

  /// Section Widget
  Widget _buildWidget3(BuildContext context) {
    return SizedBox(
      height: 232.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.h,
                vertical: 19.v,
              ),
              decoration: AppDecoration.fillPrimaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildWidget(
                    context,
                    widget: "(510) 523-2189",
                    time: "5:24",
                  ),
                  SizedBox(height: 16.v),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconButton(
                        height: 56.adaptSize,
                        width: 56.adaptSize,
                        padding: EdgeInsets.all(14.h),
                        decoration: IconButtonStyleHelper.fillPrimaryContainer,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconMic,
                        ),
                      ),
                      Spacer(
                        flex: 22,
                      ),
                      CustomIconButton(
                        height: 56.adaptSize,
                        width: 56.adaptSize,
                        padding: EdgeInsets.all(14.h),
                        decoration: IconButtonStyleHelper.fillPrimaryContainer,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconVideo,
                        ),
                      ),
                      Spacer(
                        flex: 22,
                      ),
                      CustomIconButton(
                        height: 56.adaptSize,
                        width: 56.adaptSize,
                        padding: EdgeInsets.all(14.h),
                        decoration: IconButtonStyleHelper.fillPrimaryContainer,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowLeftOnerrorcontainer,
                        ),
                      ),
                      Spacer(
                        flex: 54,
                      ),
                    ],
                  ),
                  SizedBox(height: 23.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.h,
                vertical: 20.v,
              ),
              decoration: AppDecoration.fillPrimaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWidget(
                    context,
                    widget: "(510) 523-2189",
                    time: "5:24",
                  ),
                  SizedBox(height: 18.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.h,
                      right: 3.h,
                    ),
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: "Chat with Doctor",
                      hintStyle: CustomTextStyles.bodyMediumBluegray500,
                      borderDecoration: SearchViewStyleHelper.outlineBlackTL27,
                    ),
                  ),
                  SizedBox(height: 32.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 19.h),
                          child: CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration:
                                IconButtonStyleHelper.fillPrimaryContainer,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIconMic,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.h),
                          child: CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration:
                                IconButtonStyleHelper.fillPrimaryContainer,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIconVideo,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.h),
                          child: CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration:
                                IconButtonStyleHelper.fillPrimaryContainer,
                            child: CustomImageView(
                              imagePath:
                                  ImageConstant.imgArrowLeftOnerrorcontainer,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 19.h),
                          child: CustomIconButton(
                            height: 56.adaptSize,
                            width: 56.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration: IconButtonStyleHelper.fillRed,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgIconPhone,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 56,
      width: 56,
      backgroundColor: appTheme.red700,
      child: CustomImageView(
        imagePath: ImageConstant.imgIconPhone,
        height: 28.0.v,
        width: 28.0.h,
      ),
    );
  }

  /// Common widget
  Widget _buildWidget(
    BuildContext context, {
    required String widget,
    required String time,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            widget,
            style: CustomTextStyles.titleMediumOnErrorContainer18.copyWith(
              color: theme.colorScheme.onErrorContainer.withOpacity(1),
            ),
          ),
        ),
        Text(
          time,
          style: CustomTextStyles.titleMediumOnErrorContainer18.copyWith(
            color: theme.colorScheme.onErrorContainer.withOpacity(1),
          ),
        ),
      ],
    );
  }
}
