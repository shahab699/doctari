// import 'package:doctari/DoctorsScreens/appointment_detail_for_doctor_screen/appointment_detail_for_doctor_screen.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// // ignore: must_be_immutable
// class UpcomingappointmentsItemWidget extends StatelessWidget {
//   const UpcomingappointmentsItemWidget({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.h,
//         vertical: 12.v,
//       ),
//       margin: EdgeInsets.symmetric(
//         vertical: 10
//       ),
//       decoration: AppDecoration.outlineGray.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder12,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 4.h),
//             child: Text(
//               "In-Person Visit",
//               style: theme.textTheme.titleMedium,
//             ),
//           ),
//           SizedBox(height: 25.v),
//           Padding(
//             padding: EdgeInsets.only(right: 22.h),
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
//                         imagePath: ImageConstant.imgImage109x109,
//                         height: 109.adaptSize,
//                         width: 109.adaptSize,
//                         radius: BorderRadius.circular(
//                           12.h,
//                         ),
//                         alignment: Alignment.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 12.h,
//                     top: 5.v,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Sep 30, 2024 ",
//                         style: theme.textTheme.titleMedium,
//                       ),
//                       SizedBox(height: 3.v),
//                       Text(
//                         "10:00 AM",
//                         style: theme.textTheme.titleMedium,
//                       ),
//                       SizedBox(height: 5.v),
//                       Text(
//                         "Abdul Rahman",
//                         style: CustomTextStyles.titleSmallBluegray700,
//                       ),
//                       SizedBox(height: 10.v),
//                       Text(
//                         "Age: 22yrs    Gender: Male",
//                         style: CustomTextStyles.bodyMediumBluegray700,
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
//               _buildReschedule(context),
//             ],
//           ),
//           SizedBox(height: 2.v),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         text: "Cancel",
//         margin: EdgeInsets.only(right: 8.h),
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildReschedule(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailForDoctorScreen(),));
//         },
//         text: "Reschedule",
//         margin: EdgeInsets.only(left: 8.h),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }
// }

//here to start code for incorrect parrent widget error
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:math';

// import 'package:doctari/DoctorsScreens/appointment_detail_for_doctor_screen/appointment_detail_for_doctor_screen.dart';
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:http/http.dart' as http;

// class UpcomingappointmentsItemWidget extends StatefulWidget {
//   final Map<String, dynamic> appointmentData;
//   final String date;
//   final String time;

//   const UpcomingappointmentsItemWidget({
//     Key? key,
//     required this.date,
//     required this.time,
//     required this.appointmentData,
//   }) : super(key: key);

//   @override
//   State<UpcomingappointmentsItemWidget> createState() =>
//       _UpcomingappointmentsItemWidgetState();
// }

// class _UpcomingappointmentsItemWidgetState
//     extends State<UpcomingappointmentsItemWidget> {
//   @override
//   Widget build(BuildContext context) {
//     print("print id:${widget.appointmentData['id']}");
//     // print("date: ${widget.appointmentData['date']}");
//     print('print response of appointment ${widget.appointmentData}');
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.h,
//         vertical: 12.v,
//       ),
//       margin: EdgeInsets.symmetric(vertical: 10),
//       decoration: AppDecoration.outlineGray.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder12,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 4.h),
//             child: Text(
//               "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
//               style: theme.textTheme.titleMedium,
//             ),
//           ),
//           SizedBox(height: 25.v),
//           Padding(
//             padding: EdgeInsets.only(right: 22.h),
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
//                       // CustomImageView(
//                       //   imagePath: ImageConstant.imgImage109x109,
//                       //   height: 109.adaptSize,
//                       //   width: 109.adaptSize,
//                       //   radius: BorderRadius.circular(
//                       //     12.h,
//                       //   ),
//                       //   alignment: Alignment.center,
//                       // ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Image.network(
//                             '${widget.appointmentData["patient"]["profile_picture"]["url"]}',
//                             height: 109.adaptSize,
//                             width: 109.adaptSize,
//                             fit: BoxFit.fill),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 12.h,
//                     top: 5.v,
//                   ),
//                   child: Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${widget.date ?? ''}",
//                           style: theme.textTheme.titleMedium,
//                         ),
//                         SizedBox(height: 3.v),
//                         Text(
//                           "${widget.time ?? ''}",
//                           style: theme.textTheme.titleMedium,
//                         ),
//                         SizedBox(height: 5.v),
//                         Text(
//                           "${widget.appointmentData['patient_name'] ?? ''}",
//                           style: CustomTextStyles.titleSmallBluegray700,
//                         ),
//                         SizedBox(height: 10.v),
//                         Text(
//                           "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}: ${widget.appointmentData['patient']['gender'] ?? ''}",
//                           style: CustomTextStyles.bodyMediumBluegray700,
//                         ),
//                       ],
//                     ),
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
//               //here add new cancel button
//               // Expanded(
//               //   child: ElevatedButton(
//               //       onPressed: () {
//               //         print('click button');
//               //         final id = widget.appointmentData['id'];
//               //         String? userToken = SessionManager.getUserToken();
//               //         cancelAppointment(id, userToken!);
//               //       },
//               //       child: Text(
//               //         'Cancel',
//               //         style: TextStyle(color: Colors.white),
//               //       )),
//               // ),

