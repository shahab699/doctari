import 'package:doctari/DoctorsScreens/appointment_detail_for_doctor_screen/appointment_detail_for_doctor_screen.dart';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorResheduleWidgets extends StatefulWidget {
  const DoctorResheduleWidgets({Key? key}) : super(key: key);

  @override
  State<DoctorResheduleWidgets> createState() => _DoctorResheduleWidgetsState();
}

class _DoctorResheduleWidgetsState extends State<DoctorResheduleWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 12.v,
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
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
              "hello",
              style: theme.textTheme.titleMedium,
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
                        imagePath: ImageConstant.imgImage,
                        height: 109.adaptSize,
                        width: 109.adaptSize,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage109x109,
                        height: 109.adaptSize,
                        width: 109.adaptSize,
                        radius: BorderRadius.circular(
                          12.h,
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 5.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "hello",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "hello",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 5.v),
                      Text(
                        "hello",
                        style: CustomTextStyles.titleSmallBluegray700,
                      ),
                      SizedBox(height: 10.v),
                      Text(
                        "hello",
                        style: CustomTextStyles.bodyMediumBluegray700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCancel(context),
              _buildReschedule(context),
            ],
          ),
          SizedBox(height: 2.v),
        ],
      ),
    );
  }
}

Widget _buildCancel(BuildContext context) {
  return Expanded(
    child: CustomElevatedButton(
      text: "Cancel",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillGray,
    ),
  );
}

Widget _buildReschedule(BuildContext context) {
  return Expanded(
    child: CustomElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => AppointmentDetailForDoctorScreen(
        //             patientID: widget.appointmentData['patient']['id'] ?? '',
        //             gender: widget.appointmentData['patient']['gender'] ?? '',
        //             patientCity:
        //                 widget.appointmentData['patient']['city'] ?? '',
        //             patientDob: widget.appointmentData['patient']
        //                     ['date_of_birth'] ??
        //                 '',
        //             patientName:
        //                 widget.appointmentData['patient']['full_name'] ?? '',
        //             appointmentReason: widget.appointmentData['patient']
        //                     ['patient_appointment_reason'] ??
        //                 '',
        //             date: widget.date,
        //             time: widget.time,
        //             doctorName:
        //                 widget.appointmentData['doctor']['full_name'] ?? '',
        //           )
        //           ),
        // );
      },
      text:
          "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
      margin: EdgeInsets.only(left: 8.h),
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
    ),
  );
}
