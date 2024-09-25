import 'dart:convert';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/web%20view/payment_methode.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingAppointmentDetails extends StatefulWidget {
  final int doctorId;
  BookingAppointmentDetails({required this.doctorId, Key? key})
      : super(key: key);

  @override
  State<BookingAppointmentDetails> createState() =>
      _BookingAppointmentDetailsState();
}

class _BookingAppointmentDetailsState extends State<BookingAppointmentDetails> {
  final TextEditingController _appointmentReasonControll =
      TextEditingController();

  DateTime _currentDates = DateTime.now();
  bool _isWeekView = true;
  //Set<String> clickedButtons = {};
  List<String> startTimes = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedTime;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _currentDates = _getStartOfWeek(DateTime.now());
    calculateDates();
  }

  Future<void> fetchSchedules(
      int doctorId, String startGt, String startLt, String token) async {
    try {
      final Uri uri = Uri.parse(
          'https://api-b2c-refactor.doctari.com/schedule/?start__gt=${Uri.encodeComponent(startGt)}&start__lt=${Uri.encodeComponent(startLt)}&doctor=$doctorId');

      final response = await http.get(uri, headers: {
        'Authorization':
            //'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI1NTMxNjQzLCJpYXQiOjE3MjUyNzI0NDMsImp0aSI6Ijg5MDk5MzdkY2EzNTQ1MDdhMjM3ZWY4ODEzZmZlNmM5IiwidXNlcl9pZCI6MzMzfQ.ZZ7Curefft2LhjKGGePMWx_HnAeHOrN-FXCXFR79Zpk',
            'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<String> extractedStartTimes = [];

        final DateFormat inputFormat = DateFormat(
            "yyyy-MM-ddTHH:mm:ss"); // Adjust format based on your API response
        final DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm");

        data.forEach((key, value) {
          if (value is List) {
            for (var entry in value) {
              if (entry is Map && entry.containsKey('start')) {
                String startTime = entry['start'];
                DateTime parsedDateTime = inputFormat.parse(startTime);
                String formattedDateTime = outputFormat.format(parsedDateTime);
                extractedStartTimes.add(formattedDateTime);
              }
            }
          }
        });

        setState(() {
          startTimes = extractedStartTimes;
          isLoading = false;
          print('startTimes $startTimes');
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load schedules. Status Code: ${response.statusCode}';
          isLoading = false;
        });
        print('Failed to load schedules. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void calculateDates() {
    DateTime currentDate = DateTime.now();
    DateTime nextMonthDate = DateTime(
      currentDate.year,
      currentDate.month + 1,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
    );

    String formattedCurrentDate =
        DateFormat('yyyy-MM-dd HH:mm').format(currentDate);
    String formattedNextMonthDate =
        DateFormat('yyyy-MM-dd HH:mm').format(nextMonthDate);

    String startGt = formattedCurrentDate;
    String startLt = formattedNextMonthDate;

    print('Current Date and Time: $formattedCurrentDate');
    print('Next Month Date and Time: $formattedNextMonthDate');

    //String? userId = SessionManager.getUserId();
    //String? userType = SessionManager.getUserType();
    String? userToken = SessionManager.getUserToken();

    if (widget.doctorId != null) {
      fetchSchedules(widget.doctorId, startGt, startLt, userToken!);
    } else {
      setState(() {
        errorMessage = 'User ID is null.';
        isLoading = false;
      });
    }
  }

  DateTime _getStartOfWeek(DateTime date) {
    int weekday = date.weekday;
    return date.subtract(Duration(days: weekday - DateTime.monday));
  }

  String getPeriodLabel() {
    DateTime endDate = _currentDates.add(Duration(days: 6));
    return '${DateFormat('MMM dd, yyyy').format(_currentDates)} - ${DateFormat('MMM dd, yyyy').format(endDate)}';
  }

  void _nextPeriod() {
    setState(() {
      _currentDates = _currentDates.add(Duration(days: 7));
    });
  }

  void _previousPeriod() {
    setState(() {
      _currentDates = _currentDates.subtract(Duration(days: 7));
    });
  }

  bool _isPastTime(DateTime day, String hour) {
    DateTime now = DateTime.now();
    DateTime buttonDateTime = DateFormat('yyyy-MM-dd HH:mm')
        .parse('${DateFormat('yyyy-MM-dd').format(day)} $hour');
    return buttonDateTime.isBefore(now);
  }

  List<DateTime> getWeekDays(DateTime startDate) {
    return List.generate(7, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  List<DateTime> getMonthDays(DateTime startDate) {
    DateTime firstDayOfMonth = DateTime(startDate.year, startDate.month, 1);
    DateTime lastDayOfMonth = DateTime(startDate.year, startDate.month + 1, 0);
    return List.generate(lastDayOfMonth.day, (index) {
      return firstDayOfMonth.add(Duration(days: index));
    });
  }

  List<String> getHours() {
    return List.generate(24, (index) {
      return DateFormat('HH:00').format(DateTime(2021, 1, 1, index));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> days =
        _isWeekView ? getWeekDays(_currentDates) : getMonthDays(_currentDates);
    List<String> hours = getHours();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          '${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "${AppLocalizations.of(context)!.appiontTypeAppiontmentDetailDocSecSC}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                            color: Color(0xff0EBE7F),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '28.00',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "${AppLocalizations.of(context)!.appointReasonAppiontmentDetailDocSecSC}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _appointmentReasonControll,
                decoration: InputDecoration(
                  hintText:
                      "${AppLocalizations.of(context)!.writeReasonlAllDoctorsPageSC}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            //   child: Text(
            //     "From here design new calendar for time",
            //     style: TextStyle(color: Colors.black, fontSize: 16),
            //   ),
            // ),
            SizedBox(
              height: 20.v,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: _previousPeriod,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getPeriodLabel(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: _nextPeriod,
                      ),
                    ],
                  ),
                  if (_isWeekView) ...[
                    SizedBox(
                      height: 450, // Fixed height for the week view
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: days.map((day) {
                          bool isToday = DateFormat('yyyy-MM-dd').format(day) ==
                              DateFormat('yyyy-MM-dd').format(DateTime.now());

                          return Container(
                            width: MediaQuery.of(context).size.width /
                                4, // 1/4th of the screen width
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${DateFormat('EEE').format(day)}. ', // Abbreviated day name
                                          style: TextStyle(
                                            color: isToday
                                                ? Colors.blue
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: DateFormat('dd')
                                              .format(day), // Date
                                          style: TextStyle(
                                            color: isToday
                                                ? Colors.blue
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 400, // Height for the hours list
                                  child: ListView.builder(
                                    itemCount: hours.length,
                                    itemBuilder: (context, index) {
                                      String formattedActualDateTime =
                                          DateFormat('yyyy-MM-dd HH:mm').format(
                                        DateTime(
                                          day.year,
                                          day.month,
                                          day.day,
                                          int.parse(hours[index].split(':')[0]),
                                          0,
                                        ),
                                      );

                                      bool isPastTime =
                                          _isPastTime(day, hours[index]);

                                      bool isAvailable = startTimes
                                          .contains(formattedActualDateTime);
                                      bool isDisabled =
                                          isPastTime || !isAvailable;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 4),
                                        child: ElevatedButton(
                                          onPressed: isDisabled
                                              ? null
                                              : () {
                                                  // Set the selected time when an enabled button is clicked
                                                  setState(() {
                                                    _selectedTime =
                                                        formattedActualDateTime;
                                                  });
                                                  print(
                                                      "Selected Time: $_selectedTime");
                                                  // Optionally, handle further actions like navigation or showing a dialog here
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: isDisabled
                                                ? Colors.grey
                                                : Colors.blue,
                                          ),
                                          child: Text(
                                            '${hours[index]}', // Only show actual time
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ] else ...[
                    // Implement the month view if needed
                  ],
                ],
              ),
            ),
            _buildConfirm(context),
          ],
        ),
      ),
    );
  }

  // // Section Widget
  Widget _buildConfirm(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: CustomElevatedButton(
        text: "${AppLocalizations.of(context)!.nextAllDoctorsPageSC}",
        onPressed: () {
          // Check if _selectedTime is null and handle accordingly
          if (_selectedTime != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentMethode(
                  appointmentReason: _appointmentReasonControll
                      .text, // Correctly passing the text
                  dateAndTime: _selectedTime!,
                  doctorId: widget.doctorId,
                ),
              ),
            );
            print('AppointmentReasonControll: $_appointmentReasonControll');
            print('SelectedTime: $_selectedTime');
            print('Widget.doctorId: ${widget.doctorId}');
          } else {
            // Handle the case where _selectedTime is null
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please select a time."),
              ),
            );
          }
        },
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
      ),
    );
  }
}


//Last code when start to fetch appiont data api start here 
// import 'package:doctari/core/app_export.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/BookAppointmentSecondPage.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/widget/date_picker.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/select_date_appointment_type/widget/hours_tab.dart';
// import 'package:doctari/patientFlow/appointment_booking_flow/patient_payment_screen/payment_screen.dart';
// import 'package:doctari/web%20view/payment_methode.dart';
// import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
// import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
// import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class BookingAppointmentDetails extends StatefulWidget {
//   final int doctorId;
//   BookingAppointmentDetails({required this.doctorId, Key? key})
//       : super(key: key);

//   @override
//   State<BookingAppointmentDetails> createState() =>
//       _BookingAppointmentDetailsState();
// }

// class _BookingAppointmentDetailsState extends State<BookingAppointmentDetails> {
//   final TextEditingController _appointmentReasonControll =
//       TextEditingController();

//   List<DateTime> getNextSevenDays() {
//     List<DateTime> nextSevenDays = [];
//     DateTime today = DateTime.now();
//     for (int i = 0; i < 7; i++) {
//       nextSevenDays.add(today.add(Duration(days: i)));
//     }
//     debugPrint("today: $today");
//     debugPrint("nextSevenDays: $nextSevenDays");

//     return nextSevenDays;
//   }

//   dynamic _selectedDate;
//   dynamic _selectedTime;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //appBar: _buildAppBar(context),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         centerTitle: true,
//         backgroundColor: theme.colorScheme.primary,
//         title: Text(
//             '${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}'),
//         titleTextStyle: TextStyle(
//             color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.only(
//             left: 15.h,
//             right: 15.h,
//             top: 10.v,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   // getNextSevenDays();
//                 },
//                 child: Text(
//                   "${AppLocalizations.of(context)!.appiontTypeAppiontmentDetailDocSecSC}",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w300),
//                   ),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                             text: '\$ ',
//                             style: TextStyle(
//                                 color: Color(0xff0EBE7F),
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold)),
//                         TextSpan(
//                             text: '28.00',
//                             style: TextStyle(
//                                 color: Colors.grey.shade700, fontSize: 15))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 "${AppLocalizations.of(context)!.appointReasonAppiontmentDetailDocSecSC}",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               CustomTextFormField(
//                 controller: _appointmentReasonControll,
//                 hintText:
//                     "${AppLocalizations.of(context)!.writeReasonlAllDoctorsPageSC}",
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 16.h,
//                   vertical: 12.v,
//                 ),
//                 borderDecoration: TextFormFieldStyleHelper.outlineGrayTL12,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "${AppLocalizations.of(context)!.selectDatelAllDoctorsPageSC}",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 // height: 300, // Provide a fixed height
//                 child: CalendarWidget(
//                   onDateSelected: (DateTime selectedDate) {
//                     // Handle the selected date here
//                     print("Selected Date: $selectedDate");
//                     setState(() {
//                       _selectedDate = selectedDate;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "${AppLocalizations.of(context)!.selectHourlAllDoctorsPageSC}",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               HourstabsForAppointmentWidget(
//                 onTimeSelected: (selectedTime) {
//                   // Handle the selected time here
//                   setState(() {
//                     _selectedTime = selectedTime;
//                   });
//                   print("Selected Time: $selectedTime");
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildConfirm(context),
//     );
//   }

//   /// Section Widget
//   Widget _buildConfirm(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       child: CustomElevatedButton(
//         // height: 54.v,
//         text: "${AppLocalizations.of(context)!.nextAllDoctorsPageSC}",
//         onPressed: () {
//           // Parse time string into DateTime object
//           DateTime parsedTime = DateFormat("hh:mm a").parse(_selectedTime);

//           // Extract components from the selected date
//           int year = _selectedDate.year;
//           int month = _selectedDate.month;
//           int day = _selectedDate.day;

//           // Combine date and time into one DateTime object
//           DateTime combinedDateTime = DateTime(
//             year,
//             month,
//             day,
//             parsedTime.hour,
//             parsedTime.minute,
//           );

//           // Format the combined DateTime object with timezone offset
//           String formattedDateTimeWithOffset =
//               DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(combinedDateTime) +
//                   DateFormat("Z").format(combinedDateTime);

//           print("Selected Time: ${DateFormat("HH:mm").format(parsedTime)}");
//           print(
//               "Selected Date: ${DateFormat("yyyy-MM-dd").format(_selectedDate)}");
//           print("Formatted DateTime with Offset: $formattedDateTimeWithOffset");
//           // print("$_selectedDate");
//           print("${_appointmentReasonControll.text}");

//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PaymentMethode(
//                   appointmentReason: _appointmentReasonControll.text,
//                   dateAndTime: formattedDateTimeWithOffset,
//                   doctorId: widget.doctorId,
//                 ),
//               ));
//         },
//         margin: EdgeInsets.only(
//           // left: 24.h,
//           // right: 24.h,
//           bottom: 10.v,
//         ),
//         buttonStyle: CustomButtonStyles.fillPrimary,
//         buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 48.h,
//       leading: AppbarLeadingImage(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         imagePath: ImageConstant.imgArrowDownBlueGray800,
//         margin: EdgeInsets.only(
//           left: 24.h,
//           top: 16.v,
//           bottom: 15.v,
//         ),
//       ),
//       centerTitle: true,
//       backgroundCOlor: Colors.blue,
//       title: AppbarSubtitleSeven(
//         text:
//             "${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}",
//       ),
//     );
//   }
// }
