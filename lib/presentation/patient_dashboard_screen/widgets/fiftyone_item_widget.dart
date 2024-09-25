import 'package:doctari/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore: must_be_immutable
class FiftyoneItemWidget extends StatelessWidget {
  const FiftyoneItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame1000000981,
            height: 57.adaptSize,
            width: 57.adaptSize,
            radius: BorderRadius.circular(
              28.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 4.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emily Anderson",
                  style: CustomTextStyles.titleMediumBluegray800,
                ),
                SizedBox(height: 8.v),
                Row(
                  children: [
                    Text(
                      "5.0",
                      style: CustomTextStyles.labelLargeGray600_1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.h,
                        top: 2.v,
                        bottom: 2.v,
                      ),
                      child: CustomRatingBar(
                        ignoreGestures: true,
                        initialRating: 5,
                        itemSize: 12,
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
