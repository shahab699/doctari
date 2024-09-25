import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:intl/intl.dart';
import 'widgets/upcomingappointments_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingAppointmentsForDocPage extends StatefulWidget {
  final int doctId;
  final String token;

  const UpcomingAppointmentsForDocPage({
    required this.doctId,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  _UpcomingAppointmentsForDocPageState createState() =>
      _UpcomingAppointmentsForDocPageState();
}

class _UpcomingAppointmentsForDocPageState
    extends State<UpcomingAppointmentsForDocPage> {
  List<Map<String, dynamic>> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    try {
      final List<Map<String, dynamic>> fetchedAppointments =
          await DoctorApiService.fetchDoctorAppointments(
        widget.doctId,
        widget.token,
      );
      setState(() {
        appointments = fetchedAppointments;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : appointments.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!
                        .noAppointAvailableUpcomingappiontmentDocSC,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15.0),
                        Expanded(child: _buildUpcomingAppointments(context)),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildUpcomingAppointments(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Divider(
          height: 1.0,
          thickness: 1.0,
          color: appTheme.gray200,
        ),
      ),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        DateTime combinedDateTime = DateTime.parse(appointment['date']);
        String formattedDate =
            DateFormat('yyyy-MM-dd').format(combinedDateTime);
        String formattedTime = DateFormat('hh:mm a').format(combinedDateTime);

        return UpcomingappointmentsItemWidget(
          appointmentData: appointment,
          date: formattedDate,
          time: formattedTime,
        );
      },
    );
  }
}



// import 'package:doctari/doctorAPI/doctor_api_service.dart';
// import 'package:intl/intl.dart';

// import 'widgets/upcomingappointments_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class UpcomingAppointmentsForDocPage extends StatefulWidget {
//   final int doctId;
//   final String token;

//   const UpcomingAppointmentsForDocPage(
//       {required this.doctId, required this.token, Key? key})
//       : super(key: key);

//   @override
//   _UpcomingAppointmentsForDocPageState createState() =>
//       _UpcomingAppointmentsForDocPageState();
// }

// class _UpcomingAppointmentsForDocPageState
//     extends State<UpcomingAppointmentsForDocPage> {
//   late List<Map<String, dynamic>> appointments = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAppointments();
//     print('ghdfnhfdjhe');
//   }

//   bool? isLoading;
//   void fetchAppointments() async {
//     setState(() {
//       isLoading = true; // Set isLoading to true while fetching data
//     });
//     try {
//       final List<Map<String, dynamic>> fetchedAppointments =
//           await DoctorApiService.fetchDoctorAppointments(
//               widget.doctId, widget.token); // Replace 4 with actual doctor ID
//       setState(() {
//         appointments = fetchedAppointments;
//         isLoading = false;
//       });
//       print("widget.doctId: ${widget.doctId}");
//       print("widget.token: ${widget.token}");
//     } catch (e) {
//       print('Error fetching appointments: $e');
//       setState(() {
//         isLoading = false; // Set isLoading to true while fetching data
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading == true
//         ? Center(
//             child: CircularProgressIndicator(), // Show loading indicator
//           )
//         : appointments.isEmpty
//             ? Center(
//                 child: Text(
//                   '${AppLocalizations.of(context)!.noAppointAvailableUpcomingappiontmentDocSC}',
//                   style: TextStyle(color: Colors.black, fontSize: 16),
//                 ), // Show message if no appointments
//               )
//             : SafeArea(
//                 child: Scaffold(
//                   backgroundColor: Colors.grey.shade100,
//                   body: Container(
//                     width: double.maxFinite,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 15.v),
//                         _buildUpcomingAppointments(context),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//   }

//   /// Section Widget
//   Widget _buildUpcomingAppointments(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 28.h),
//         child: ListView.separated(
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           separatorBuilder: (
//             context,
//             index,
//           ) {
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0.v),
//               child: SizedBox(
//                 width: 310.h,
//                 child: Divider(
//                   height: 1.v,
//                   thickness: 1.v,
//                   color: appTheme.gray200,
//                 ),
//               ),
//             );
//           },
//           itemCount: appointments.length,
//           itemBuilder: (context, index) {
//             final appointment = appointments[index];
//             String combinedDateTimeString = appointment['date'];

//             // Parse the combined date and time string into a DateTime object
//             DateTime combinedDateTime = DateTime.parse(combinedDateTimeString);

//             // Format date
//             String formattedDate =
//                 DateFormat('yyyy-MM-dd').format(combinedDateTime);

//             // Format time
//             String formattedTime =
//                 DateFormat('hh:mm a').format(combinedDateTime);

