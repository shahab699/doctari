// import 'dart:async';
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen/onboarding_screen.dart';
// import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
// import 'package:doctari/Provider/user_id_provider.dart';
// import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
// //>>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_one_screen/onboarding_screen_one_screen.dart';
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: ((context) => OnboardingScreen())));
//       // Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //         builder: ((context) => OnboardingScreenOneScreen())));

//       checkUserSession();

//     });
//   }

//   void checkUserSession() {
//     String? userId = SessionManager.getUserId();
//     String? userType = SessionManager.getUserType();
//     String? userToken = SessionManager.getUserToken();
// print("user Id SP: $userId");
// print("user Type SP: $userId");
// print("user Id SP: $userId");
//     if (userId != null && userType != null && userToken != null) {
//       // Provider.of<ProviderForStoringValues>(context, listen: false)
//       //     .setDoctorId(int.parse(userId));
//       // Provider.of<ProviderForStoringValues>(context, listen: false)
//       //     .setAccessToken(userToken);

//       // int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
//       // String? patientAccessToken =
//       //     Provider.of<ProviderForStoringValues>(context).accessToken;

//       print("patient Id is:${int.parse(userId)}");
//       print("patient token is:$userToken");

//       if (userType.contains('patient')) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => PatientBottomNavigation()),
//         );
//       } else if (userType.contains('doctor')) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => DoctorBottomNavigation()),
//         );
//       } else {
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => OnboardingScreenOneScreen()),
//         // );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => OnboardingScreen()),
//         );
//       }
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => OnboardingScreen()),
//       );
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => OnboardingScreenOneScreen()),
//       // );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           width: 375.h,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomImageView(
//                 imagePath: ImageConstant.imgDoctariIcon41,
//                 height: 130.v,
//                 width: 130.h,
//               ),
//               SizedBox(height: 19.v),
//               Text(
//                 "${AppLocalizations.of(context)!.doctariSplashScreenSC}",
//                 style: TextStyle(
//                     color: appTheme.indigo90001,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//add code to skip onboarding screen
import 'dart:async';
import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen/onboarding_screen.dart';
import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_one_screen/onboarding_screen_one_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2)); // Splash screen duration
    checkUserSession();
  }

  void checkUserSession() {
    String? userId = SessionManager.getUserId();
    String? userType = SessionManager.getUserType();
    String? userToken = SessionManager.getUserToken();

    if (userId != null && userType != null && userToken != null) {
      // User is logged in
      if (userType.contains('patient')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientBottomNavigation()),
        );
      } else if (userType.contains('doctor')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorBottomNavigation()),
        );
      }
    } else {
      // User is not logged in, show onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 375.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgDoctariIcon41,
                height: 130.v,
                width: 130.h,
              ),
              SizedBox(height: 19.v),
              Text(
                "${AppLocalizations.of(context)!.doctariSplashScreenSC}",
                style: TextStyle(
                    color: appTheme.indigo90001,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_one_screen/onboarding_screen_one_screen.dart';
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: ((context) => OnboardingScreenOneScreen())));
//     });
//   }

//   void checkUserSession() {
//     String? userId = SessionManager.getUserId();
//     String? userType = SessionManager.getUserType();

//     if (userId != null && userType != null) {
//       print('User ID: $userId');
//       print('User Type: $userType');
//     } else {
//       print('No user session found');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           width: 375.h,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomImageView(
//                 imagePath: ImageConstant.imgDoctariIcon41,
//                 height: 130.v,
//                 width: 130.h,
//               ),
//               SizedBox(height: 19.v),
//               Text(
//                 "Doctari",
//                 style: TextStyle(
//                     color: appTheme.indigo90001,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
