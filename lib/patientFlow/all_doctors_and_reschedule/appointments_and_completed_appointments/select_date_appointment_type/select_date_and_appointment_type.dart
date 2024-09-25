import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/widget/date_picker.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/widget/hours_tab.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/widget/reschedule_pop_up.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class DateAndAppointment extends StatelessWidget {
  DateAndAppointment({Key? key}) : super(key: key);

  final TextEditingController _appointmentReasonControll =
      TextEditingController();

  List<DateTime> getNextSevenDays() {
    List<DateTime> nextSevenDays = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      nextSevenDays.add(today.add(Duration(days: i)));
    }
    debugPrint("today: $today");
    debugPrint("nextSevenDays: $nextSevenDays");

    return nextSevenDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 15.h,
            right: 15.h,
            top: 10.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onTap: () {
              //     // getNextSevenDays();
              //   },
              //   child: Text(
              //     "Appointment Type",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 22,
              //         fontWeight: FontWeight.w500),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Online consultation",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //           fontWeight: FontWeight.w300),
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //           TextSpan(
              //               text: '\$ ',
              //               style: TextStyle(color: Color(0xff0EBE7F))),
              //           TextSpan(
              //               text: '28.00',
              //               style: TextStyle(color: Colors.black))
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Text(
              //   "Appointment Reason",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 22,
              //       fontWeight: FontWeight.w500),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextFormField(
              //   controller: _appointmentReasonControll,
              //   hintText: "Write reason for appointment",
              //   contentPadding: EdgeInsets.symmetric(
              //     horizontal: 16.h,
              //     vertical: 12.v,
              //   ),
              //   borderDecoration: TextFormFieldStyleHelper.outlineGrayTL12,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Text(
                "Select Date",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                // height: 300, // Provide a fixed height
                child: CalendarWidget(
                  onDateSelected: (DateTime selectedDate) {
                    // Handle the selected date here
                    print("Selected Date: $selectedDate");
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              HourstabsForAppointmentWidget(
                onTimeSelected: (selectedTime) {
                  // Handle the selected time here
                  selectedTime = selectedTime;
                  print("Selected Time: $selectedTime");
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirm(context),
    );
  }

  /// Section Widget
  // Widget _buildHoursTabs(BuildContext context) {
  //   List<String> hours = [
  //     '08:00 AM',
  //     '09:00 AM',
  //     '10:00 AM',
  //     '11:00 AM',
  //     '12:00 PM',
  //     '01:00 PM',
  //     '02:00 PM',
  //     '03:00 PM',
  //     '04:00 PM',
  //     '05:00 PM',
  //     '06:00 PM',
  //     '07:00 PM'
  //   ];

  //   return Wrap(
  //     runSpacing: 13.5.v,
  //     spacing: 20.5.h,
  //     children: hours
  //         .map((hour) => HourstabsForAppointmentItemWidget(time: hour))
  //         .toList(),
  //   );
  // }
  // Widget _buildHoursTabs(BuildContext context) {
  //   return Wrap(
  //     runSpacing: 13.5.v,
  //     spacing: 20.5.h,
  //     children: List<Widget>.generate(
  //         12, (index) => HourstabsForAppointmentItemWidget()),
  //   );
  // }

  /// Section Widget
  Widget _buildConfirm(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: CustomElevatedButton(
        // height: 54.v,
        text: "Reschedule",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopupReschedule();
            },
          );
        },
        margin: EdgeInsets.only(
          // left: 24.h,
          // right: 24.h,
          bottom: 10.v,
        ),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
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
        text: "Book Appointment",
      ),
    );
  }
}
