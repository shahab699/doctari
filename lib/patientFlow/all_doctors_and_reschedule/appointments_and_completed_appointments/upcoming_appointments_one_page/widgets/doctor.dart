//updated code here
//last code stsrt from here
import 'package:doctari/chat/chat_page.dart';
import 'package:doctari/chat/chat_page_for_patient.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/BookAppointment.dart';
import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/widgets/tabbar_item_widget.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../meeting_service/jitsi_meeting_service.dart';

class DoctorScreen extends StatefulWidget {
  final int? docId;
  final String? docname,email;
  final int patientId;
  final String patientName;

  const DoctorScreen(
      {Key? key,
      this.docId,
      this.docname,
      required this.patientId,
      required this.patientName, this.email})
      : super(
          key: key,
        );

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late Future<Doctor> _doctorFuture;

  @override
  void initState() {
    super.initState();
    _doctorFuture = _fetchDoctorProfile();
  }

  Future<Doctor> _fetchDoctorProfile() async {
    try {
      // Fetch doctor profile from the API
      Doctor fetchedDoctor =
          await PatientApiService().fetchDoctorProfile(widget.docId!);

      return fetchedDoctor;
    } catch (error) {
      // Handle errors
      print("Error fetching doctor profile: $error");
      throw error; // Rethrow the error to indicate failure to fetch doctor profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text(
            "${AppLocalizations.of(context)!.doctorDetailsDoctorSC}",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: theme.colorScheme.primary,
        ),
        //appBar: _buildAppBar(context),
        body: FutureBuilder<Doctor>(
          future: _doctorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the data to load, display a loading indicator
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else if (snapshot.hasError) {
              // If an error occurs, display an error message
              return Text(
                  '${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}');
            } else {
              // Once the data is successfully fetched, display the doctor's details
              Doctor doctor = snapshot.data!;
              return Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 3.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(context, doctor.profile_image, doctor.full_name,
                        doctor.specialty, doctor.city),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildChat(context, widget.docId!),
                        _buildBookAppointment(context),
                      ],
                    ),
                    SizedBox(height: 34.v),
                    // _buildTabBar(context, doctor.score),
                    SizedBox(height: 26.v),
                    // _buildAboutMe(context),
                    // SizedBox(height: 26.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "Working Time",
                    //     style: theme.textTheme.titleLarge,
                    //   ),
                    // ),
                    // SizedBox(height: 8.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "Monday-Friday, 08.00 AM-18.00 PM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),
                    // SizedBox(height: 24.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "Past Consultations",
                    //     style: theme.textTheme.titleLarge,
                    //   ),
                    // ),
                    // SizedBox(height: 10.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),
                    // SizedBox(height: 9.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),
                    // SizedBox(height: 9.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),
                    // SizedBox(height: 5.v),
                  ],
                ),
              );
            }
          },
        ),
        // bottomNavigationBar: _buildBookAppointment(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowDownBlueGray800,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 16.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleSeven(
        text: "${AppLocalizations.of(context)!.doctorDetailsDoctorSC}",
      ),
    );
  }

  /// Section Widget
  Widget _buildCard(BuildContext context, String profileImage, String docName,
      String specialty, String city) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        padding: EdgeInsets.all(11.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Adjusted cross axis alignment
          children: [
            // CustomImageView(
            //   imagePath: ImageConstant.imgImage1,
            //   height: 109.adaptSize,
            //   width: 109.adaptSize,
            //   radius: BorderRadius.circular(
            //     12.h,
            //   ),
            // ),
            profileImage ==
                    '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                ? Container(
                    height: 87.v,
                    width: 92.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/doc.jpg'),
                      ),
                    ),
                  )
                : Container(
                    height: 87.v,
                    width: 92.h,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(profileImage),
                      ),
                    ),
                  ),
            SizedBox(width: 12.h), // Added spacing between image and text
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 9.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$docName",
                      // textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,

                      overflow: TextOverflow.ellipsis, // Handles overflow
                      maxLines: 2, // Limits to a single line
                    ),
                    SizedBox(height: 9.v),
                    Divider(
                      color: appTheme.gray200,
                    ),
                    SizedBox(height: 8.v),
                    Text(
                      "$specialty",
                      style: CustomTextStyles.titleSmallBluegray700,
                    ),
                    SizedBox(height: 11.v),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          color: Colors.grey,
                          height: 14.adaptSize,
                          width: 14.adaptSize,
                          margin: EdgeInsets.only(bottom: 3.v),
                        ),
                        SizedBox(
                            width: 4.h), // Added spacing between icon and text
                        Expanded(
                          child: Text(
                            "$city",
                            style: CustomTextStyles.bodyMediumInterBluegray700,
                            overflow: TextOverflow.ellipsis, // Handles overflow
                            maxLines: 1, // Limits to a single line
                          ),
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
    );
  }

  /// Section Widget
  // Widget _buildTabBar(BuildContext context, double score) {
  //   return Container(
  //     height: 102.v,
  //     padding: EdgeInsets.symmetric(horizontal: 24.h),
  //     decoration: AppDecoration.fillOnErrorContainer1,
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return SizedBox(
  //           width: 32.h,
  //         );
  //       },
  //       itemCount: 4,
  //       itemBuilder: (context, index) {
  //         return TabbarItemWidget(
  //           index: index,
  //           score: score,
  //         );
  //       },
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildAboutMe(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.appointmentPriceDoctorSC}",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 8.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${AppLocalizations.of(context)!.onlineDoctorSC}:",
                        style: CustomTextStyles.titleMediumff333333,
                      ),
                      TextSpan(
                          text: " \$",
                          style: TextStyle(color: Color(0xff0EBE7F))),
                      TextSpan(
                        text: "",
                        style: CustomTextStyles.titleMediumff0ebe7f,
                      ),
                      TextSpan(
                        text: "100.00",
                        style: CustomTextStyles.bodyLargee5677294,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 36.v),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.inPersonDoctorSC}:",
                      style: CustomTextStyles.titleMediumff333333,
                    ),
                    TextSpan(
                        text: " \$",
                        style: TextStyle(color: Color(0xff0EBE7F))),
                    TextSpan(
                      text: "",
                      style: CustomTextStyles.titleMediumff0ebe7f,
                    ),
                    TextSpan(
                      text: "100.00",
                      style: CustomTextStyles.bodyLargee5677294,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChat(BuildContext context, int doctorId) {
    return Expanded(
      child: CustomElevatedButton(
        text: "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
        onPressed: () {
          print("chat button got pressed");

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPageForPatient(
              receiverUserId: widget.docId.toString(),
              receiverUserName: widget.docname!,
              currentUserId: widget.patientId.toString(),
              currentUserName: widget.patientName,
            );
          }));
        },
        margin: EdgeInsets.only(right: 24.h, left: 24),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 18.h, left: 24),
          child: CustomImageView(
            imagePath: ImageConstant.imgUserBlueGray40001,
            color: Colors.grey.shade500,
            height: 19.v,
            width: 21.h,
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget

  Widget _buildBookAppointment(BuildContext context) {
    // return actionButton(true, widget.docId!, widget.docname!);

    return Expanded(
      child:
      CustomElevatedButton(
        text: "Video Call",
        margin: EdgeInsets.only(left: 24.h,right: 24.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 18.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgUpload,
            height: 15.v,
            width: 27.h,
            color: Colors.grey.shade500,
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGray,
        onPressed: () async {
          const String defaultRoomName = 'DifferentTerrainsConflictEither';
          await MeetingService().joinMeeting(defaultRoomName, widget.patientName, widget.email??"");

        },
      ),
    );
    // return Expanded(
    //   child: CustomElevatedButton(
    //     onPressed: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => BookingAppointmentDetails(
    //                     doctorId: widget.docId!,
    //                   )));
    //     },
    //     text: "Book Appointment",
    //     margin: EdgeInsets.only(
    //       left: 24.h,
    //       right: 24.h,
    //       bottom: 25.v,
    //     ),
    //     buttonStyle: CustomButtonStyles.fillPrimary,
    //     buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
    //   ),
    // );
  }

  // Widget actionButton(bool isVideo, int docId, String docName) {
  //   return GestureDetector(
  //     onTap: () {
  //       print("button click");
  //       ZegoSendCallInvitationButton(
  //         isVideoCall: isVideo,
  //         resourceID: "doctori_app",
  //         invitees: [
  //           ZegoUIKitUser(
  //             id: docId.toString(),
  //             name: docName,
  //           ),
  //         ],
  //         // Use an invisible icon instead of a Container
  //         icon: ButtonIcon(
  //           icon: Icon(Icons.circle, size: 0), // Making it invisible
  //         ),
  //       );
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 22),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           // ZegoSendCallInvitationButton with an invisible icon
  //           // ZegoSendCallInvitationButton(
  //           //   isVideoCall: isVideo,
  //           //   resourceID: "doctori_app",
  //           //   invitees: [
  //           //     ZegoUIKitUser(
  //           //       id: docId.toString(),
  //           //       name: docName,
  //           //     ),
  //           //   ],
  //           //   // Use an invisible icon instead of a Container
  //           //   icon: ButtonIcon(
  //           //     icon: Icon(Icons.circle, size: 0), // Making it invisible
  //           //   ),
  //           // ),

  //           // Custom button overlaying ZegoSendCallInvitationButton
  //           GestureDetector(
  //             onTap: () {
  //               ZegoSendCallInvitationButton(
  //                 isVideoCall: isVideo,
  //                 resourceID: "doctori_app",
  //                 invitees: [
  //                   ZegoUIKitUser(
  //                     id: docId.toString(),
  //                     name: docName,
  //                   ),
  //                 ],
  //                 //icon: IconButton(icon: ,),
  //               );
  //             },
  //             child: Container(
  //               height: 47.v,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 color: appTheme.gray200,
  //               ),
  //               child: Center(
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 24, right: 24),
  //                   child: Row(
  //                     children: [
  //                       Image.asset(
  //                         'assets/images/video.png',
  //                         height: 19.v,
  //                         width: 21.h,
  //                       ),
  //                       SizedBox(width: 10),
  //                       Text(
  //                         'Video Call',
  //                         style: CustomTextStyles.titleSmallPrimary,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget actionButton(bool isVideo, int docId, String docName) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 22),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         ZegoSendCallInvitationButton(
  //           isVideoCall: isVideo,
  //           resourceID: "doctori_app",
  //           invitees: [
  //             ZegoUIKitUser(
  //               id: docId.toString(),
  //               name: docName,
  //             ),
  //           ],
  //           iconVisible: false,
  //         ),
  //         // Overlay your custom icon on top of the default button
  //         Container(
  //           height: 47.v,
  //           //width: 130.v,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             // color: Colors.grey.shade500,
  //             color: appTheme.gray200,
  //           ),
  //           child: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 24, right: 24),
  //               child: Row(
  //                 children: [
  //                   Image.asset(
  //                     'assets/images/video.png',
  //                     height: 19.v,
  //                     width: 21.h,
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Text(
  //                     'Video Call',
  //                     style: CustomTextStyles.titleSmallPrimary,
  //                     // style: TextStyle(
  //                     //   fontSize: 14,
  //                     //   fontWeight: FontWeight.bold,
  //                     // ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  ZegoSendCallInvitationButton actionButton(
          bool isVideo, int docId, String docName) =>
      ZegoSendCallInvitationButton(
        isVideoCall: isVideo,
        resourceID: "doctori_app",
        //resourceID: "doctariapp",
        invitees: [
          ZegoUIKitUser(
            id: docId.toString(),
            name: docName,
          ),
        ],
        //icon: IconButton(icon: ,),
      );
  // Widget _buildBookAppointment(BuildContext context) {
  //   return actionButton(true, widget.docId!, widget.docname!);
  //   // CustomElevatedButton(
  //   //   onPressed: () {
  //   //     Navigator.push(
  //   //         context,
  //   //         MaterialPageRoute(
  //   //             builder: (context) => BookingAppointmentDetails(
  //   //                   doctorId: widget.docId!,
  //   //                 )));
  //   //   },
  //   //   text: "Book Appointment",
  //   //   margin: EdgeInsets.only(
  //   //     left: 24.h,
  //   //     right: 24.h,
  //   //     bottom: 25.v,
  //   //   ),
  //   //   buttonStyle: CustomButtonStyles.fillPrimary,
  //   //   buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
  //   // );
  // }

  // Widget _buildBookAppointment(BuildContext context) {
  //   return ZegoSendCallInvitationButton(
  //     isVideoCall: true, // Whether it is a video call
  //     resourceID: "doctori_app", // The resource ID for Zego calls
  //     invitees: [
  //       ZegoUIKitUser(
  //         id: widget.docId!
  //             .toString(), // Make sure docId is non-null by using '!'
  //         name: widget.docname!,
  //       ),
  //     ],
  //     // Handle what happens when the button is pressed (e.g., initiating the call)
  //     // onPressed: () {
  //     //   print("Button pressed. Initiating call...");
  //     // },
  //     // // Handle what happens if there's an error during the process
  //     // onError: (int errorCode, String errorMessage) {
  //     //   print("Error occurred during call initiation: $errorCode - $errorMessage");
  //     // },
  //   );
  // }

  // Widget _buildBookAppointment(BuildContext context) {
  //   return Container(
  //     height: 30.0,
  //     width: 60.0,
  //     color: Colors.grey, // Set the background color to grey
  //     child: ZegoSendCallInvitationButton(
  //       isVideoCall: true, // Whether it is a video call
  //       resourceID: "doctori_app", // The resource ID for Zego calls
  //       invitees: [
  //         ZegoUIKitUser(
  //           id: widget.docId!.toString(), // Ensure docId is non-null
  //           name: widget.docname!,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ZegoSendCallInvitationButton actionButton(
  //         bool isVideo, int docId, String docName) =>
  //     ZegoSendCallInvitationButton(
  //       isVideoCall: isVideo,
  //       resourceID: "doctori_app",
  //       invitees: [
  //         ZegoUIKitUser(
  //           id: docId.toString(),
  //           name: docName,
  //         ),
  //       ],
  //     );
}