//             print("Date: $formattedDate");
//             print("Time: $formattedTime");
//             return UpcomingappointmentsItemWidget(
//               // Pass appointment data to the widget
//               appointmentData: appointment,
//               date: formattedDate,
//               time: formattedTime,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


//our first code that use in this screen
// import 'package:doctari/doctorAPI/doctor_api_service.dart';
// import 'package:intl/intl.dart';

// import 'widgets/upcomingappointments_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class UpcomingAppointmentsForDocPage extends StatefulWidget {
//   final int doctId;
//   final String token;

//   const UpcomingAppointmentsForDocPage(
//       {required this.doctId, required this.token, Key? key})
//       : super(key: key);

//   @override
//   _UpcomingAppointmentsForDocPageState createState() =>
//       _UpcomingAppointmentsForDocPageState();
// }

// class _UpcomingAppointmentsForDocPageState
//     extends State<UpcomingAppointmentsForDocPage> {
//   late List<Map<String, dynamic>> appointments = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAppointments();
//     print('ghdfnhfdjhe');
//   }

//   bool? isLoading;
//   void fetchAppointments() async {
//     setState(() {
//       isLoading = true; // Set isLoading to true while fetching data
//     });
//     try {
//       final List<Map<String, dynamic>> fetchedAppointments =
//           await DoctorApiService.fetchDoctorAppointments(
//               widget.doctId, widget.token); // Replace 4 with actual doctor ID
//       setState(() {
//         appointments = fetchedAppointments;
//         isLoading = false;
//       });
//       print("widget.doctId: ${widget.doctId}");
//       print("widget.token: ${widget.token}");
//     } catch (e) {
//       print('Error fetching appointments: $e');
//       setState(() {
//         isLoading = false; // Set isLoading to true while fetching data
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading == true
//         ? Center(
//             child: CircularProgressIndicator(), // Show loading indicator
//           )
//         : appointments.isEmpty
//             ? Center(
//                 child: Text(
//                   '${AppLocalizations.of(context)!.noAppointAvailableUpcomingappiontmentDocSC}',
//                   style: TextStyle(color: Colors.black, fontSize: 16),
//                 ), // Show message if no appointments
//               )
//             : SafeArea(
//                 child: Scaffold(
//                   backgroundColor: Colors.grey.shade100,
//                   body: Container(
//                     width: double.maxFinite,
//                     child: Column(
//                       children: [
//                         SizedBox(height: 15.v),
//                         _buildUpcomingAppointments(context),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//   }

//   /// Section Widget
//   Widget _buildUpcomingAppointments(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 28.h),
//         child: ListView.separated(
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           separatorBuilder: (
//             context,
//             index,
//           ) {
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0.v),
//               child: SizedBox(
//                 width: 310.h,
//                 child: Divider(
//                   height: 1.v,
//                   thickness: 1.v,
//                   color: appTheme.gray200,
//                 ),
//               ),
//             );
//           },
//           itemCount: appointments.length,
//           itemBuilder: (context, index) {
//             final appointment = appointments[index];
//             String combinedDateTimeString = appointment['date'];

// // Parse the combined date and time string into a DateTime object
//             DateTime combinedDateTime = DateTime.parse(combinedDateTimeString);

// // Format date
//             String formattedDate =
//                 DateFormat('yyyy-MM-dd').format(combinedDateTime);

// // Format time
//             String formattedTime =
//                 DateFormat('hh:mm a').format(combinedDateTime);

//             print("Date: $formattedDate");
//             print("Time: $formattedTime");
//             return UpcomingappointmentsItemWidget(
//               // Pass appointment data to the widget
//               appointmentData: appointment,
//               date: formattedDate,
//               time: formattedTime,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ignore_for_file: must_be_immutable
// class UpcomingAppointmentsForDocPage extends StatelessWidget {
//   const UpcomingAppointmentsForDocPage({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         body: Container(
//           width: double.maxFinite,
//           child: Column(
//             children: [
//               SizedBox(height: 15.v),
//               _buildUpcomingAppointments(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildUpcomingAppointments(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 28.h),
//         child: ListView.separated(
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           separatorBuilder: (
//             context,
//             index,
//           ) {
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0.v),
//               child: SizedBox(
//                 width: 310.h,
//                 child: Divider(
//                   height: 1.v,
//                   thickness: 1.v,
//                   color: appTheme.gray200,
//                 ),
//               ),
//             );
//           },
//           itemCount: 3,
//           itemBuilder: (context, index) {
//             return UpcomingappointmentsItemWidget();
//           },
//         ),
//       ),
//     );
//   }
// }