//               _buildReschedule(context),
//             ],
//           ),
//           SizedBox(height: 2.v),
//         ],
//       ),
//     );
//   }

//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: () {
//           //user token here set for pass in function
//           String? userToken = SessionManager.getUserToken();
//           //here get id of appiontment get for cancel and other things
//           final id = widget.appointmentData['id'];
//           cancelAppointment(id, userToken!);
//         },
//         text: "Cancel",
//         margin: EdgeInsets.only(right: 8.h),
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   Widget _buildReschedule(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => AppointmentDetailForDoctorScreen(
//                       patientID: widget.appointmentData['patient']['id'] ?? '',
//                       gender: widget.appointmentData['patient']['gender'] ?? '',
//                       patientCity:
//                           widget.appointmentData['patient']['city'] ?? '',
//                       patientDob: widget.appointmentData['patient']
//                               ['date_of_birth'] ??
//                           '',
//                       patientName:
//                           widget.appointmentData['patient']['full_name'] ?? '',
//                       appointmentReason: widget.appointmentData['patient']
//                               ['patient_appointment_reason'] ??
//                           '',
//                       date: widget.date,
//                       time: widget.time,
//                       doctorName:
//                           widget.appointmentData['doctor']['full_name'] ?? '',
//                       profile: widget.appointmentData["patient"]
//                           ["profile_picture"]["url"],
//                       appiontmentId: widget.appointmentData['id'],
//                     )),
//           );
//         },
//         text:
//             "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
//         margin: EdgeInsets.only(left: 8.h),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }

//   //cancel appiontment function

//   Future<void> cancelAppointment(
//     int appointmentId,
//     String token,
//   ) async {
//     //debugger();
//     final url =
//         'https://api-b2c-refactor.doctari.com/appointment/full/$appointmentId';

//     final response = await http.patch(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({'is_cancelled': true}),
//     );

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Appointment canceled successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       print('Appointment canceled successfully');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to cancel appointment',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       print('Failed to cancel appointment: ${response.body}');
//     }
//   }

// }

//here use update code

import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:doctari/DoctorsScreens/appointment_detail_for_doctor_screen/appointment_detail_for_doctor_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class UpcomingappointmentsItemWidget extends StatefulWidget {
  final Map<String, dynamic> appointmentData;
  final String date;
  final String time;

  const UpcomingappointmentsItemWidget({
    Key? key,
    required this.date,
    required this.time,
    required this.appointmentData,
  }) : super(key: key);

  @override
  State<UpcomingappointmentsItemWidget> createState() =>
      _UpcomingappointmentsItemWidgetState();
}

class _UpcomingappointmentsItemWidgetState
    extends State<UpcomingappointmentsItemWidget> {
  bool isLoading = false;
  int? calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) return null;

    try {
      DateTime dob = DateTime.parse(dateOfBirth);
      DateTime today = DateTime.now();

      int age = today.year - dob.year;

      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }

      return age;
    } catch (e) {
      print('Error parsing date_of_birth: $e');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    print("print id:${widget.appointmentData['id']}");
    print('print response of appointment ${widget.appointmentData}');
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 12.v,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 25.v),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppointmentDetailForDoctorScreen(
                          patientID:
                              widget.appointmentData['patient']['id'] ?? '',
                          gender:
                              widget.appointmentData['patient']['gender'] ?? '',
                          patientCity:
                              widget.appointmentData['patient']['city'] ?? '',
                          patientDob: widget.appointmentData['patient']
                                  ['date_of_birth'] ??
                              '',
                          patientName: widget.appointmentData['patient']
                                  ['full_name'] ??
                              '',
                          appointmentReason: widget.appointmentData['patient']
                                  ['patient_appointment_reason'] ??
                              '',
                          date: widget.date,
                          time: widget.time,
                          doctorName: widget.appointmentData['doctor']
                                  ['full_name'] ??
                              '',
                          profile: widget.appointmentData["patient"]
                              ["profile_picture"]??"",
                          appiontmentId: widget.appointmentData['id'], doctorEmail:  widget.appointmentData['doctor']['email'],
                        )),
              );
            },
            child: Padding(
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
                        if (isLoading) // Replace `isLoading` with your actual loading state variable
                          CircularProgressIndicator(), // Adjust properties if needed
                        if (!isLoading &&
                            widget.appointmentData["patient"]["profile_picture"]!=
                                null)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              '${widget.appointmentData["patient"]["profile_picture"]}',
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
                  //         radius: BorderRadius.circular(12.h),
                  //         alignment: Alignment.center,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: Image.network(
                  //             '${widget.appointmentData["patient"]["profile_picture"]["url"]}',
                  //             height: 109.adaptSize,
                  //             width: 109.adaptSize,
                  //             fit: BoxFit.fill),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(width: 12.h), // Added spacing between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.date ?? ''}",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 3.v),
                        Text(
                          "${widget.time ?? ''}",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          "${widget.appointmentData['patient_name'] ?? ''}",
                          style: CustomTextStyles.titleSmallBluegray700,
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}: ${widget.appointmentData['patient']['gender'] ?? ''}",
                          style: CustomTextStyles.bodyMediumBluegray700,
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.age}: ${calculateAge(widget.appointmentData['patient']['date_of_birth']) ?? ''}",
                          style: CustomTextStyles.bodyMediumBluegray700,
                        ),
                      ],
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
              Flexible(
                child: _buildCancel(context),
              ),
              SizedBox(width: 8.h), // Spacing between buttons
              Flexible(
                child: _buildReschedule(context),
              ),
            ],
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        //user token here set for pass in function
        String? userToken = SessionManager.getUserToken();
        //here get id of appiontment get for cancel and other things
        final id = widget.appointmentData['id'];
        cancelAppointment(id, userToken!);
      },
      text: "Cancel",
      margin: EdgeInsets.zero, // Adjust margin if necessary
      buttonStyle: CustomButtonStyles.fillGray,
    );
  }

  Widget _buildReschedule(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentDetailForDoctorScreen(
                    patientID: widget.appointmentData['patient']['id'] ?? '',
                    gender: widget.appointmentData['patient']['gender'] ?? '',
                    patientCity:
                        widget.appointmentData['patient']['city'] ?? '',
                    patientDob: widget.appointmentData['patient']
                            ['date_of_birth'] ??
                        '',
                    patientName:
                        widget.appointmentData['patient']['full_name'] ?? '',
                    appointmentReason: widget.appointmentData['patient']
                            ['patient_appointment_reason'] ??
                        '',
                    date: widget.date,
                    time: widget.time,
                    doctorName:
                        widget.appointmentData['doctor']['full_name'] ?? '',
                    profile: widget.appointmentData["patient"]
                        ["profile_picture"]??"",
                    appiontmentId: widget.appointmentData['id'], doctorEmail: widget.appointmentData['doctor']['email'] ?? '',
                  )),
        );
      },
      text:
          "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
      margin: EdgeInsets.zero, // Adjust margin if necessary
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
    );
  }

  //cancel appointment function
  Future<void> cancelAppointment(
    int appointmentId,
    String token,
  ) async {
    final url =
        'https://api-b2c-refactor.doctari.com/appointment/full/$appointmentId/';

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'is_cancelled': true}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment canceled successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      print('Appointment canceled successfully');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to cancel appointment',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      print('Failed to cancel appointment: ${response.body}');
    }
  }
}
