import 'dart:convert';
import 'dart:developer';

import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/chat/chat_page.dart';
import 'package:doctari/meeting_service/jitsi_meeting_service.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/select_date_and_appointment_type.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_six.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';


class AppointmentDetailForDoctorScreen extends StatelessWidget {
  final int patientID;
  final String patientName;
  final String gender;
  final String patientDob;
  final String patientCity;
  final String appointmentReason;
  final String date;
  final String time;
  final String doctorName;
  final String doctorEmail;
  final String profile;
  final int appiontmentId;
  const AppointmentDetailForDoctorScreen(
      {required this.patientID,
      required this.patientName,
      required this.gender,
      required this.patientCity,
      required this.patientDob,
      required this.appointmentReason,
      required this.date,
      required this.time,
      required this.doctorName,
      required this.profile,
      required this.appiontmentId,
      //required this.appointmentData,
      Key? key, required this.doctorEmail})
      : super(
          key: key,
        );

  Future<void> cancelAppointment(
    String appointmentId,
    String token,
  ) async {
    debugger();
    final url = 'https://api.doctari.com/appointment/full/$appointmentId';

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'is_cancelled': true}),
    );

    if (response.statusCode == 200) {
      print('Appointment canceled successfully');
    } else {
      print('Failed to cancel appointment: ${response.body}');
    }
  }



  @override
  Widget build(BuildContext context) {
    //int? doctorId = Provider.of<ProviderForStoringValues>(context).doctorId;
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    int userIdv = int.parse(userId!);
    debugPrint("Appointment Id: $appiontmentId");

    print("$userIdv");
    print("$userToken");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: theme.colorScheme.primary,
          title: Text(
              "${AppLocalizations.of(context)!.appointDetailsAppiontmentDetailDocSecSC}"),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        //appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 2.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(context),
              SizedBox(height: 28.v),
              _buildNinetyThree(context, userIdv),
              SizedBox(height: 27.v),
              // Text(
              //   "${AppLocalizations.of(context)!.appiontTypeAppiontmentDetailDocSecSC}",
              //   style: theme.textTheme.titleLarge,
              // ),
              SizedBox(height: 6.v),
              // Text(
              //   "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}",
              //   style: CustomTextStyles.bodyLargeBluegray500,
              // ),
              SizedBox(height: 19.v),
              // Text(
              //   "${AppLocalizations.of(context)!.appiontDayTimeAppiontmentDetailDocSecSC}",
              //   style: theme.textTheme.titleLarge,
              // ),
              SizedBox(height: 8.v),
              // Text(
              //   "${date}",
              //   style: CustomTextStyles.bodyMediumGray600,
              // ),
              SizedBox(height: 20.v),
              // Text(
              //   "${AppLocalizations.of(context)!.appointTimeAppiontmentDetailDocSecSC}",
              //   style: theme.textTheme.titleLarge,
              // ),
              SizedBox(height: 7.v),
              // Text(
              //   "$time",
              //   style: CustomTextStyles.bodyMediumGray600,
              // ),
              SizedBox(height: 21.v),
              // Text(
              //   "${AppLocalizations.of(context)!.appointReasonAppiontmentDetailDocSecSC}",
              //   style: theme.textTheme.titleLarge,
              // ),
              SizedBox(height: 8.v),
              Text("$appointmentReason", style: TextStyle(color: Colors.black)),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildCancel1(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60,
      leadingWidth: 48.h,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          )),
      centerTitle: true,
      title: Text(
        "${AppLocalizations.of(context)!.appointDetailsAppiontmentDetailDocSecSC}",
        style: TextStyle(fontSize: 20),
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
          // CustomImageView(
          //   imagePath: ImageConstant.imgImage2,
          //   height: 109.adaptSize,
          //   width: 109.adaptSize,
          //   radius: BorderRadius.circular(
          //     12.h,
          //   ),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Image.network(profile,
          //       height: 109.adaptSize, width: 109.adaptSize, fit: BoxFit.fill),
          // ),

          //call image widget here show user image if null then show assets image
          profileImage(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$patientName",
                  style: theme.textTheme.titleMedium,
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
                  "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}: $patientDob",
                  style: CustomTextStyles.titleSmallBluegray700,
                ),
                SizedBox(height: 10.v),
                Row(
                  children: [
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgSettings,
                    //   height: 14.adaptSize,
                    //   width: 14.adaptSize,
                    //   margin: EdgeInsets.symmetric(vertical: 1.v),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}",
                        style: CustomTextStyles.bodyMediumInterBluegray700,
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

  /// Section Widget
  Widget _buildChat(BuildContext context, int doctorId) {
    return Expanded(
      child: CustomElevatedButton(
        height: 47.v,
        text: "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
        onPressed: () {
          print("chat button got pressed");

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPage(
              receiverUserId: patientID.toString(),
              receiverUserName: patientName,
              currentUserId: doctorId.toString(),
              currentUserName: doctorName,
            );
          }));
        },
        margin: EdgeInsets.only(right: 24.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 18.h),
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
  // Widget _buildVideoCall(BuildContext context) {
  //   return Expanded(
  //     child: actionButton(true, patientID.toString(), patientName),
  //     // CustomElevatedButton(
  //     //   height: 47.v,
  //     //   text: "Video Call",
  //     //   margin: EdgeInsets.only(left: 24.h),
  //     //   leftIcon: Container(
  //     //     margin: EdgeInsets.only(right: 18.h),
  //     //     child: CustomImageView(
  //     //       imagePath: ImageConstant.imgUpload,
  //     //       height: 15.v,
  //     //       width: 27.h,
  //     //       color: Colors.grey.shade500,
  //     //     ),
  //     //   ),
  //     //   buttonStyle: CustomButtonStyles.fillGray,
  //     // ),
  //   );
  // }
  Widget _buildVideoCall(BuildContext context) {
    return Expanded(
      child:
      CustomElevatedButton(
        height: 47.v,
        text: "Video Call",
        margin: EdgeInsets.only(left: 24.h),
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
        await MeetingService().joinMeeting(defaultRoomName, doctorName, doctorEmail);

        },
      ),
    );
  }

  /// Section Widget
  Widget _buildNinetyThree(BuildContext context, int doctorId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildChat(context, doctorId),
        _buildVideoCall(context),
      ],
    );
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        debugPrint("Cancel Appointment click");
        String? userToken = SessionManager.getUserToken();

         await cancelAppointment(
          appiontmentId.toString(),
          userToken!,
        );
      },
      height: 54.v,
      width: 147.h,
      text: "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
      buttonStyle: CustomButtonStyles.fillGrayTL12,
      buttonTextStyle: CustomTextStyles.titleMediumPrimary,
    );
  }

  /// Section Widget
  Widget _buildReschedule(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DateAndAppointment(appointmentId: appiontmentId.toString(),),
            ));
      },
      height: 54.v,
      width: 147.h,
      text:
          "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
      margin: EdgeInsets.only(left: 16.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
    );
  }

  /// Section Widget
  Widget _buildCancel1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 40.h,
        right: 40.h,
        bottom: 34.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCancel(context),
          _buildReschedule(context),
        ],
      ),
    );
  }

  // basic....
  ZegoSendCallInvitationButton actionButton(
          bool isVideo, String docId, String docName) =>
      ZegoSendCallInvitationButton(
        isVideoCall: isVideo,
        resourceID: "doctori_app",
        invitees: [
          ZegoUIKitUser(
            id: docId,
            name: docName,
          ),
        ],
      );
  //here create custom widget for profile image
  Widget profileImage(BuildContext context) {
    final String? profileImage = profile;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: profileImage != null && profileImage.isNotEmpty
          ? Image.network(
              profileImage,
              height: 109.adaptSize,
              width: 109.adaptSize,
              fit: BoxFit.fill,
            )
          : CustomImageView(
              imagePath: ImageConstant.dummyNetworkProfileAvatar,
              height: 109.adaptSize,
              width: 109.adaptSize,
              radius: BorderRadius.circular(
                12.h,
              ),
            ),
    );
  }
}
