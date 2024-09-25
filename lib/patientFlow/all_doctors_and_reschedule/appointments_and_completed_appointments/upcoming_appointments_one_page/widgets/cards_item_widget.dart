//here updated code
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/select_date_and_appointment_type.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/upcoming_appointments_one_page/widgets/doctor.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CardsItemWidget extends StatelessWidget {
  final Map<String, dynamic> appointmentData;
  final String date;
  final String time;

  const CardsItemWidget({
    required this.appointmentData,
    required this.date,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("date ${date}");
    print("time ${time}");
    print("appointmentData ${appointmentData['doctor']['last_name']}");

    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorScreen(
                    //docId: id,
                    //docname: docName,
                    patientId: appointmentData['patient']['id'],
                    patientName: appointmentData['patient']['full_name'],
                  ),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$date - $time",
                  style: CustomTextStyles.titleSmallBluegray900,
                ),
                SizedBox(height: 23.v),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorScreen(
                          docId: appointmentData['doctor']['id'],
                          docname: appointmentData['doctor']['last_name'],
                          patientId: appointmentData['patient']['id'],
                          patientName: appointmentData['patient']['full_name'],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Row(
                      children: [
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
                                // CustomImageView(
                                //   imagePath: ImageConstant.imgImage,
                                //   height: 109.adaptSize,
                                //   width: 109.adaptSize,
                                //   radius: BorderRadius.circular(12.h),
                                //   alignment: Alignment.center,
                                // ),
                                CustomImageView(
                                  imagePath: ImageConstant.dummyNetworkProfileAvatar,
                                  height: 109.adaptSize,
                                  width: 109.adaptSize,
                                  radius: BorderRadius.circular(12.h),
                                  alignment: Alignment.center,
                                ),
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
                        SizedBox(width: 12.h),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 14.v, bottom: 14.v),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${appointmentData['doctor']['last_name']}",
                                      style: theme.textTheme.titleMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.v),
                                Text(
                                  "${appointmentData['doctor']['specialty']['name']}",
                                  style: CustomTextStyles.titleSmallBluegray700,
                                ),
                                SizedBox(height: 8.v),
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgSettings,
                                      height: 14.adaptSize,
                                      width: 14.adaptSize,
                                      color: Colors.red,
                                      margin: EdgeInsets.only(
                                          top: 2.v, bottom: 3.v),
                                    ),
                                    SizedBox(width: 4.h),
                                    Text(
                                      "${appointmentData['doctor']['city']}",
                                      style: CustomTextStyles
                                          .bodyMediumBluegray700,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCancel(context),
                    _buildReschedule(
                      context,
                      appointmentData['doctor']['id'],
                      appointmentData['doctor']['full_name'],
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

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 37.v,
        text:
            "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(right: 8.h),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildReschedule(BuildContext context, int id, String docName) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorScreen(
                docId: id,
                docname: docName,
                patientId: appointmentData['patient']['id'],
                patientName: appointmentData['patient']['full_name'],
              ),
            ),
          );
        },
        height: 37.v,
        text:
            "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(left: 8.h),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }
}

//this is full code where show error of widgets error
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/select_date_and_appointment_type.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/upcoming_appointments_one_page/widgets/doctor.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// // ignore: must_be_immutable
// class CardsItemWidget extends StatelessWidget {
//   final Map<String, dynamic> appointmentData;
//   final String date;
//   final String time;
//   const CardsItemWidget(
//       {required this.appointmentData,
//       required this.date,
//       required this.time,
//       Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     print("date ${date}");
//     print("time ${time}");
//     print("appointmentData ${appointmentData['doctor']['last_name']}");
//     return Container(
//       padding: EdgeInsets.all(15.h),
//       decoration: AppDecoration.outlineGray.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder12,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "${date} - ${time}",
//             style: CustomTextStyles.titleSmallBluegray900,
//           ),
//           SizedBox(height: 23.v),
//           Padding(
//             padding: EdgeInsets.only(right: 29.h),
//             child: Row(
//               children: [
//                 SizedBox(
//                   height: 109.adaptSize,
//                   width: 109.adaptSize,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CustomImageView(
//                         imagePath: ImageConstant.imgImage,
//                         height: 109.adaptSize,
//                         width: 109.adaptSize,
//                         radius: BorderRadius.circular(
//                           12.h,
//                         ),
//                         alignment: Alignment.center,
//                       ),
//                       CustomImageView(
//                         imagePath: ImageConstant.imgImage1,
//                         height: 109.adaptSize,
//                         width: 109.adaptSize,
//                         radius: BorderRadius.circular(
//                           12.h,
//                         ),
//                         alignment: Alignment.center,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Expanded(
//                           child: appointmentData != null &&
//                                   appointmentData['doctor'] != null &&
//                                   appointmentData['doctor']
//                                           ['profile_picture'] !=
//                                       null &&
//                                   appointmentData['doctor']['profile_picture']
//                                           ['url'] !=
//                                       null
//                               ? Image.network(
//                                   '${appointmentData['doctor']['profile_picture']['url']}',
//                                   height: 109.adaptSize,
//                                   width: 109.adaptSize,
//                                   fit: BoxFit.fill,
//                                 )
//                               : CustomImageView(
//                                   imagePath: ImageConstant.imgImage,
//                                   height: 109.adaptSize,
//                                   width: 109.adaptSize,
//                                   radius: BorderRadius.circular(12.h),
//                                   alignment: Alignment.center,
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 12.h,
//                     top: 14.v,
//                     bottom: 14.v,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           // ${appointmentData['doctor']['first_name']}
//                           Text(
//                             "${appointmentData['doctor']['last_name']}",
//                             style: theme.textTheme.titleMedium,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10.v),
//                       Text(
//                         "${appointmentData['doctor']['specialty']['name']}",
//                         style: CustomTextStyles.titleSmallBluegray700,
//                       ),
//                       SizedBox(height: 8.v),
//                       Row(
//                         children: [
//                           CustomImageView(
//                             imagePath: ImageConstant.imgSettings,
//                             height: 14.adaptSize,
//                             width: 14.adaptSize,
//                             color: Colors.red,
//                             margin: EdgeInsets.only(
//                               top: 2.v,
//                               bottom: 3.v,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 4.h),
//                             child: Text(
//                               "${appointmentData['doctor']['city']} ",
//                               style: CustomTextStyles.bodyMediumBluegray700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 24.v),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildCancel(context),
//               _buildReschedule(context, appointmentData['doctor']['id'],
//                   appointmentData['doctor']['full_name']),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         height: 37.v,
//         text:
//             "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
//         margin: EdgeInsets.only(right: 8.h),
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildReschedule(BuildContext context, int id, String docName) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DoctorScreen(
//                   docId: id,
//                   docname: docName,
//                   patientId: appointmentData['patient']['id'],
//                   patientName: appointmentData['patient']['full_name'],
//                 ),
//               ));
//         },
//         height: 37.v,
//         text:
//             "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
//         margin: EdgeInsets.only(left: 8.h),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }
// }
