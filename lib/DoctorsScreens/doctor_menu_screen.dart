import 'package:doctari/DoctorsScreens/Appointments&ShedulerForDoctor/MainDoctorShedular.dart';
import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/SubBottomNavigationScreens/DoctorsChatScreens.dart';
import 'package:doctari/DoctorsScreens/DoctorsTimeSlot/doctor_time_slot_screen.dart';
import 'package:doctari/DoctorsScreens/DoctorsTimeSlot/get_doctor_time_slot_screen.dart';
import 'package:doctari/DoctorsScreens/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/chat/conversation_list.dart';
import 'package:doctari/language_change/language_change.dart';
import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
import 'package:doctari/patientFlow/patientMenu/contact_us.dart';
import 'package:doctari/patientFlow/patientMenu/setting_screen.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/presentation/settings_screen/settings_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:provider/provider.dart';
import 'DoctorsNotificationScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorMenuScreen extends StatelessWidget {
  final String name;
  final String profileImage;
  DoctorMenuScreen({required this.name, required this.profileImage, Key? key})
      : super(
          key: key,
        );
  List<String> getMenuOptions(BuildContext context) {
    return [
      "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
      "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
      "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.notificationsDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.contactUsDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.doctorTimeSlotDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.createdTimeSlotDoctorMenuScreenSC}",
      "${AppLocalizations.of(context)!.languageChangeSC}",
    ];
  }
  // List<String> menuOptions = [
  //   "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
  //   "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}",
  //   "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}",
  //   "${AppLocalizations.of(context)!.notificationsDoctorMenuScreenSC}",
  //   "${AppLocalizations.of(context)!.contactUsDoctorMenuScreenSC}",
  //   "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}"
  // ];

  List<IconData> menuIcons = [
    Icons.person,
    Icons.chat,
    Icons.calendar_month_outlined,
    Icons.notifications,
    Icons.domain_verification,
    Icons.settings,
    Icons.calendar_month_outlined,
    Icons.calendar_month_outlined,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    List<String> menuOptions = getMenuOptions(context);
    int? doctorId = Provider.of<ProviderForStoringValues>(context).doctorId;
    String? Token = Provider.of<ProviderForStoringValues>(context).accessToken;
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();

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
              // backgroundImage: NetworkImage(
              //     "https://as1.ftcdn.net/v2/jpg/01/72/18/66/1000_F_172186647_e93OQdc8KSoBzIPqfKG0UoJSJhR15HLa.jpg"),
              backgroundImage: NetworkImage(
                profileImage,
              ),
              radius: 25,
            ),
            title: Text(
              "${name}",
              // "Dr. Aaron Smith",
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
                            onTap: () {
                              if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.profileDocProfileScrenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorProfileScreen(
                                        doctorId: int.parse(userId!),
                                        doctorToken: userToken!,
                                      ),
                                    ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.chatAppiontmentDetailDocSecSC}") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Scaffold(
                                      body: ConversationListPage(
                                        currentUserId: int.parse(userId!),
                                      ),
                                    );
                                  },
                                ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainDoctorShedular(),
                                    ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.notificationsDoctorMenuScreenSC}") {
                                //Commenting it out for now
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           DoctorsNotifications(),
                                //     ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.contactUsDoctorMenuScreenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactUsScreen(),
                                    ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientSettingScreen(
                                        token: userToken!,
                                      ),
                                    ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.doctorTimeSlotDoctorMenuScreenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorTimeSlot(
                                        token: userToken!,
                                      ),
                                    ));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.createdTimeSlotDoctorMenuScreenSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GetShedual()));
                              } else if (menuOptions[index] ==
                                  "${AppLocalizations.of(context)!.languageChangeSC}") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LanguageChangeScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${AppLocalizations.of(context)!.inProgressDoctorMenuScreenSC}")));
                              }
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 22,
                              child: Icon(
                                menuIcons[index],
                                color: Colors.white,
                              ),
                            ),
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
                      itemCount: 9,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
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
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      // subtitle: Text("dr.aaron@gmail.com", style: TextStyle(fontSize: 12, color: Colors.white),),
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
