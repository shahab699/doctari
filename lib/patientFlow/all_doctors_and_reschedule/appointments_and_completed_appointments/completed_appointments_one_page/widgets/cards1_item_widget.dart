import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore: must_be_immutable
class Cards1ItemWidget extends StatelessWidget {
  final Map<String, dynamic> appointmentData;
  final String date;
  final String time;
  const Cards1ItemWidget(
      {required this.appointmentData,
      required this.date,
      required this.time,
      Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${date} - ${time}",
            style: CustomTextStyles.titleSmallBluegray900,
          ),
          SizedBox(height: 24.v),
          Padding(
            padding: EdgeInsets.only(right: 27.h),
            child: Row(
              children: [
                // CustomImageView(
                //   imagePath: ImageConstant.imgImage8,
                //   height: 109.adaptSize,
                //   width: 109.adaptSize,
                //   radius: BorderRadius.circular(
                //     12.h,
                //   ),
                // ),

                // CustomImageView(
                //   imgType: ImageType.network,
                //   imagePath: '${appointmentData['doctor']['profile_picture']['url']}',
                //   height: 109.adaptSize,
                //   width: 109.adaptSize,
                //   radius: BorderRadius.circular(
                //     12.h,
                //   ),
                //   alignment: Alignment.center,
                // ),
                SizedBox(
                  height: 109.adaptSize,
                  width: 109.adaptSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Conditionally display background images only if no user image is available
                      if (appointmentData['doctor'] == null ||
                          appointmentData['doctor']
                          ['profile_picture'] ==
                              null ||
                          appointmentData['doctor']['profile_picture']
                          ['url'] ==
                              null) ...[
                        CustomImageView(
                          imagePath: ImageConstant.dummyNetworkProfileAvatar,
                          height: 109.adaptSize,
                          width: 109.adaptSize,
                          radius: BorderRadius.circular(12.h),
                          alignment: Alignment.center,
                        ),
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgImage1,
                        //   height: 109.adaptSize,
                        //   width: 109.adaptSize,
                        //   radius: BorderRadius.circular(12.h),
                        //   alignment: Alignment.center,
                        // ),
                      ],
                      // Show user image if available
                      if (appointmentData['doctor'] != null &&
                          appointmentData['doctor']
                          ['profile_picture'] !=
                              null &&
                          appointmentData['doctor']['profile_picture']
                          ['url'] !=
                              null)
                        Image.network(
                          '${appointmentData['doctor']['profile_picture']['url']}',
                          height: 109.adaptSize,
                          width: 109.adaptSize,
                          fit: BoxFit.fill,
                        ),
                    ],
                  ),
                  // child: Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     CustomImageView(
                  //       imagePath: ImageConstant.imgImage,
                  //       height: 109.adaptSize,
                  //       width: 109.adaptSize,
                  //       radius: BorderRadius.circular(12.h),
                  //       alignment: Alignment.center,
                  //     ),
                  //     CustomImageView(
                  //       imagePath: ImageConstant.imgImage1,
                  //       height: 109.adaptSize,
                  //       width: 109.adaptSize,
                  //       radius: BorderRadius.circular(12.h),
                  //       alignment: Alignment.center,
                  //     ),
                  //     appointmentData['doctor'] != null &&
                  //             appointmentData['doctor']
                  //                     ['profile_picture'] !=
                  //                 null &&
                  //             appointmentData['doctor']
                  //                     ['profile_picture']['url'] !=
                  //                 null
                  //         ? Image.network(
                  //             '${appointmentData['doctor']['profile_picture']['url']}',
                  //             height: 109.adaptSize,
                  //             width: 109.adaptSize,
                  //             fit: BoxFit.fill,
                  //           )
                  //         : CustomImageView(
                  //             imagePath: ImageConstant.imgImage,
                  //             height: 109.adaptSize,
                  //             width: 109.adaptSize,
                  //             radius: BorderRadius.circular(12.h),
                  //             alignment: Alignment.center,
                  //           ),
                  //   ],
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 14.v,
                    bottom: 14.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${appointmentData['doctor']['first_name']} ${appointmentData['doctor']['last_name']}",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.v),
                      Text(
                        "${appointmentData['doctor']['specialty']['name']}",
                        style: CustomTextStyles.titleSmallBluegray700,
                      ),
                      SizedBox(height: 7.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            color: Colors.red,
                            margin: EdgeInsets.only(
                              top: 3.v,
                              bottom: 2.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "${appointmentData['doctor']['city']} ",
                              style: CustomTextStyles.bodyMediumBluegray700,
                            ),
                          ),
                        ],
                      ),
                    ],
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
