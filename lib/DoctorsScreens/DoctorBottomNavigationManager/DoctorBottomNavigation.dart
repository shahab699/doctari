import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/SubBottomNavigationScreens/DoctorsDashboard.dart';
import 'package:doctari/chat/conversation_list.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Appointments&ShedulerForDoctor/MainDoctorShedular.dart';

class DoctorBottomNavigation extends StatefulWidget {
  const DoctorBottomNavigation();

  @override
  State<DoctorBottomNavigation> createState() => _DoctorBottomNavigationState();
}

class _DoctorBottomNavigationState extends State<DoctorBottomNavigation> {
  // List<Widget> screens = [
  //   DoctorsDashBoard(),
  //   MainDoctorShedular(),
  //   ConversationListPage(),
  // ];

  List<String> bottomIcons = [
    "assets/myassets/bottom1.svg",
    "assets/myassets/bottom3.svg",
    "assets/myassets/bottom4.svg",
  ];

  int selectedScreens = 0;

  @override
  Widget build(BuildContext context) {
    // int? doctorId = Provider.of<ProviderForStoringValues>(context).doctorId;
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    List<Widget> screens = [
      DoctorsDashBoard(
        userId: userId!,
        userToken: userToken!,
      ),
      MainDoctorShedular(),
      ConversationListPage(
        currentUserId: int.parse(userId!),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: screens[selectedScreens],
      bottomNavigationBar: BuildBottomNavigationBar(),
    );
  }

  BuildBottomNavigationBar() {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              selectedScreens = 0;
              setState(() {});
            },
            child: CircleAvatar(
              radius: 23,
              backgroundColor:
                  selectedScreens == 0 ? Color(0xff0066FF) : Colors.transparent,
              child: SvgPicture.asset(
                bottomIcons[0],
                color: selectedScreens == 0 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedScreens = 1;
              setState(() {});
            },
            child: CircleAvatar(
              radius: 23,
              backgroundColor:
                  selectedScreens == 1 ? Color(0xff0066FF) : Colors.transparent,
              child: SvgPicture.asset(
                bottomIcons[1],
                color: selectedScreens == 1 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedScreens = 2;
              setState(() {});
            },
            child: CircleAvatar(
              radius: 23,
              backgroundColor:
                  selectedScreens == 2 ? Color(0xff0066FF) : Colors.transparent,
              child: SvgPicture.asset(
                bottomIcons[2],
                color: selectedScreens == 2 ? Colors.white : Color(0xff858EA9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
