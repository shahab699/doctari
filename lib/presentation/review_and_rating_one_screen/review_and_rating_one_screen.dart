import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:doctari/widgets/custom_rating_bar.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class ReviewAndRatingOneScreen extends StatelessWidget {
  ReviewAndRatingOneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController writeyourreviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 14.v,
          ),
          child: Column(
            children: [
              _buildCard(context),
              SizedBox(height: 29.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overall Rating",
                  style: CustomTextStyles.titleMediumOnSecondaryContainer,
                ),
              ),
              SizedBox(height: 15.v),
              CustomRatingBar(
                initialRating: 5,
                itemSize: 31,
                itemCount: 5,
                color: appTheme.gray10003,
              ),
              SizedBox(height: 19.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text(
                    "Review",
                    style: CustomTextStyles.titleMediumOnSecondaryContainer,
                  ),
                ),
              ),
              SizedBox(height: 16.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: CustomTextFormField(
                  controller: writeyourreviewController,
                  hintText: "Write your review.",
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.v,
                  ),
                ),
              ),
              SizedBox(height: 28.v),
              CustomElevatedButton(
                height: 41.v,
                text: "Submit",
                margin: EdgeInsets.symmetric(horizontal: 3.h),
                buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
              ),
              SizedBox(height: 5.v),
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
      title: AppbarSubtitleThree(
        text: "How was your Experience?",
      ),
    );
  }

  /// Section Widget
  Widget _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11.v),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Dr. Aaron",
                  style: theme.textTheme.titleMedium,
                ),
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
                "Cardiologist",
                style: CustomTextStyles.titleSmallBluegray700,
              ),
              SizedBox(height: 5.v),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgSettings,
                    height: 14.adaptSize,
                    width: 14.adaptSize,
                    margin: EdgeInsets.only(
                      top: 2.v,
                      bottom: 3.v,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      "Cardiology Center, USA",
                      style: CustomTextStyles.bodyMediumBluegray700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.v),
              Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgSignal,
                    height: 15.adaptSize,
                    width: 15.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      "5",
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.v),
                    child: SizedBox(
                      child: Divider(
                        color: appTheme.gray200,
                        indent: 8.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7.h),
                    child: Text(
                      "1,872 Reviews",
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
        imagePath: ImageConstant.imgGroupPrimary48x268,
        height: 48.v,
        width: 268.h,
        margin: EdgeInsets.symmetric(
          horizontal: 61.h,
          vertical: 13.v,
        ),
      ),
    );
  }
}
