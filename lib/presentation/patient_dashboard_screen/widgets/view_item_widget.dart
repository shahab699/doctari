import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore: must_be_immutable
class ViewItemWidget extends StatelessWidget {
  const ViewItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71.v,
      width: 335.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 71.v,
              width: 248.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onErrorContainer.withOpacity(1),
                borderRadius: BorderRadius.circular(
                  12.h,
                ),
                border: Border.all(
                  color: appTheme.blueGray500,
                  width: 1.h,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                CustomIconButton(
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  padding: EdgeInsets.all(12.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgClosePrimary,
                  ),
                ),
                Container(
                  width: 54.h,
                  margin: EdgeInsets.only(
                    left: 64.h,
                    top: 7.v,
                    bottom: 6.v,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Patients\n",
                          style: CustomTextStyles.titleSmallff0066ff,
                        ),
                        TextSpan(
                          text: "2341",
                          style: CustomTextStyles.titleSmallff4b5563,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
