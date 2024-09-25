// import 'package:doctari/core/app_export.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui' as ui;
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class AppointmentScreen extends StatelessWidget {
//   final int doctorId;
//   final String token;

//   AppointmentScreen({required this.doctorId, required this.token});
//   String? userSelectedImage; // Path to the user's selected image
//   double userImageHeight =
//       109.adaptSize; // Default height if no specific height is provided
//   double userImageWidth =
//       109.adaptSize; // Default width if no specific width is provided

//   static Future<List<Map<String, dynamic>>> fetchDoctorAppointments(
//       int doctorId, String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$doctorId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         final List<dynamic> results = jsonData['results'];
//         return List<Map<String, dynamic>>.from(results);
//       } else {
//         throw Exception(
//             'Failed to load doctor appointments: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load doctor appointments: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Appointments'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchDoctorAppointments(doctorId, token),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No appointments available'));
//           }

//           final appointments = snapshot.data!;

//           return ListView.builder(
//             itemCount: appointments.length,
//             itemBuilder: (context, index) {
//               final appointment = appointments[index];
//               final doctor = appointment['doctor'] ?? {};
//               final startDateStr = appointment['date'] ?? '';
//               final startDate =
//                   startDateStr.isNotEmpty ? DateTime.parse(startDateStr) : null;
//               final formattedDate = startDate != null
//                   ? DateFormat('MMM dd, yyyy').format(startDate)
//                   : 'Unknown Date';
//               final formattedTime = startDate != null
//                   ? DateFormat('hh:mm a').format(startDate)
//                   : 'Unknown Time';
//               final doctorName = doctor['full_name'] ?? 'Unknown Doctor';
//               final doctorProfilePictureUrl = doctor['profile_picture'] != null
//                   ? doctor['profile_picture']['url']
//                   : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
//               final doctorDOB = doctor['date_of_birth'] ?? 'Unknown';
//               final doctorGender = doctor['gender'] ?? 'Unknown';

//               return Container(
//                 // height: 280,
//                 width: double.infinity,
//                 child: Card(
//                   margin: EdgeInsets.all(10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 4.h),
//                           child: Text(
//                             "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
//                             style: theme.textTheme.titleMedium,
//                           ),
//                         ),
//                         // Text('In-Person Visit'),

//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 109.adaptSize,
//                                 width: 109.adaptSize,
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     CustomImageView(
//                                       imagePath: ImageConstant.imgImage,
//                                       height: 109.adaptSize,
//                                       width: 109.adaptSize,
//                                       radius: BorderRadius.circular(
//                                         12.h,
//                                       ),
//                                       alignment: Alignment.center,
//                                     ),
//                                     CustomImageView(
//                                       imagePath: doctorProfilePictureUrl,
//                                       height: 109.adaptSize,
//                                       width: 109.adaptSize,
//                                       fit: BoxFit.contain,
//                                       radius: BorderRadius.circular(
//                                         12.h,
//                                       ),
//                                       alignment: Alignment.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // Align(
//                               //   alignment: Alignment.topCenter,
//                               //   child: Container(
//                               //     // height: 50,
//                               //     // width: 50,
//                               //     child: Image.network(
//                               //       doctorProfilePictureUrl,
//                               //       height: 130,
//                               //       width: 100,
//                               //     ),
//                               //   ),
//                               // ),
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '$formattedDate',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '$formattedTime',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '$doctorName',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '$doctorDOB',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '$doctorGender',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         // Text(
//                         //   'Date: $formattedDate',
//                         //   style: TextStyle(
//                         //       fontSize: 16, fontWeight: FontWeight.bold),
//                         // ),
//                         // Text(
//                         //   'Time: $formattedTime',
//                         //   style: TextStyle(fontSize: 16),
//                         // ),
//                         // Text(
//                         //   'Doctor: $doctorName',
//                         //   style: TextStyle(fontSize: 16),
//                         // ),
//                         // Text(
//                         //   'DOB: $doctorDOB',
//                         //   style: TextStyle(fontSize: 16),
//                         // ),
//                         // Text(
//                         //   'Gender: $doctorGender',
//                         //   style: TextStyle(fontSize: 16),
//                         // ),
//                         // SizedBox(height: 10),
//                         // Image.network(
//                         //   doctorProfilePictureUrl,
//                         //   height: 100,
//                         //   width: 100,
//                         // ),
//                         SizedBox(height: 24.v),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               _buildCancel(context),
//                               _buildReschedule(context),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15.v),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         text: "Cancel",
//         margin: EdgeInsets.only(right: 8.h),
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   Widget _buildReschedule(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: () {},
//         text:
//             "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
//         margin: EdgeInsets.only(left: 8.h),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }
// }
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui' as ui;
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class AppointmentScreen extends StatelessWidget {
//   final int doctorId;
//   final String token;

//   AppointmentScreen({required this.doctorId, required this.token});
//   String? userSelectedImage; // Path to the user's selected image
//   double userImageHeight =
//       109.adaptSize; // Default height if no specific height is provided
//   double userImageWidth =
//       109.adaptSize; // Default width if no specific width is provided
//   static Future<List<Map<String, dynamic>>> fetchDoctorAppointments(
//       int doctorId, String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$doctorId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         final List<dynamic> results = jsonData['results'];
//         return List<Map<String, dynamic>>.from(results);
//       } else {
//         throw Exception(
//             'Failed to load doctor appointments: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load doctor appointments: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Appointments'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchDoctorAppointments(doctorId, token),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No appointments available'));
//           }

//           final appointments = snapshot.data!;
//           return ListView(
//             scrollDirection: Axis.horizontal,
//             children: appointments.map((appointment) {
//               final doctor = appointment['doctor'] ?? {};
//               final startDateStr = appointment['date'] ?? '';
//               final startDate =
//                   startDateStr.isNotEmpty ? DateTime.parse(startDateStr) : null;
//               final formattedDate = startDate != null
//                   ? DateFormat('MMM dd, yyyy').format(startDate)
//                   : 'Unknown Date';
//               final formattedTime = startDate != null
//                   ? DateFormat('hh:mm a').format(startDate)
//                   : 'Unknown Time';
//               final doctorName = doctor['full_name'] ?? 'Unknown Doctor';
//               final doctorProfilePictureUrl = doctor['profile_picture'] != null
//                   ? doctor['profile_picture']['url']
//                   : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
//               final doctorDOB = doctor['date_of_birth'] ?? 'Unknown';
//               final doctorGender = doctor['gender'] ?? 'Unknown';

//               return Container(
//                 width: MediaQuery.of(context).size.width *
//                     0.7, // Adjust width as needed
//                 height: 250, // Fixed height for each card
//                 margin: EdgeInsets.symmetric(horizontal: 10), // Adjust margin
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
//                           // style: Theme.of(context).textTheme.headline6,
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 109.adaptSize,
//                               width: 109.adaptSize,
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   // Network image in the background
//                                   CustomImageView(
//                                     imagePath: doctorProfilePictureUrl,
//                                     height: 109.adaptSize,
//                                     width: 109.adaptSize,
//                                     radius: BorderRadius.circular(12.h),
//                                     alignment: Alignment.center,
//                                     fit: BoxFit
//                                         .cover, // Ensure the network image covers the full box
//                                   ),
//                                   // User selected image on top (if exists)
//                                   if (userSelectedImage != null)
//                                     CustomImageView(
//                                       imagePath: userSelectedImage!,
//                                       height:
//                                           userImageHeight, // Use the user's image height
//                                       width:
//                                           userImageWidth, // Use the user's image width
//                                       radius: BorderRadius.circular(12.h),
//                                       alignment: Alignment.center,
//                                       fit: BoxFit
//                                           .contain, // Ensure the user image maintains its aspect ratio
//                                     ),
//                                 ],
//                               ),
//                             ),

//                             SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '$formattedDate',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$formattedTime',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$doctorName',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$doctorDOB',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$doctorGender',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 // Align(
//                                 //   alignment: Alignment.centerLeft,
//                                 //   child: Row(
//                                 //     mainAxisAlignment:
//                                 //         MainAxisAlignment.spaceBetween,
//                                 //     crossAxisAlignment:
//                                 //         CrossAxisAlignment.start,
//                                 //     children: [
//                                 //       _buildCancel(context),
//                                 //       SizedBox(width: 10),
//                                 //       _buildReschedule(context),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildCancel(context),
//                               // SizedBox(width: 10),
//                               _buildReschedule(context),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           );

//           // return ListView(
//           //   scrollDirection: Axis.horizontal,
//           //   children: appointments.map((appointment) {
//           //     final doctor = appointment['doctor'] ?? {};
//           //     final startDateStr = appointment['date'] ?? '';
//           //     final startDate =
//           //         startDateStr.isNotEmpty ? DateTime.parse(startDateStr) : null;
//           //     final formattedDate = startDate != null
//           //         ? DateFormat('MMM dd, yyyy').format(startDate)
//           //         : 'Unknown Date';
//           //     final formattedTime = startDate != null
//           //         ? DateFormat('hh:mm a').format(startDate)
//           //         : 'Unknown Time';
//           //     final doctorName = doctor['full_name'] ?? 'Unknown Doctor';
//           //     final doctorProfilePictureUrl = doctor['profile_picture'] != null
//           //         ? doctor['profile_picture']['url']
//           //         : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
//           //     final doctorDOB = doctor['date_of_birth'] ?? 'Unknown';
//           //     final doctorGender = doctor['gender'] ?? 'Unknown';

//           //     return Container(
//           //       width: MediaQuery.of(context).size.width *
//           //           0.8, // Adjust width as needed
//           //       child: Card(
//           //         margin: EdgeInsets.all(10),
//           //         child: Padding(
//           //           padding: const EdgeInsets.all(10.0),
//           //           child: Column(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: [
//           //               Text(
//           //                 "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
//           //                 // style: Theme.of(context).textTheme.headline6,
//           //               ),
//           //               SizedBox(height: 10),
//           //               Row(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: [
//           //                   SizedBox(
//           //                     height: 100,
//           //                     width: 100,
//           //                     child: Stack(
//           //                       alignment: Alignment.center,
//           //                       children: [
//           //                         CustomImageView(
//           //                           imagePath: ImageConstant.imgImage,
//           //                           height: 100,
//           //                           width: 100,
//           //                           radius: BorderRadius.circular(12),
//           //                           alignment: Alignment.center,
//           //                         ),
//           //                         CustomImageView(
//           //                           imagePath: doctorProfilePictureUrl,
//           //                           height: 100,
//           //                           width: 100,
//           //                           fit: BoxFit.contain,
//           //                           radius: BorderRadius.circular(12),
//           //                           alignment: Alignment.center,
//           //                         ),
//           //                       ],
//           //                     ),
//           //                   ),
//           //                   SizedBox(width: 10),
//           //                   Expanded(
//           //                     child: Column(
//           //                       crossAxisAlignment: CrossAxisAlignment.start,
//           //                       children: [
//           //                         Text(
//           //                           '$formattedDate',
//           //                           style: TextStyle(
//           //                             fontSize: 16,
//           //                             color: Colors.black,
//           //                             fontWeight: FontWeight.bold,
//           //                           ),
//           //                         ),
//           //                         Text(
//           //                           '$formattedTime',
//           //                           style: TextStyle(
//           //                             fontSize: 16,
//           //                             color: Colors.black,
//           //                             fontWeight: FontWeight.bold,
//           //                           ),
//           //                         ),
//           //                         Text(
//           //                           '$doctorName',
//           //                           style: TextStyle(
//           //                             fontSize: 16,
//           //                             color: Colors.black,
//           //                           ),
//           //                         ),
//           //                         Text(
//           //                           '$doctorDOB',
//           //                           style: TextStyle(
//           //                             fontSize: 16,
//           //                             color: Colors.black,
//           //                           ),
//           //                         ),
//           //                         Text(
//           //                           '$doctorGender',
//           //                           style: TextStyle(
//           //                             fontSize: 16,
//           //                             color: Colors.black,
//           //                           ),
//           //                         ),
//           //                         SizedBox(height: 10),
//           //                         Row(
//           //                           mainAxisAlignment: MainAxisAlignment.center,
//           //                           children: [
//           //                             _buildCancel(context),
//           //                             SizedBox(width: 10),
//           //                             _buildReschedule(context),
//           //                           ],
//           //                         ),
//           //                       ],
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //     );
//           //   }).toList(),
//           // );
//         },
//       ),
//     );
//   }

//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         text: "Cancel",
//         margin: EdgeInsets.only(right: 8),
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   Widget _buildReschedule(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         onPressed: () {},
//         text:
//             "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
//         margin: EdgeInsets.only(left: 8),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }
// }

import 'package:doctari/core/app_export.dart';
import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentScreen extends StatefulWidget {
  final int doctorId;
  final String token;

  AppointmentScreen({required this.doctorId, required this.token});

  static Future<List<Map<String, dynamic>>> fetchDoctorAppointments(
      int doctorId, String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$doctorId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> results = jsonData['results'];
        return List<Map<String, dynamic>>.from(results);
      } else {
        throw Exception(
            'Failed to load doctor appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load doctor appointments: $e');
    }
  }

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? userSelectedImage;
  // Path to the user's selected image
  double userImageHeight = 109.adaptSize;
  // Default height if no specific height is provided
  double userImageWidth = 109.adaptSize;
  // Default width if no specific width is provided
  int? patientCount = 0;

  Future<void> getCount(String token) async {
    try {
      int count = await DoctorApiService().fetchPatientCount(token);
      setState(() {
        patientCount = count ?? 0;
      });

      print('Total number of patients: $count');
    } catch (error) {
      print('Error fetching patient count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointments'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: AppointmentScreen.fetchDoctorAppointments(
                widget.doctorId, widget.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No appointments available'));
              }

              final appointments = snapshot.data!;
              return Container(
                height: MediaQuery.of(context).size.height * 0.32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap:
                      true, // Ensures the ListView takes up only as much space as needed

                  children: appointments.map((appointment) {
                    final doctor = appointment['doctor'] ?? {};
                    final startDateStr = appointment['date'] ?? '';
                    final startDate = startDateStr.isNotEmpty
                        ? DateTime.parse(startDateStr)
                        : null;
                    final formattedDate = startDate != null
                        ? DateFormat('MMM dd, yyyy').format(startDate)
                        : 'Unknown Date';
                    final formattedTime = startDate != null
                        ? DateFormat('hh:mm a').format(startDate)
                        : 'Unknown Time';
                    final doctorName = doctor['full_name'] ?? 'Unknown Doctor';
                    final doctorProfilePictureUrl = doctor['profile_picture'] !=
                            null
                        ? doctor['profile_picture']['url']
                        : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
                    final doctorDOB = doctor['date_of_birth'] ?? 'Unknown';
                    final doctorGender = doctor['gender'] ?? 'Unknown';

                    return Container(
                      width: MediaQuery.of(context).size.width *
                          0.7, // Adjust width as needed

                      margin:
                          EdgeInsets.symmetric(horizontal: 10), // Adjust margin
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                                // style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 109.adaptSize,
                                    width: 109.adaptSize,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Network image in the background
                                        CustomImageView(
                                          imagePath: doctorProfilePictureUrl,
                                          height: 109.adaptSize,
                                          width: 109.adaptSize,
                                          radius: BorderRadius.circular(12.h),
                                          alignment: Alignment.center,
                                          fit: BoxFit
                                              .cover, // Ensure the network image covers the full box
                                        ),
                                        // User selected image on top (if exists)
                                        if (userSelectedImage != null)
                                          CustomImageView(
                                            imagePath: userSelectedImage!,
                                            height:
                                                userImageHeight, // Use the user's image height
                                            width:
                                                userImageWidth, // Use the user's image width
                                            radius: BorderRadius.circular(12.h),
                                            alignment: Alignment.center,
                                            fit: BoxFit
                                                .contain, // Ensure the user image maintains its aspect ratio
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$formattedDate',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '$formattedTime',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '$doctorName',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '$doctorDOB',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '$doctorGender',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildCancel(context),
                                    _buildReschedule(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          //ADD HERE REVIEW SECTION

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // OVERVIEW SECTION
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AppointmentScreen(
                      //               doctorId: int.parse(userId!),
                      //               token: userToken,
                      //             )));
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.overviewDoctorDashboardSC}",
                      style: TextStyle(
                          inherit: false,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                overViewContainer(
                    context, "Patients", "${patientCount}", Icons.group),
                // overViewContainer(
                //     context, "Consultation", " ", Icons.join_full),
                // overViewContainer(
                //     context, "Revenue", "1023.42\$", Icons.attach_money),

                // REVIEW SECTION
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         "Reviews",
                //         style: TextStyle(
                //             inherit: false,
                //             fontSize: 20,
                //             color: Colors.black,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         "See All",
                //         style: TextStyle(
                //             inherit: false,
                //             fontSize: 15,
                //             color: Colors.grey,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //   ],
                // ),
                // Container(
                //   height: 60,
                //   width: mediaQuery.size.width,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8,
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Colors.grey.shade200,
                //         radius: 25,
                //         backgroundImage: NetworkImage(
                //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Emily Anderson",
                //               style: TextStyle(
                //                   inherit: false,
                //                   fontSize: 14,
                //                   color: Colors.black),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(vertical: 5),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "5",
                //                     style: TextStyle(
                //                         inherit: false,
                //                         fontSize: 14,
                //                         color: Colors.grey),
                //                   ),
                //                   RatingBar.builder(
                //                     initialRating:
                //                         5, // Initial rating value
                //                     minRating: 1, // Minimum rating
                //                     direction: Axis.horizontal,
                //                     allowHalfRating: true,
                //                     itemCount:
                //                         5, // Number of rating items (stars)
                //                     itemSize:
                //                         15, // Size of each rating item
                //                     itemBuilder: (context, _) => Icon(
                //                       Icons.star,
                //                       color: Colors.amber,
                //                     ),
                //                     onRatingUpdate: (rating) {
                //                       // Handle the updated rating
                //                       print(rating);
                //                     },
                //                   )
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 60,
                //   width: mediaQuery.size.width,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8,
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Colors.grey.shade200,
                //         radius: 25,
                //         backgroundImage: NetworkImage(
                //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Emily Anderson",
                //               style: TextStyle(
                //                   inherit: false,
                //                   fontSize: 14,
                //                   color: Colors.black),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(vertical: 5),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "5",
                //                     style: TextStyle(
                //                         inherit: false,
                //                         fontSize: 14,
                //                         color: Colors.grey),
                //                   ),
                //                   RatingBar.builder(
                //                     initialRating:
                //                         5, // Initial rating value
                //                     minRating: 1, // Minimum rating
                //                     direction: Axis.horizontal,
                //                     allowHalfRating: true,
                //                     itemCount:
                //                         5, // Number of rating items (stars)
                //                     itemSize:
                //                         15, // Size of each rating item
                //                     itemBuilder: (context, _) => Icon(
                //                       Icons.star,
                //                       color: Colors.amber,
                //                     ),
                //                     onRatingUpdate: (rating) {
                //                       // Handle the updated rating
                //                       print(rating);
                //                     },
                //                   )
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 60,
                //   width: mediaQuery.size.width,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8,
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Colors.grey.shade200,
                //         radius: 25,
                //         backgroundImage: NetworkImage(
                //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Emily Anderson",
                //               style: TextStyle(
                //                   inherit: false,
                //                   fontSize: 14,
                //                   color: Colors.black),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(vertical: 5),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "5",
                //                     style: TextStyle(
                //                         inherit: false,
                //                         fontSize: 14,
                //                         color: Colors.grey),
                //                   ),
                //                   RatingBar.builder(
                //                     initialRating:
                //                         5, // Initial rating value
                //                     minRating: 1, // Minimum rating
                //                     direction: Axis.horizontal,
                //                     allowHalfRating: true,
                //                     itemCount:
                //                         5, // Number of rating items (stars)
                //                     itemSize:
                //                         15, // Size of each rating item
                //                     itemBuilder: (context, _) => Icon(
                //                       Icons.star,
                //                       color: Colors.amber,
                //                     ),
                //                     onRatingUpdate: (rating) {
                //                       // Handle the updated rating
                //                       print(rating);
                //                     },
                //                   )
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "Cancel",
        margin: EdgeInsets.only(right: 8),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  Widget _buildReschedule(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () {},
        text:
            "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(left: 8),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }

  Widget overViewContainer(
      BuildContext context, String title, String subtitle, IconData iconData) {
    var mediaQuery = MediaQuery.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xffE5E7EB),
            child: Icon(
              iconData,
              color: Color(0xff0066FF),
              size: 30,
            )),
        Container(
          height: 70,
          width: mediaQuery.size.width * 0.625,
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          margin: EdgeInsets.only(top: 5, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xff677294),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    inherit: false,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0066FF)),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  inherit: false,
                  fontSize: 15,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
