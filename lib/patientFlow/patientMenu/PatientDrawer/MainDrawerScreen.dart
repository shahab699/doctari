import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/chat/conversation_list_for_patient.dart';
import 'package:doctari/language_change/language_change.dart';
import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
import 'package:doctari/patientFlow/patientMenu/AllDocotorsMainScreen.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/payement_methode/payement_methode.dart';
import 'package:doctari/presentation/chatbox_one_screen/chatbox_one_screen.dart';
import 'package:doctari/patientFlow/patientMenu/contact_us.dart';
import 'package:doctari/patientFlow/patientMenu/notification_screen/notification_screen.dart';
import 'package:doctari/patientFlow/patientMenu/setting_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/web%20view/payment_methode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../all_doctors_and_reschedule/appointments_and_completed_appointments/apointments.dart';
import 'SubDrawerScreens/PatientProfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientMainDrawer extends StatelessWidget {
  final String name;
  final String profileImage;

  PatientMainDrawer({required this.name, required this.profileImage, Key? key})
      : super(
          key: key,
        );

  List<String> getMenuOptions(BuildContext context) {
    return [
      "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
      "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
      "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.notificationsDoctorMenuScreenSC}",
      // "Notifications",
      // "Contact Us",
      "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.languageChangeSC}",
      // "${AppLocalizations.of(context)!.paymentMethodSC}",
    ];
  }
  // List<String> menuOptions = [
  //   "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
  //     "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
  //     "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}",
  //   "${AppLocalizations.of(context)!.notificationsDoctorMenuScreenSC}",
  //   // "Notifications",
  //   // "Contact Us",
  //   "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}"
  // ];

  List<String> menuIcons = [
    "assets/myassets/user.svg",
    "assets/myassets/bottom4.svg",
    "assets/myassets/calender.svg",
    "assets/myassets/bottom2.svg",
    "assets/myassets/notification.svg",
    "assets/myassets/contact.svg",
    "assets/myassets/setting.svg",
  ];

  //  Future<void> fetchPatientData(BuildContext context) async {
  //   try {
  //     int? patientId = await Provider.of<UserIdProvider>(context).patientId;
  //     debugPrint("id of the patient: $patientId");
  //     // PatientApiService().fetchPatient(patientId!);
  //     // Fetch patient data using the patientId
  //     Patient patient = await PatientApiService().fetchPatient(patientId!);
  //     // Update text field controllers with fetched data
  //     setState(() {
  //       nameController.text = patient.firstName;
  //       lastNameController.text = patient.lastName;
  //       mobileNoController.text = patient.contactNo;
  //       dateOfBirthController.text = patient.dob;
  //       emailController.text = patient.email;
  //       countryController.text = patient.country;
  //       cityController.text = patient.city;
  //       nYGSGController.text = patient.documentNo;
  //       gender = patient.gender;
  //     });

  //     // Update other text field controllers with respective fields from the patient object
  //   } catch (e) {
  //     // Handle errors
  //     print('Error fetching patient data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List<String> menuOptions = getMenuOptions(context);
    int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
    String? patientAccessToken =
        Provider.of<ProviderForStoringValues>(context).accessToken;
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    print("idd: ${int.parse(userId!)}");

    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize:
              Size(mediaQuery.size.width, mediaQuery.size.height * 0.15),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                profileImage,
              ),
              radius: 25,
            ),
            title: Text(
              "${name}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            ),
            // subtitle: Text(
            //   "dr.aaron@gmail.com",
            //   style: TextStyle(fontSize: 12, color: Colors.white),
            // ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.5, -0.28),
                end: Alignment(0.5, 1),
                colors: [
                  appTheme.lightBlueA200,
                  theme.colorScheme.primary,
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: mediaQuery.size.height * 0.05),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            onTap: () async {
                              if (index == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientProfileScreen(
                                        patientId: int.parse(userId),
                                        patientAccessToken: userToken!,
                                      ),
                                    ));
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConversationListPageForPatient(
                                              currentUserId: int.parse(userId),
                                            )));
                              } else if (index == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentScreen(),
                                    ));
                              } else if (index == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AllDocotrsMainScreen(),
                                    ));
                              } else if (index == 4) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientSettingScreen(
                                        token: userToken!,
                                      ),
                                    ));
                              }
                              // else if (index == 5) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => PaymentMethode(),
                              //       ));
                              // }
                              else if (index == 5) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LanguageChangeScreen()));
                              }
                              // else {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => PaymentMethode(),
                              //       ));
                              // }
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 22,
                                child: SvgPicture.asset(
                                  menuIcons[index],
                                  color: Colors.white,
                                )),
                            title: Text(
                              menuOptions[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            // subtitle: Text("dr.aaron@gmail.com", style: TextStyle(fontSize: 12, color: Colors.white),),
                          ),
                        );
                      },
                      itemCount: menuOptions.length,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    print("this is logout");
                    await _logout(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 22,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "${AppLocalizations.of(context)!.logoutDoctorMenuScreenSC}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SessionManager.clearSession();
    //  Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: ((context) => RegisterAsScreen())));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
