import 'package:doctari/DoctorsScreens/completed_appointments_page/completed_appointments_page.dart';
import 'package:doctari/DoctorsScreens/upcoming_appointments_for_doc_page/upcoming_appointments_for_doc_page.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDoctorShedular extends StatefulWidget {
  const MainDoctorShedular();

  @override
  State<MainDoctorShedular> createState() => _MainDoctorShedularState();
}

class _MainDoctorShedularState extends State<MainDoctorShedular> {
  int selectedIndex = 0;

  // List<Widget> screensList = [
  //   UpcomingAppointmentsForDocPage(
  //     doctId: doctorId,
  //   ),
  //   CompletedAppointmentsPage()
  // ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // int? doctorId = Provider.of<ProviderForStoringValues>(context).doctorId;
    // String? Token = Provider.of<ProviderForStoringValues>(context).accessToken;
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    List<Widget> screensList = [
      UpcomingAppointmentsForDocPage(
        doctId: int.parse(userId!),
        token: userToken!,
      ),
      CompletedAppointmentsPage(
        doctorId: int.parse(userId),
        token: userToken!,
      )
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "${AppLocalizations.of(context)!.appointmentsDoctorMenuScreenSC}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.grey.shade100,
      //   surfaceTintColor: Colors.white,
      //   centerTitle: true,
      //   title: Text(
      //     "${AppLocalizations.of(context)!.appointmentsMainDocShedularSC}",
      //     style: TextStyle(
      //         fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SizedBox(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        child: Column(
          children: [
            buildCustomTabBars(context),
            Divider(
              color: Colors.grey.shade300,
            ),
            Expanded(
                child: SwipeDetector(
                    onSwipeRight: (offset) {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    onSwipeLeft: (offset) {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: screensList[selectedIndex]))
          ],
        ),
      ),
    );
  }

  buildCustomTabBars(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${AppLocalizations.of(context)!.upcomingMainDocShedularSC}",
                  style: TextStyle(
                      fontSize: 15,
                      color: selectedIndex == 0
                          ? Color(0xff0066FF)
                          : Color(0xff9CA3AF),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? Color(0xff0066FF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${AppLocalizations.of(context)!.completedMainDocShedularSC}",
                  style: TextStyle(
                      fontSize: 15,
                      color: selectedIndex == 1
                          ? Color(0xff0066FF)
                          : Color(0xff9CA3AF),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? Color(0xff0066FF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
