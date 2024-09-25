import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/chat/chat_zeggo.dart';
import 'package:doctari/chat/conversation_list_for_patient.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/apointments.dart';
import 'package:doctari/patientFlow/dashBoard/dashboard_one_screen/dashboard_one_screen.dart';
import 'package:doctari/presentation/chatbox_one_screen/chatbox_one_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../all_doctors_and_reschedule/all_doctors/all_doctors_page/all_doctors_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientBottomNavigation extends StatefulWidget {
  const PatientBottomNavigation();

  @override
  State<PatientBottomNavigation> createState() =>
      _PatientBottomNavigationState();
}

class _PatientBottomNavigationState extends State<PatientBottomNavigation> {
  // List<Widget> screens = [
  //   PatientDashboardOneScreen(),
  //   AllDoctorsScreen(),
  //   AppointmentScreen(),
  //   // ChatboxOneScreen()
  //   ConversationListPageForPatient()
  // ];

  List<String> bottomIcons = [
    "assets/myassets/bottom1.svg",
    "assets/myassets/bottom2.svg",
    "assets/myassets/bottom3.svg",
    "assets/myassets/bottom4.svg"
  ];

  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    // int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
    // String? patientAccessToken =
    //     Provider.of<ProviderForStoringValues>(context).accessToken;

    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    print("idd: ${int.parse(userId!)}");
    List<Widget> screens = [
      PatientDashboardOneScreen(
        currentUserId: int.parse(userId),
        token: userToken!,
      ),
      AllDoctorsScreen(),
      AppointmentScreen(),
      // ChatboxOneScreen()
      ConversationListPageForPatient(
        currentUserId: int.parse(userId),
      )
      //ChatApp(currentUserId: int.parse(userId))
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedScreen],
      bottomNavigationBar: customNavigationBar(context),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => PatientMainDrawer(),));
      //     },
      //   backgroundColor: Color(0xff0066FF),
      //   elevation: 8,
      //   shape: CircleBorder(),
      //   child: Icon(
      //     Icons.dehaze,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      // ),
    );
  }

  customNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurStyle: BlurStyle.inner)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              selectedScreen = 0;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor:
                  selectedScreen == 0 ? Color(0xff0066FF) : Colors.transparent,
              radius: 22,
              child: SvgPicture.asset(
                bottomIcons[0],
                color: selectedScreen == 0 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedScreen = 1;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor:
                  selectedScreen == 1 ? Color(0xff0066FF) : Colors.transparent,
              radius: 22,
              child: SvgPicture.asset(
                bottomIcons[1],
                color: selectedScreen == 1 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedScreen = 2;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor:
                  selectedScreen == 2 ? Color(0xff0066FF) : Colors.transparent,
              radius: 22,
              child: SvgPicture.asset(
                bottomIcons[2],
                color: selectedScreen == 2 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedScreen = 3;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor:
                  selectedScreen == 3 ? Color(0xff0066FF) : Colors.transparent,
              radius: 22,
              child: SvgPicture.asset(
                bottomIcons[3],
                color: selectedScreen == 3 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          )
        ],
      ),
    );
  }
}
