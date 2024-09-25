import 'package:doctari/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CompletedappointmentsItemWidget extends StatelessWidget {
  final Map<String, dynamic> appointmentData;
  final String date;
  final String time;
  const CompletedappointmentsItemWidget(
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
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                  style: theme.textTheme.titleMedium,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.v),
                  child: Text(
                    "5.0",
                    style: CustomTextStyles.labelLargeGray600_1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 5.v,
                    bottom: 4.v,
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
          ),
          SizedBox(height: 25.v),
          Padding(
            padding: EdgeInsets.only(right: 22.h),
            child: Row(
              children: [
                SizedBox(
                  height: 109.adaptSize,
                  width: 109.adaptSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.dummyNetworkProfileAvatar,
                        height: 109.adaptSize,
                        width: 109.adaptSize,
                        radius: BorderRadius.circular(12.h),
                        alignment: Alignment.center,
                      ),
                      if (
                         appointmentData["patient"]["profile_picture"]
                          ["url"] !=
                              null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(
                            '${appointmentData["patient"]["profile_picture"]["url"]}',
                            height: 109.adaptSize,
                            width: 109.adaptSize,
                            fit: BoxFit.fill,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value:
                                    loadingProgress.expectedTotalBytes !=
                                        null
                                        ? loadingProgress
                                        .cumulativeBytesLoaded /
                                        (loadingProgress
                                            .expectedTotalBytes ??
                                            1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 109.adaptSize,
                //   width: 109.adaptSize,
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       CustomImageView(
                //         imagePath: ImageConstant.imgImage,
                //         height: 109.adaptSize,
                //         width: 109.adaptSize,
                //         radius: BorderRadius.circular(
                //           12.h,
                //         ),
                //         alignment: Alignment.center,
                //       ),
                //       CustomImageView(
                //         imagePath: ImageConstant.imgImage4,
                //         height: 109.adaptSize,
                //         width: 109.adaptSize,
                //         radius: BorderRadius.circular(
                //           12.h,
                //         ),
                //         alignment: Alignment.center,
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 5.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${date}",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "${time}",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 5.v),
                      Text(
                        "${appointmentData['patient']['full_name']}",
                        style: CustomTextStyles.titleSmallBluegray700,
                      ),
                      SizedBox(height: 10.v),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            color: Colors.red,
                            margin: EdgeInsets.only(
                              top: 2.v,
                              bottom: 3.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "${appointmentData['patient']['city']}",
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
