import 'dart:convert';

import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/DoctorsScreens/checkappiontment/check_appionment.dart';
import 'package:doctari/DoctorsScreens/doctor_menu_screen.dart';
import 'package:doctari/DoctorsScreens/upcoming_appointments_for_doc_page/upcoming_appointments_for_doc_page.dart';
import 'package:doctari/DoctorsScreens/upcoming_appointments_for_doc_page/widgets/newupcoming.dart';
import 'package:doctari/DoctorsScreens/upcoming_appointments_for_doc_page/widgets/upcomingappointments_item_widget.dart';
import 'package:doctari/DoctorsScreens/widgets/widgets.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class DoctorsDashBoard extends StatefulWidget {
  final String userId;
  final String userToken;
  // final Map<String, dynamic> appointmentData;
  // final String date;
  // final String time;
  DoctorsDashBoard({
    Key? key,
    required this.userId,
    required this.userToken,
    // required this.appointmentData,
    // required this.date,
    // required this.time,
  }) : super(key: key);

  @override
  State<DoctorsDashBoard> createState() => _DoctorsDashBoardState();
}

class _DoctorsDashBoardState extends State<DoctorsDashBoard> {
  int? patientCount = 0;
  String? firstName;
  String? lastName;
  String? profilePicture;
  bool isLoadingPr = false;
  // late List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> appointments = [];
  String? userSelectedImage; // Path to the user's selected image
  double userImageHeight =
      109.adaptSize; // Default height if no specific height is provided
  double userImageWidth =
      109.adaptSize; // Default width if no specific width is provided
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchDoctorData();
    fetchAppointments();
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    debugPrint("doctor id: $userId");
    debugPrint("doctor token: $userToken");
    // debugPrint("First Name: $firstName");
    // debugPrint("Last Name: $lastName");
  }

  // fetch doctor profile

  // Future<void> fetchDoctorData() async {
  //   try {
  //     String? userId = SessionManager.getUserId();
  //     String? userToken = SessionManager.getUserToken();
  //     debugPrint("doctor id: $userId");
  //     debugPrint("doctor FirstName: $firstName");
  //     debugPrint("doctor LastName: $lastName");
  //     setState(() {
  //       isLoadingPr = true;
  //     });
  //     DoctorProfile doctor =
  //         await DoctorApiService().fetchDoctor(int.parse(userId!), userToken!);
  //     // Update text field controllers with fetched data
  //     setState(() {
  //       firstName = doctor.firstName;
  //       lastName = doctor.lastName;
  //       profilePicture = doctor.profile_image;
  //       isLoadingPr = false;
  //     });
  //     debugPrint("specilization od the doctor: ${doctor.speciality.label}");
  //     // Update other text field controllers with respective fields from the patient object
  //   } catch (e) {
  //     // Handle errors
  //     print('Error fetching patient data: $e');
  //   }
  // }
  Future<void> fetchDoctorData() async {
    // Show loading indicator
    setState(() {
      isLoadingPr = true;
    });
    try {
      String? userId = SessionManager.getUserId();
      String? userToken = SessionManager.getUserToken();
      debugPrint("doctor id: $userId");

      // // Show loading indicator
      // setState(() {
      //   isLoadingPr = true;
      // });

      DoctorProfile doctor =
          await DoctorApiService().fetchDoctor(int.parse(userId!), userToken!);

      // Update state with fetched data
      setState(() {
        firstName = doctor.firstName;
        lastName = doctor.lastName;
        profilePicture = doctor.profile_image;
      });

      debugPrint("specialization of the doctor: ${doctor.speciality.label}");
    } catch (e) {
      // Handle errors
      print('Error fetching doctor data: $e');
      setState(() {
        isLoadingPr = false; // Ensure loading indicator is stopped on error
      });
    }
    setState(() {
      isLoadingPr = false; // Ensure loading indicator is stopped on error
    });
  }

  //add function new from ;;;;;;;;??/????//////////////////////////////

  void fetchAppointments() async {
    try {
      final List<Map<String, dynamic>> fetchedAppointments =
          await DoctorApiService.fetchDoctorAppointments(
        widget.userId as int,
        widget.userToken,
      );

      setState(() {
        appointments = fetchedAppointments;
        print("fetch appiontment: $fetchedAppointments");
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  //fetch appiontment function

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

  Future<void> getCount(String token) async {
    try {
      int count = await DoctorApiService().fetchPatientCount(token);
      // setState(() {
      //   patientCount = count ?? 0;
      // });

      print('Total number of patients: $count');
    } catch (error) {
      print('Error fetching patient count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build Method
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();

    var mediaQuery = MediaQuery.of(context);
    int userIdv = int.parse(userId!);

    // int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
    // String? doctorAccessToken =
    //     Provider.of<ProviderForStoringValues>(context).accessToken;
    print("patientAccessToken is: $userToken");
    getCount(userToken!);
    print('user id print: $userId');
    print('user token print: $userToken');

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Screen Header
              Container(
                //color: Colors.red,
                // height: mediaQuery.size.height * 0.43,
                width: mediaQuery.size.width,
                child: Stack(
                  // clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: mediaQuery.size.height * 0.18,
                          width: mediaQuery.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25)),
                            gradient: LinearGradient(
                              colors: [
                                appTheme.lightBlueA200,
                                theme.colorScheme.primary,
                              ],
                            ),
                          ),
                          child:
                              // Center(
                              //   child: isLoadingPr
                              //       ? CircularProgressIndicator(
                              //           color: Colors.white,
                              //         )
                              //       :
                              Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 19.h,
                                  top: 16.v,
                                  bottom: 48.v,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${AppLocalizations.of(context)!.hi} Dr. $firstName $lastName!",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            inherit: false),
                                      ),
                                    ),
                                    Text(
                                      "${AppLocalizations.of(context)!.upcomingAppointmentsDoctorDashboardSC}",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          inherit: false),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Center(
                                child:
                                    // isLoadingPr
                                    //     ? CircularProgressIndicator(
                                    //         color: Colors.white,
                                    //       )
                                    //     :
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorMenuScreen(
                                            name: '$firstName $lastName',
                                            profileImage: profilePicture != null
                                                ? profilePicture!
                                                : 'https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg',
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: isLoadingPr
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            backgroundImage: profilePicture !=
                                                    null
                                                // Display the selected image
                                                ? NetworkImage(profilePicture!)
                                                : NetworkImage(
                                                    'https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg',
                                                  ),
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          //),
                        ),
                      ],
                    ),

                    // Positioned(
                    //   top: mediaQuery.size.height * 0.12,
                    //   left: 0,
                    //   right: 0,
                    //   // child: AppointmentScreen(
                    //   //     doctorId: int.parse(userId!), token: userToken),
                    //   // child: FutureBuilder<Map<String, dynamic>>(
                    //   //   future: fetchLatestDoctorAppointment(
                    //   //       int.parse(userId!), userToken),
                    //   //   builder: (context, snapshot) {
                    //   //     if (snapshot.connectionState ==
                    //   //         ConnectionState.waiting) {
                    //   //       return Center(child: CircularProgressIndicator());
                    //   //     } else if (snapshot.hasError) {
                    //   //       return Center(
                    //   //           child: Text('Error: ${snapshot.error}'));
                    //   //     } else if (!snapshot.hasData ||
                    //   //         snapshot.data!.isEmpty) {
                    //   //       return Center(
                    //   //           child: Text('No appointments available'));
                    //   //     }

                    //   //     final appointment = snapshot.data!;
                    //   //     final doctor = appointment['doctor'] ?? {};
                    //   //     final startDateString = appointment['date'] ?? 'null';

                    //   //     // Print the start date string for debugging
                    //   //     print('Start Date String: $startDateString');

                    //   //     DateTime startDate;
                    //   //     try {
                    //   //       startDate = DateTime.parse(startDateString);
                    //   //     } catch (e) {
                    //   //       // Print the error for debugging
                    //   //       print('Error parsing start date: $e');
                    //   //       startDate =
                    //   //           DateTime.now(); // Fallback to current date/time
                    //   //     }

                    //   //     final formattedDate =
                    //   //         DateFormat('MMM dd, yyyy').format(startDate);
                    //   //     final formattedTime =
                    //   //         DateFormat('hh:mm a').format(startDate);
                    //   //     final doctorName =
                    //   //         doctor['full_name'] ?? 'Unknown Doctor';
                    //   //     final doctorProfilePictureUrl = doctor[
                    //   //                 'profile_picture'] !=
                    //   //             null
                    //   //         ? doctor['profile_picture']['url']
                    //   //         : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
                    //   //     final doctorDOB =
                    //   //         doctor['date_of_birth'] ?? 'Unknown';
                    //   //     final doctorGender = doctor['gender'] ?? 'Unknown';

                    //   //     return Column(
                    //   //       children: [
                    //   //         Text('Doctor: $doctor'),
                    //   //         Text('Start Date: $startDate'),
                    //   //         Text('Doctor Name: $doctorName'),
                    //   //         Text(
                    //   //             'Doctor Profile Picture URL: $doctorProfilePictureUrl'),
                    //   //         Text('Doctor DOB: $doctorDOB'),
                    //   //         Text('Doctor Gender: $doctorGender'),
                    //   //         Container(
                    //   //           height: mediaQuery.size.height * 0.3,
                    //   //           padding: EdgeInsets.symmetric(
                    //   //               horizontal: 10, vertical: 15),
                    //   //           margin: EdgeInsets.symmetric(
                    //   //               horizontal: mediaQuery.size.width * 0.06),
                    //   //           decoration: BoxDecoration(
                    //   //             color: Colors.white,
                    //   //             boxShadow: [
                    //   //               BoxShadow(
                    //   //                 color: Colors.grey,
                    //   //                 blurRadius: 5,
                    //   //                 blurStyle: BlurStyle.outer,
                    //   //               ),
                    //   //             ],
                    //   //             borderRadius: BorderRadius.circular(15),
                    //   //           ),
                    //   //           child: Column(
                    //   //             crossAxisAlignment: CrossAxisAlignment.start,
                    //   //             children: [
                    //   //               Text(
                    //   //                 "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                    //   //                 style: TextStyle(
                    //   //                   fontWeight: FontWeight.w500,
                    //   //                   color: Colors.black,
                    //   //                   inherit: false,
                    //   //                   fontSize: 16,
                    //   //                 ),
                    //   //               ),
                    //   //               Expanded(
                    //   //                 child: Padding(
                    //   //                   padding: const EdgeInsets.symmetric(
                    //   //                       horizontal: 8, vertical: 20),
                    //   //                   child: Row(
                    //   //                     children: [
                    //   //                       Container(
                    //   //                         height:
                    //   //                             mediaQuery.size.height * 0.13,
                    //   //                         width:
                    //   //                             mediaQuery.size.width * 0.27,
                    //   //                         decoration: BoxDecoration(
                    //   //                           image: DecorationImage(
                    //   //                             image: NetworkImage(
                    //   //                                 doctorProfilePictureUrl),
                    //   //                           ),
                    //   //                           color: Colors.grey.shade200,
                    //   //                           borderRadius:
                    //   //                               BorderRadius.circular(12),
                    //   //                         ),
                    //   //                       ),
                    //   //                       Padding(
                    //   //                         padding:
                    //   //                             const EdgeInsets.all(8.0),
                    //   //                         child: Column(
                    //   //                           mainAxisAlignment:
                    //   //                               MainAxisAlignment
                    //   //                                   .spaceBetween,
                    //   //                           crossAxisAlignment:
                    //   //                               CrossAxisAlignment.start,
                    //   //                           children: [
                    //   //                             Padding(
                    //   //                               padding:
                    //   //                                   const EdgeInsets.only(
                    //   //                                       bottom: 5),
                    //   //                               child: Text(
                    //   //                                 formattedDate,
                    //   //                                 style: TextStyle(
                    //   //                                   fontSize: 15,
                    //   //                                   inherit: false,
                    //   //                                   color: Colors.black,
                    //   //                                   fontWeight:
                    //   //                                       FontWeight.bold,
                    //   //                                 ),
                    //   //                               ),
                    //   //                             ),
                    //   //                             Padding(
                    //   //                               padding:
                    //   //                                   const EdgeInsets.only(
                    //   //                                       bottom: 5),
                    //   //                               child: Text(
                    //   //                                 formattedTime,
                    //   //                                 style: TextStyle(
                    //   //                                   fontSize: 15,
                    //   //                                   inherit: false,
                    //   //                                   color: Colors.black,
                    //   //                                   fontWeight:
                    //   //                                       FontWeight.bold,
                    //   //                                 ),
                    //   //                               ),
                    //   //                             ),
                    //   //                             Padding(
                    //   //                               padding:
                    //   //                                   const EdgeInsets.only(
                    //   //                                       bottom: 8),
                    //   //                               child: Text(
                    //   //                                 doctorName,
                    //   //                                 style: TextStyle(
                    //   //                                   fontSize: 12,
                    //   //                                   inherit: false,
                    //   //                                   color:
                    //   //                                       Color(0xff4B5563),
                    //   //                                   fontWeight:
                    //   //                                       FontWeight.bold,
                    //   //                                 ),
                    //   //                               ),
                    //   //                             ),
                    //   //                             Expanded(
                    //   //                               child: Text(
                    //   //                                 "Age: $doctorDOB Gender: $doctorGender",
                    //   //                                 style: TextStyle(
                    //   //                                   fontSize: 12,
                    //   //                                   inherit: false,
                    //   //                                   color:
                    //   //                                       Color(0xff4B5563),
                    //   //                                   fontWeight:
                    //   //                                       FontWeight.bold,
                    //   //                                 ),
                    //   //                               ),
                    //   //                             ),
                    //   //                           ],
                    //   //                         ),
                    //   //                       )
                    //   //                     ],
                    //   //                   ),
                    //   //                 ),
                    //   //               ),
                    //   //               Row(
                    //   //                 children: [
                    //   //                   Padding(
                    //   //                     padding: const EdgeInsets.symmetric(
                    //   //                         horizontal: 8),
                    //   //                     child: SizedBox(
                    //   //                       height: 35,
                    //   //                       width: mediaQuery.size.width * 0.35,
                    //   //                       child: ElevatedButton(
                    //   //                         onPressed: () {},
                    //   //                         style: ButtonStyle(
                    //   //                           backgroundColor:
                    //   //                               MaterialStatePropertyAll(
                    //   //                                   Color(0xffE5E7EB)),
                    //   //                         ),
                    //   //                         child: Text(
                    //   //                           "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
                    //   //                           style: TextStyle(fontSize: 15),
                    //   //                         ),
                    //   //                       ),
                    //   //                     ),
                    //   //                   ),
                    //   //                   Padding(
                    //   //                     padding: const EdgeInsets.symmetric(
                    //   //                         horizontal: 8),
                    //   //                     child: SizedBox(
                    //   //                       height: 35,
                    //   //                       width: mediaQuery.size.width * 0.35,
                    //   //                       child: ElevatedButton(
                    //   //                         onPressed: () {},
                    //   //                         child: Text(
                    //   //                           "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
                    //   //                           style: TextStyle(
                    //   //                               fontSize: 15,
                    //   //                               color: Colors.white),
                    //   //                         ),
                    //   //                       ),
                    //   //                     ),
                    //   //                   ),
                    //   //                 ],
                    //   //               ),
                    //   //             ],
                    //   //           ),
                    //   //         ),
                    //   //       ],
                    //   //     );
                    //   //   },
                    //   // ),
                    //   //last code
                    //   //                       child: FutureBuilder<Map<String, dynamic>>(
                    //   //                         future: fetchLatestDoctorAppointment(
                    //   //                             int.parse(userId!), userToken),
                    //   //                         builder: (context, snapshot) {
                    //   //                           if (snapshot.connectionState ==
                    //   //                               ConnectionState.waiting) {
                    //   //                             return Center(child: CircularProgressIndicator());
                    //   //                           } else if (snapshot.hasError) {
                    //   //                             return Center(
                    //   //                                 child: Text('Error: ${snapshot.error}'));
                    //   //                           } else if (!snapshot.hasData ||
                    //   //                               snapshot.data!.isEmpty) {
                    //   //                             return Center(
                    //   //                                 child: Text('No appointments available'));
                    //   //                           }

                    //   //                           final appointment = snapshot.data!;
                    //   //                           final doctor = appointment['doctor'] ?? {};
                    //   //                           final startDate =
                    //   //                               DateTime.parse(appointment['start']);
                    //   //                           final formattedDate =
                    //   //                               DateFormat('MMM dd, yyyy').format(startDate);
                    //   //                           final formattedTime =
                    //   //                               DateFormat('hh:mm a').format(startDate);
                    //   //                           final doctorName =
                    //   //                               doctor['full_name'] ?? 'Unknown Doctor';
                    //   //                           final doctorProfilePictureUrl = doctor[
                    //   //                                       'profile_picture'] !=
                    //   //                                   null
                    //   //                               ? doctor['profile_picture']['url']
                    //   //                               : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
                    //   //                           final doctorDOB =
                    //   //                               doctor['date_of_birth'] ?? 'Unknown';
                    //   //                           final doctorGender = doctor['gender'] ?? 'Unknown';

                    //   // // Log statements
                    //   //                           developer.log('Doctor: $doctor');
                    //   //                           developer.log('Start Date: $startDate');
                    //   //                           developer.log('Doctor Name: $doctorName');
                    //   //                           developer.log(
                    //   //                               'Doctor Profile Picture URL: $doctorProfilePictureUrl');
                    //   //                           developer.log('Doctor DOB: $doctorDOB');
                    //   //                           developer.log('Doctor Gender: $doctorGender');
                    //   //                           // // Print statements
                    //   //                           // debugPrint('Doctor: $doctor');
                    //   //                           // debugPrint('Start Date: $startDate');
                    //   //                           // debugPrint('Doctor Name: $doctorName');
                    //   //                           // debugPrint(
                    //   //                           //     'Doctor Profile Picture URL: $doctorProfilePictureUrl');
                    //   //                           // debugPrint('Doctor DOB: $doctorDOB');
                    //   //                           // debugPrint('Doctor Gender: $doctorGender');

                    //   //                           return Container(
                    //   //                             height: mediaQuery.size.height * 0.3,
                    //   //                             padding: EdgeInsets.symmetric(
                    //   //                                 horizontal: 10, vertical: 15),
                    //   //                             margin: EdgeInsets.symmetric(
                    //   //                                 horizontal: mediaQuery.size.width * 0.06),
                    //   //                             decoration: BoxDecoration(
                    //   //                               color: Colors.white,
                    //   //                               boxShadow: [
                    //   //                                 BoxShadow(
                    //   //                                   color: Colors.grey,
                    //   //                                   blurRadius: 5,
                    //   //                                   blurStyle: BlurStyle.outer,
                    //   //                                 ),
                    //   //                               ],
                    //   //                               borderRadius: BorderRadius.circular(15),
                    //   //                             ),
                    //   //                             child: Column(
                    //   //                               crossAxisAlignment: CrossAxisAlignment.start,
                    //   //                               children: [
                    //   //                                 Text(
                    //   //                                   "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                    //   //                                   style: TextStyle(
                    //   //                                     fontWeight: FontWeight.w500,
                    //   //                                     color: Colors.black,
                    //   //                                     inherit: false,
                    //   //                                     fontSize: 16,
                    //   //                                   ),
                    //   //                                 ),
                    //   //                                 Expanded(
                    //   //                                   child: Padding(
                    //   //                                     padding: const EdgeInsets.symmetric(
                    //   //                                         horizontal: 8, vertical: 20),
                    //   //                                     child: Row(
                    //   //                                       children: [
                    //   //                                         Container(
                    //   //                                           height: mediaQuery.size.height * 0.13,
                    //   //                                           width: mediaQuery.size.width * 0.27,
                    //   //                                           decoration: BoxDecoration(
                    //   //                                             image: DecorationImage(
                    //   //                                               image: NetworkImage(
                    //   //                                                   doctorProfilePictureUrl),
                    //   //                                             ),
                    //   //                                             color: Colors.grey.shade200,
                    //   //                                             borderRadius:
                    //   //                                                 BorderRadius.circular(12),
                    //   //                                           ),
                    //   //                                         ),
                    //   //                                         Padding(
                    //   //                                           padding: const EdgeInsets.all(8.0),
                    //   //                                           child: Column(
                    //   //                                             mainAxisAlignment:
                    //   //                                                 MainAxisAlignment.spaceBetween,
                    //   //                                             crossAxisAlignment:
                    //   //                                                 CrossAxisAlignment.start,
                    //   //                                             children: [
                    //   //                                               Padding(
                    //   //                                                 padding: const EdgeInsets.only(
                    //   //                                                     bottom: 5),
                    //   //                                                 child: Text(
                    //   //                                                   formattedDate,
                    //   //                                                   style: TextStyle(
                    //   //                                                     fontSize: 15,
                    //   //                                                     inherit: false,
                    //   //                                                     color: Colors.black,
                    //   //                                                     fontWeight: FontWeight.bold,
                    //   //                                                   ),
                    //   //                                                 ),
                    //   //                                               ),
                    //   //                                               Padding(
                    //   //                                                 padding: const EdgeInsets.only(
                    //   //                                                     bottom: 5),
                    //   //                                                 child: Text(
                    //   //                                                   formattedTime,
                    //   //                                                   style: TextStyle(
                    //   //                                                     fontSize: 15,
                    //   //                                                     inherit: false,
                    //   //                                                     color: Colors.black,
                    //   //                                                     fontWeight: FontWeight.bold,
                    //   //                                                   ),
                    //   //                                                 ),
                    //   //                                               ),
                    //   //                                               Padding(
                    //   //                                                 padding: const EdgeInsets.only(
                    //   //                                                     bottom: 8),
                    //   //                                                 child: Text(
                    //   //                                                   doctorName,
                    //   //                                                   style: TextStyle(
                    //   //                                                     fontSize: 12,
                    //   //                                                     inherit: false,
                    //   //                                                     color: Color(0xff4B5563),
                    //   //                                                     fontWeight: FontWeight.bold,
                    //   //                                                   ),
                    //   //                                                 ),
                    //   //                                               ),
                    //   //                                               Expanded(
                    //   //                                                 child: Text(
                    //   //                                                   "Age: $doctorDOB Gender: $doctorGender",
                    //   //                                                   style: TextStyle(
                    //   //                                                     fontSize: 12,
                    //   //                                                     inherit: false,
                    //   //                                                     color: Color(0xff4B5563),
                    //   //                                                     fontWeight: FontWeight.bold,
                    //   //                                                   ),
                    //   //                                                 ),
                    //   //                                               ),
                    //   //                                             ],
                    //   //                                           ),
                    //   //                                         )
                    //   //                                       ],
                    //   //                                     ),
                    //   //                                   ),
                    //   //                                 ),
                    //   //                                 Row(
                    //   //                                   children: [
                    //   //                                     Padding(
                    //   //                                       padding: const EdgeInsets.symmetric(
                    //   //                                           horizontal: 8),
                    //   //                                       child: SizedBox(
                    //   //                                         height: 35,
                    //   //                                         width: mediaQuery.size.width * 0.35,
                    //   //                                         child: ElevatedButton(
                    //   //                                           onPressed: () {},
                    //   //                                           style: ButtonStyle(
                    //   //                                             backgroundColor:
                    //   //                                                 MaterialStatePropertyAll(
                    //   //                                                     Color(0xffE5E7EB)),
                    //   //                                           ),
                    //   //                                           child: Text(
                    //   //                                             "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
                    //   //                                             style: TextStyle(fontSize: 15),
                    //   //                                           ),
                    //   //                                         ),
                    //   //                                       ),
                    //   //                                     ),
                    //   //                                     Padding(
                    //   //                                       padding: const EdgeInsets.symmetric(
                    //   //                                           horizontal: 8),
                    //   //                                       child: SizedBox(
                    //   //                                         height: 35,
                    //   //                                         width: mediaQuery.size.width * 0.35,
                    //   //                                         child: ElevatedButton(
                    //   //                                           onPressed: () {},
                    //   //                                           child: Text(
                    //   //                                             "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
                    //   //                                             style: TextStyle(
                    //   //                                                 fontSize: 15,
                    //   //                                                 color: Colors.white),
                    //   //                                           ),
                    //   //                                         ),
                    //   //                                       ),
                    //   //                                     ),
                    //   //                                   ],
                    //   //                                 ),
                    //   //                               ],
                    //   //                             ),
                    //   //                           );
                    //   //                         },
                    //   //                       ),
                    //   // child: FutureBuilder<Map<String, dynamic>>(
                    //   //   future: fetchLatestDoctorAppointment(
                    //   //       int.parse(userId!), userToken),
                    //   //   builder: (context, snapshot) {
                    //   //     if (snapshot.connectionState ==
                    //   //         ConnectionState.waiting) {
                    //   //       return Center(child: CircularProgressIndicator());
                    //   //     } else if (snapshot.hasError) {
                    //   //       return Center(
                    //   //           child: Text('Error: ${snapshot.error}'));
                    //   //     } else if (!snapshot.hasData ||
                    //   //         snapshot.data!.isEmpty) {
                    //   //       return Center(
                    //   //           child: Text('No appointments available'));
                    //   //     }

                    //   //     final appointment = snapshot.data!;
                    //   //     final doctor = appointment['doctor'];
                    //   //     final startDate =
                    //   //         DateTime.parse(appointment['start']);
                    //   //     final formattedDate =
                    //   //         DateFormat('MMM dd, yyyy').format(startDate);
                    //   //     final formattedTime =
                    //   //         DateFormat('hh:mm a').format(startDate);

                    //   //     return Container(
                    //   //       height: mediaQuery.size.height * 0.3,
                    //   //       padding: EdgeInsets.symmetric(
                    //   //           horizontal: 10, vertical: 15),
                    //   //       margin: EdgeInsets.symmetric(
                    //   //           horizontal: mediaQuery.size.width * 0.06),
                    //   //       decoration: BoxDecoration(
                    //   //         color: Colors.white,
                    //   //         boxShadow: [
                    //   //           BoxShadow(
                    //   //             color: Colors.grey,
                    //   //             blurRadius: 5,
                    //   //             blurStyle: BlurStyle.outer,
                    //   //           ),
                    //   //         ],
                    //   //         borderRadius: BorderRadius.circular(15),
                    //   //       ),
                    //   //       child: Column(
                    //   //         crossAxisAlignment: CrossAxisAlignment.start,
                    //   //         children: [
                    //   //           Text(
                    //   //             "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                    //   //             style: TextStyle(
                    //   //               fontWeight: FontWeight.w500,
                    //   //               color: Colors.black,
                    //   //               inherit: false,
                    //   //               fontSize: 16,
                    //   //             ),
                    //   //           ),
                    //   //           Expanded(
                    //   //             child: Padding(
                    //   //               padding: const EdgeInsets.symmetric(
                    //   //                   horizontal: 8, vertical: 20),
                    //   //               child: Row(
                    //   //                 children: [
                    //   //                   Container(
                    //   //                     height: mediaQuery.size.height * 0.13,
                    //   //                     width: mediaQuery.size.width * 0.27,
                    //   //                     decoration: BoxDecoration(
                    //   //                       image: DecorationImage(
                    //   //                         image: NetworkImage(
                    //   //                             doctor['profile_picture']
                    //   //                                 ['url']),
                    //   //                       ),
                    //   //                       color: Colors.grey.shade200,
                    //   //                       borderRadius:
                    //   //                           BorderRadius.circular(12),
                    //   //                     ),
                    //   //                   ),
                    //   //                   Padding(
                    //   //                     padding: const EdgeInsets.all(8.0),
                    //   //                     child: Column(
                    //   //                       mainAxisAlignment:
                    //   //                           MainAxisAlignment.spaceBetween,
                    //   //                       crossAxisAlignment:
                    //   //                           CrossAxisAlignment.start,
                    //   //                       children: [
                    //   //                         Padding(
                    //   //                           padding: const EdgeInsets.only(
                    //   //                               bottom: 5),
                    //   //                           child: Text(
                    //   //                             formattedDate,
                    //   //                             style: TextStyle(
                    //   //                               fontSize: 15,
                    //   //                               inherit: false,
                    //   //                               color: Colors.black,
                    //   //                               fontWeight: FontWeight.bold,
                    //   //                             ),
                    //   //                           ),
                    //   //                         ),
                    //   //                         Padding(
                    //   //                           padding: const EdgeInsets.only(
                    //   //                               bottom: 5),
                    //   //                           child: Text(
                    //   //                             formattedTime,
                    //   //                             style: TextStyle(
                    //   //                               fontSize: 15,
                    //   //                               inherit: false,
                    //   //                               color: Colors.black,
                    //   //                               fontWeight: FontWeight.bold,
                    //   //                             ),
                    //   //                           ),
                    //   //                         ),
                    //   //                         Padding(
                    //   //                           padding: const EdgeInsets.only(
                    //   //                               bottom: 8),
                    //   //                           child: Text(
                    //   //                             doctor['full_name'],
                    //   //                             style: TextStyle(
                    //   //                               fontSize: 12,
                    //   //                               inherit: false,
                    //   //                               color: Color(0xff4B5563),
                    //   //                               fontWeight: FontWeight.bold,
                    //   //                             ),
                    //   //                           ),
                    //   //                         ),
                    //   //                         Expanded(
                    //   //                           child: Text(
                    //   //                             "Age: ${doctor['date_of_birth']} Gender: ${doctor['gender']}",
                    //   //                             style: TextStyle(
                    //   //                               fontSize: 12,
                    //   //                               inherit: false,
                    //   //                               color: Color(0xff4B5563),
                    //   //                               fontWeight: FontWeight.bold,
                    //   //                             ),
                    //   //                           ),
                    //   //                         ),
                    //   //                       ],
                    //   //                     ),
                    //   //                   )
                    //   //                 ],
                    //   //               ),
                    //   //             ),
                    //   //           ),
                    //   //           Row(
                    //   //             children: [
                    //   //               Padding(
                    //   //                 padding: const EdgeInsets.symmetric(
                    //   //                     horizontal: 8),
                    //   //                 child: SizedBox(
                    //   //                   height: 35,
                    //   //                   width: mediaQuery.size.width * 0.35,
                    //   //                   child: ElevatedButton(
                    //   //                     onPressed: () {},
                    //   //                     style: ButtonStyle(
                    //   //                       backgroundColor:
                    //   //                           MaterialStatePropertyAll(
                    //   //                               Color(0xffE5E7EB)),
                    //   //                     ),
                    //   //                     child: Text(
                    //   //                       "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
                    //   //                       style: TextStyle(fontSize: 15),
                    //   //                     ),
                    //   //                   ),
                    //   //                 ),
                    //   //               ),
                    //   //               Padding(
                    //   //                 padding: const EdgeInsets.symmetric(
                    //   //                     horizontal: 8),
                    //   //                 child: SizedBox(
                    //   //                   height: 35,
                    //   //                   width: mediaQuery.size.width * 0.35,
                    //   //                   child: ElevatedButton(
                    //   //                     onPressed: () {},
                    //   //                     child: Text(
                    //   //                       "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
                    //   //                       style: TextStyle(
                    //   //                           fontSize: 15,
                    //   //                           color: Colors.white),
                    //   //                     ),
                    //   //                   ),
                    //   //                 ),
                    //   //               ),
                    //   //             ],
                    //   //           ),
                    //   //         ],
                    //   //       ),
                    //   //     );
                    //   //   },
                    //   // ),
                    //   // child: Container(
                    //   //   height: mediaQuery.size.height * 0.3,
                    //   //   padding:
                    //   //       EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    //   //   margin: EdgeInsets.symmetric(
                    //   //       horizontal: mediaQuery.size.width * 0.06),
                    //   //   decoration: BoxDecoration(
                    //   //       color: Colors.white,
                    //   //       boxShadow: [
                    //   //         BoxShadow(
                    //   //             color: Colors.grey,
                    //   //             blurRadius: 5,
                    //   //             blurStyle: BlurStyle.outer)
                    //   //       ],
                    //   //       borderRadius: BorderRadius.circular(15)),
                    //   //   child: Column(
                    //   //     crossAxisAlignment: CrossAxisAlignment.start,
                    //   //     children: [
                    //   //       Text(
                    //   //         "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                    //   //         style: TextStyle(
                    //   //             fontWeight: FontWeight.w500,
                    //   //             color: Colors.black,
                    //   //             inherit: false,
                    //   //             fontSize: 16),
                    //   //       ),
                    //   //       Expanded(
                    //   //         child: Padding(
                    //   //           padding: const EdgeInsets.symmetric(
                    //   //               horizontal: 8, vertical: 20),
                    //   //           child: Row(
                    //   //             children: [
                    //   //               Container(
                    //   //                 height: mediaQuery.size.height * 0.13,
                    //   //                 width: mediaQuery.size.width * 0.27,
                    //   //                 decoration: BoxDecoration(
                    //   //                     image: DecorationImage(
                    //   //                         image: NetworkImage(
                    //   //                             "https://www.erc.com.pk/wp-content/uploads/person2.jpg")),
                    //   //                     color: Colors.grey.shade200,
                    //   //                     borderRadius:
                    //   //                         BorderRadius.circular(12)),
                    //   //               ),
                    //   //               Padding(
                    //   //                 padding: const EdgeInsets.all(8.0),
                    //   //                 child: Column(
                    //   //                   mainAxisAlignment:
                    //   //                       MainAxisAlignment.spaceBetween,
                    //   //                   crossAxisAlignment:
                    //   //                       CrossAxisAlignment.start,
                    //   //                   children: [
                    //   //                     Padding(
                    //   //                       padding: const EdgeInsets.only(
                    //   //                           bottom: 5),
                    //   //                       child: Text(
                    //   //                         "Sep 30, 2024",
                    //   //                         style: TextStyle(
                    //   //                             fontSize: 15,
                    //   //                             inherit: false,
                    //   //                             color: Colors.black,
                    //   //                             fontWeight: FontWeight.bold),
                    //   //                       ),
                    //   //                     ),
                    //   //                     Padding(
                    //   //                       padding: const EdgeInsets.only(
                    //   //                           bottom: 5),
                    //   //                       child: Text(
                    //   //                         "10:00 AM",
                    //   //                         style: TextStyle(
                    //   //                             fontSize: 15,
                    //   //                             inherit: false,
                    //   //                             color: Colors.black,
                    //   //                             fontWeight: FontWeight.bold),
                    //   //                       ),
                    //   //                     ),
                    //   //                     Padding(
                    //   //                       padding: const EdgeInsets.only(
                    //   //                           bottom: 8),
                    //   //                       child: Text(
                    //   //                         "Abdul Rahman",
                    //   //                         style: TextStyle(
                    //   //                             fontSize: 12,
                    //   //                             inherit: false,
                    //   //                             color: Color(0xff4B5563),
                    //   //                             fontWeight: FontWeight.bold),
                    //   //                       ),
                    //   //                     ),
                    //   //                     Expanded(
                    //   //                       child: Text(
                    //   //                         "Age: 22yrs Gender: Male",
                    //   //                         style: TextStyle(
                    //   //                             fontSize: 12,
                    //   //                             inherit: false,
                    //   //                             color: Color(0xff4B5563),
                    //   //                             fontWeight: FontWeight.bold),
                    //   //                       ),
                    //   //                     ),
                    //   //                   ],
                    //   //                 ),
                    //   //               )
                    //   //             ],
                    //   //           ),
                    //   //         ),
                    //   //       ),
                    //   //       Row(
                    //   //         children: [
                    //   //           Padding(
                    //   //             padding:
                    //   //                 const EdgeInsets.symmetric(horizontal: 8),
                    //   //             child: SizedBox(
                    //   //               height: 35,
                    //   //               width: mediaQuery.size.width * 0.35,
                    //   //               child: ElevatedButton(
                    //   //                   onPressed: () {},
                    //   //                   style: ButtonStyle(
                    //   //                       backgroundColor:
                    //   //                           MaterialStatePropertyAll(
                    //   //                               Color(0xffE5E7EB))),
                    //   //                   child: Text(
                    //   //                     "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
                    //   //                     style: TextStyle(fontSize: 15),
                    //   //                   )),
                    //   //             ),
                    //   //           ),
                    //   //           Padding(
                    //   //             padding:
                    //   //                 const EdgeInsets.symmetric(horizontal: 8),
                    //   //             child: SizedBox(
                    //   //               height: 35,
                    //   //               width: mediaQuery.size.width * 0.35,
                    //   //               child: ElevatedButton(
                    //   //                   onPressed: () {},
                    //   //                   child: Text(
                    //   //                     "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
                    //   //                     style: TextStyle(
                    //   //                         fontSize: 15,
                    //   //                         color: Colors.white),
                    //   //                   )),
                    //   //             ),
                    //   //           )
                    //   //         ],
                    //   //       )
                    //   //     ],
                    //   //   ),
                    //   // ),
                    //   child: buildAppiontment(context),
                    // )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // DoctorResheduleWidgets(),
              // Container(
              //   height: 350,

              //   // child: UpcomingAppointmentsForDocPagesDoc(
              //   //   doctId: userIdv,
              //   //   token: userToken,),
              //   //comented lattest here
              //   child: UpcomingAppointmentsForDocPage(
              //     doctId: userIdv,
              //     token: userToken,
              //   ),
              // ),
              ///Upcoming and Past Appointments ForDoc
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),

                    child: Text("${AppLocalizations.of(context)!.futureAppointments}",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.37,

                    // child: UpcomingAppointmentsForDocPagesDoc(
                    //   doctId: userIdv,
                    //   token: userToken,),
                    //comented lattest here
                    child: UpcomingAppointmentsForDocPagesDoc(
                      doctId: userIdv,
                      token: userToken,
                    ),
                  ),

                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("${AppLocalizations.of(context)!.pastAppointments}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                  ),
                  PastNotDoneAppointmentsForDocPagesDoc(
                    doctId: userIdv,
                    token: userToken,
                  ),

                ],
              ),
              // SizedBox(
              //   height: 30,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // OVERVIEW SECTION
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: GestureDetector(
              //           onTap: () {
              //             // Navigator.push(
              //             //     context,
              //             //     MaterialPageRoute(
              //             //         builder: (context) => AppointmentScreen(
              //             //               doctorId: int.parse(userId!),
              //             //               token: userToken,
              //             //             )));
              //           },
              //           child: Text(
              //             "${AppLocalizations.of(context)!.overviewDoctorDashboardSC}",
              //             style: TextStyle(
              //                 inherit: false,
              //                 fontSize: 20,
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //       ),
              SizedBox(
                height: 10,
              ),
              //here check if patient count is 0 then not show on page
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (patientCount ?? 0) > 0
                    ? overViewContainer(
                        userToken,
                        context,
                        "Patients",
                        "${patientCount}",
                        Icons.group,
                      )
                    : SizedBox
                        .shrink(), // Render nothing if patientCount is 0 or null
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: overViewContainer(userToken, context, "Patients",
              //       "${patientCount}",
              //       Icons.group
              //       ),
              // ),
              // overViewContainer(
              //     context, "Consultation", " ", Icons.join_full),
              // overViewContainer(
              //     context, "Revenue", "1023.42\$", Icons.attach_money),

              //       // REVIEW SECTION
              //       // Row(
              //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       //   children: [
              //       //     Padding(
              //       //       padding: const EdgeInsets.all(8.0),
              //       //       child: Text(
              //       //         "Reviews",
              //       //         style: TextStyle(
              //       //             inherit: false,
              //       //             fontSize: 20,
              //       //             color: Colors.black,
              //       //             fontWeight: FontWeight.w500),
              //       //       ),
              //       //     ),
              //       //     GestureDetector(
              //       //       onTap: () {},
              //       //       child: Text(
              //       //         "See All",
              //       //         style: TextStyle(
              //       //             inherit: false,
              //       //             fontSize: 15,
              //       //             color: Colors.grey,
              //       //             fontWeight: FontWeight.w500),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //       // Container(
              //       //   height: 60,
              //       //   width: mediaQuery.size.width,
              //       //   padding: EdgeInsets.symmetric(
              //       //     horizontal: 8,
              //       //   ),
              //       //   child: Row(
              //       //     children: [
              //       //       CircleAvatar(
              //       //         backgroundColor: Colors.grey.shade200,
              //       //         radius: 25,
              //       //         backgroundImage: NetworkImage(
              //       //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
              //       //       ),
              //       //       Padding(
              //       //         padding: const EdgeInsets.all(8.0),
              //       //         child: Column(
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Text(
              //       //               "Emily Anderson",
              //       //               style: TextStyle(
              //       //                   inherit: false,
              //       //                   fontSize: 14,
              //       //                   color: Colors.black),
              //       //             ),
              //       //             Padding(
              //       //               padding:
              //       //                   const EdgeInsets.symmetric(vertical: 5),
              //       //               child: Row(
              //       //                 mainAxisAlignment: MainAxisAlignment.start,
              //       //                 children: [
              //       //                   Text(
              //       //                     "5",
              //       //                     style: TextStyle(
              //       //                         inherit: false,
              //       //                         fontSize: 14,
              //       //                         color: Colors.grey),
              //       //                   ),
              //       //                   RatingBar.builder(
              //       //                     initialRating:
              //       //                         5, // Initial rating value
              //       //                     minRating: 1, // Minimum rating
              //       //                     direction: Axis.horizontal,
              //       //                     allowHalfRating: true,
              //       //                     itemCount:
              //       //                         5, // Number of rating items (stars)
              //       //                     itemSize:
              //       //                         15, // Size of each rating item
              //       //                     itemBuilder: (context, _) => Icon(
              //       //                       Icons.star,
              //       //                       color: Colors.amber,
              //       //                     ),
              //       //                     onRatingUpdate: (rating) {
              //       //                       // Handle the updated rating
              //       //                       print(rating);
              //       //                     },
              //       //                   )
              //       //                 ],
              //       //               ),
              //       //             )
              //       //           ],
              //       //         ),
              //       //       )
              //       //     ],
              //       //   ),
              //       // ),
              //       // Container(
              //       //   height: 60,
              //       //   width: mediaQuery.size.width,
              //       //   padding: EdgeInsets.symmetric(
              //       //     horizontal: 8,
              //       //   ),
              //       //   child: Row(
              //       //     children: [
              //       //       CircleAvatar(
              //       //         backgroundColor: Colors.grey.shade200,
              //       //         radius: 25,
              //       //         backgroundImage: NetworkImage(
              //       //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
              //       //       ),
              //       //       Padding(
              //       //         padding: const EdgeInsets.all(8.0),
              //       //         child: Column(
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Text(
              //       //               "Emily Anderson",
              //       //               style: TextStyle(
              //       //                   inherit: false,
              //       //                   fontSize: 14,
              //       //                   color: Colors.black),
              //       //             ),
              //       //             Padding(
              //       //               padding:
              //       //                   const EdgeInsets.symmetric(vertical: 5),
              //       //               child: Row(
              //       //                 mainAxisAlignment: MainAxisAlignment.start,
              //       //                 children: [
              //       //                   Text(
              //       //                     "5",
              //       //                     style: TextStyle(
              //       //                         inherit: false,
              //       //                         fontSize: 14,
              //       //                         color: Colors.grey),
              //       //                   ),
              //       //                   RatingBar.builder(
              //       //                     initialRating:
              //       //                         5, // Initial rating value
              //       //                     minRating: 1, // Minimum rating
              //       //                     direction: Axis.horizontal,
              //       //                     allowHalfRating: true,
              //       //                     itemCount:
              //       //                         5, // Number of rating items (stars)
              //       //                     itemSize:
              //       //                         15, // Size of each rating item
              //       //                     itemBuilder: (context, _) => Icon(
              //       //                       Icons.star,
              //       //                       color: Colors.amber,
              //       //                     ),
              //       //                     onRatingUpdate: (rating) {
              //       //                       // Handle the updated rating
              //       //                       print(rating);
              //       //                     },
              //       //                   )
              //       //                 ],
              //       //               ),
              //       //             )
              //       //           ],
              //       //         ),
              //       //       )
              //       //     ],
              //       //   ),
              //       // ),
              //       // Container(
              //       //   height: 60,
              //       //   width: mediaQuery.size.width,
              //       //   padding: EdgeInsets.symmetric(
              //       //     horizontal: 8,
              //       //   ),
              //       //   child: Row(
              //       //     children: [
              //       //       CircleAvatar(
              //       //         backgroundColor: Colors.grey.shade200,
              //       //         radius: 25,
              //       //         backgroundImage: NetworkImage(
              //       //             "https://i.pinimg.com/564x/68/41/87/6841874b97182f7125403fd68d26e126.jpg"),
              //       //       ),
              //       //       Padding(
              //       //         padding: const EdgeInsets.all(8.0),
              //       //         child: Column(
              //       //           crossAxisAlignment: CrossAxisAlignment.start,
              //       //           children: [
              //       //             Text(
              //       //               "Emily Anderson",
              //       //               style: TextStyle(
              //       //                   inherit: false,
              //       //                   fontSize: 14,
              //       //                   color: Colors.black),
              //       //             ),
              //       //             Padding(
              //       //               padding:
              //       //                   const EdgeInsets.symmetric(vertical: 5),
              //       //               child: Row(
              //       //                 mainAxisAlignment: MainAxisAlignment.start,
              //       //                 children: [
              //       //                   Text(
              //       //                     "5",
              //       //                     style: TextStyle(
              //       //                         inherit: false,
              //       //                         fontSize: 14,
              //       //                         color: Colors.grey),
              //       //                   ),
              //       //                   RatingBar.builder(
              //       //                     initialRating:
              //       //                         5, // Initial rating value
              //       //                     minRating: 1, // Minimum rating
              //       //                     direction: Axis.horizontal,
              //       //                     allowHalfRating: true,
              //       //                     itemCount:
              //       //                         5, // Number of rating items (stars)
              //       //                     itemSize:
              //       //                         15, // Size of each rating item
              //       //                     itemBuilder: (context, _) => Icon(
              //       //                       Icons.star,
              //       //                       color: Colors.amber,
              //       //                     ),
              //       //                     onRatingUpdate: (rating) {
              //       //                       // Handle the updated rating
              //       //                       print(rating);
              //       //                     },
              //       //                   )
              //       //                 ],
              //       //               ),
              //       //             )
              //       //           ],
              //       //         ),
              //       //       )
              //       //     ],
              //       //   ),
              //       // )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget alertDiaLogBox(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.3,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 5, blurStyle: BlurStyle.outer)
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                inherit: false,
                fontSize: 16),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: mediaQuery.size.height * 0.13,
                    width: mediaQuery.size.width * 0.27,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Sep 30, 2024",
                            style: TextStyle(
                                fontSize: 15,
                                inherit: false,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "10:00 AM",
                            style: TextStyle(
                                fontSize: 15,
                                inherit: false,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Abdul Rahman",
                            style: TextStyle(
                                fontSize: 12,
                                inherit: false,
                                color: Color(0xff4B5563),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Age: 22yrs Gender: Male",
                          style: TextStyle(
                              fontSize: 12,
                              inherit: false,
                              color: Color(0xff4B5563),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 35,
                  width: mediaQuery.size.width * 0.35,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffE5E7EB))),
                      child: Text(
                        "${AppLocalizations.of(context)!.cancelAppiontmentDetailDocSecSC}",
                        style: TextStyle(fontSize: 15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 35,
                  width: mediaQuery.size.width * 0.35,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Widget overViewContainer(String token, BuildContext context, String title,
  //     String subtitle, IconData iconData) {
  //   var mediaQuery = MediaQuery.of(context);

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       CircleAvatar(
  //           radius: 32,
  //           backgroundColor: Color(0xffE5E7EB),
  //           child: Icon(
  //             iconData,
  //             color: Color(0xff0066FF),
  //             size: 30,
  //           )),
  //       Expanded(
  //         child: Container(
  //           height: 80,
  //           width: mediaQuery.size.width * 0.625,
  //           padding: EdgeInsets.symmetric(
  //             horizontal: 30,
  //           ),
  //           margin: EdgeInsets.only(top: 5, bottom: 8),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(
  //                 color: Color(0xff677294),
  //               )),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 title,
  //                 style: TextStyle(
  //                     inherit: false,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xff0066FF)),
  //               ),
  //               FutureBuilder<int>(
  //                 future: DoctorApiService().fetchPatientCount(token),
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     // Show a sized box while waiting for the data
  //                     return SizedBox(
  //                       height: 100, // Adjust as needed
  //                     );
  //                   } else if (snapshot.hasError) {
  //                     // Show an error message if there was an error fetching the data
  //                     return Text('Error: ${snapshot.error}');
  //                   } else if (!snapshot.hasData) {
  //                     // Show 0 if no data is available
  //                     return Text(
  //                       '0',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     );
  //                   }

  //                   // Display the patient count when data is available
  //                   final patientCount = snapshot.data!;
  //                   return Text(
  //                     '$patientCount',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget overViewContainer(String token, BuildContext context, String title,
      String subtitle, IconData iconData) {
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
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: 80,
            width: mediaQuery.size.width * 0.625,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            margin: EdgeInsets.only(top: 5, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xff677294),
              ),
            ),
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
                    color: Color(0xff0066FF),
                  ),
                ),
                FutureBuilder<int>(
                  future: DoctorApiService().fetchPatientCount(token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while waiting for the data
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Show an error message if there was an error fetching the data
                      return Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 12),
                      );
                    } else if (!snapshot.hasData) {
                      // Show 0 if no data is available
                      return Text(
                        '0',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    // Display the patient count when data is available
                    final patientCount = snapshot.data!;
                    return Text(
                      '$patientCount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ////ADD HERE WIDGET
  Widget buildAppiontment(BuildContext context) {
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDoctorAppointments(int.parse(userId!), userToken!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while fetching data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error message if there's an error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show message if no data is available
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
              final startDate =
                  startDateStr.isNotEmpty ? DateTime.parse(startDateStr) : null;
              final formattedDate = startDate != null
                  ? DateFormat('MMM dd, yyyy').format(startDate)
                  : 'Unknown Date';
              final formattedTime = startDate != null
                  ? DateFormat('hh:mm a').format(startDate)
                  : 'Unknown Time';
              final doctorName = doctor['full_name'] ?? 'Unknown Doctor';
              final doctorProfilePictureUrl = doctor['profile_picture'] != null
                  ? doctor['profile_picture']['url']
                  : 'https://www.erc.com.pk/wp-content/uploads/person2.jpg';
              final doctorDOB = doctor['date_of_birth'] ?? 'Unknown';
              final doctorGender = doctor['gender'] ?? 'Unknown';

              return Container(
                width: MediaQuery.of(context).size.width *
                    0.7, // Adjust width as needed
                margin: EdgeInsets.symmetric(horizontal: 10), // Adjust margin
                child: Card(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
                              style: Theme.of(context).textTheme.titleLarge,
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
                                      // Positioned loading indicator if needed
                                      Positioned(
                                        child: snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? CircularProgressIndicator()
                                            : SizedBox
                                                .shrink(), // Hide when not waiting
                                        bottom: 0,
                                        right: 0,
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
                      // Optional Positioned Widget for any additional overlay content
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
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
        onPressed: () {
          //         Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => UpcomingappointmentsItemWidget(appointmentData: appointments,
          //     date: formattedDate,
          //     time: formattedTime,)),
          // );
        },
        text:
            "${AppLocalizations.of(context)!.rescheduleAppiontmentDetailDocSecSC}",
        margin: EdgeInsets.only(left: 8),
        buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
      ),
    );
  }

  Widget _buildUpcomingAppointments(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
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
