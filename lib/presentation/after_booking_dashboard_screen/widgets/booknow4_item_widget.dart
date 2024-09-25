import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore: must_be_immutable
class Booknow4ItemWidget extends StatelessWidget {
  const Booknow4ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.h),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              right: 40.h,
            ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle50687x92,
                  height: 87.v,
                  width: 92.h,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 3.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Luke Whitesell",
                        style: CustomTextStyles.titleMediumBluegray9000518,
                      ),
                      Text(
                        "Specilist Cardiology",
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "Cardiology Center, USA",
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.v),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "",
                              style: CustomTextStyles.titleMediumff0ebe7f,
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "28.00",
                              style: CustomTextStyles.bodyLargee5677294,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 16.v,
                  ),
                  child: Text(
                    "5",
                    style: CustomTextStyles.bodySmallInterGray600,
                  ),
                ),
                Spacer(),
                _buildBookNow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookNow(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 112.h,
      text: "Book Now",
      buttonTextStyle: CustomTextStyles.labelLargeRubik,
    );
  }
}
