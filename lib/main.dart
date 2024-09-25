import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/SubBottomNavigationScreens/DoctorsChatScreens.dart';
import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/SubBottomNavigationScreens/DoctorsDashboard.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/controller/language_change_controller.dart';
import 'package:doctari/core/utils/constantid.dart';
import 'package:doctari/firebase_options.dart';
import 'package:doctari/l10n/l10n.dart';
import 'package:doctari/local_storage_services/shared_preferences.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/chatbox_one_screen/chatbox_one_screen.dart';
import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
import 'package:doctari/patientFlow/onboarding_screens/splash_screen/splash_screen.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/presentation/chat_one_screen/chat_one_screen.dart';
import 'package:doctari/presentation/chatbox_screen/chatbox_screen.dart';
import 'package:doctari/presentation/patient_login_screen/patient_login_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zego_zim/zego_zim.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   /// 1.1.1 define a navigator key
// final navigatorKey = GlobalKey();

//   /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
//   ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

//   // call the useSystemCallingUI
//   ZegoUIKit().initLog().then((value) {
//     ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
//       [ZegoUIKitSignalingPlugin()],
//     );
//   });

//   ThemeHelper().changeTheme('primary');
//   runApp(ChangeNotifierProvider(
//       create: (context) => ProviderForStoringValues(), child: MyApp(navigatorKey: navigatorKey)));
// }

// class MyApp extends StatefulWidget {
//    final GlobalKey navigatorKey;

//   const MyApp({
//     required this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//             navigatorKey: widget.navigatorKey,
//           theme: theme,
//           title: 'Doctari',
//           debugShowCheckedModeBanner: false,
//           home: SplashScreen(),
//         );
//       },
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Initialize shared preferences and get the initial locale
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   String? languageCode = sp.getString('Language_code');
//   Locale initialLocale = languageCode != null ? Locale(languageCode) : Locale('es');

//   // Initialize Hive
//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDir.path);

//   // Open necessary Hive boxes
//   await Hive.openBox('sessionBox');
//   await Hive.openBox('settingsBox');

//   // Set preferred orientation
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   // Define a navigator key
//   final navigatorKey = GlobalKey<NavigatorState>();

//   // Set navigator key to ZegoUIKitPrebuiltCallInvitationService
//   ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

//   // Call the useSystemCallingUI
//   ZegoUIKit().initLog().then((value) {
//     ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
//       [ZegoUIKitSignalingPlugin()],
//     );
//   });

//   // Change theme
//   ThemeHelper().changeTheme('primary');

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProviderForStoringValues()),
//         ChangeNotifierProvider(
//           create: (_) => LanguageChangeController()..changeLanguage(initialLocale),
//         ),
//       ],
//       child: MyApp(
//         navigatorKey: navigatorKey,
//       ),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final GlobalKey<NavigatorState>? navigatorKey;

//   const MyApp({
//     this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return Consumer<LanguageChangeController>(
//           builder: (context, provider, child) {
//             return MaterialApp(
//               navigatorKey: widget.navigatorKey,
//               theme: theme, // Ensure that `currentTheme` returns the correct ThemeData
//               title: 'Doctari',
//               supportedLocales: L10n.all,
//               locale: provider.appLocale ?? Locale('en'),
//               localizationsDelegates: [
//                 AppLocalizations.delegate,
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//               ],
//               debugShowCheckedModeBanner: false,
//               home: SplashScreen(),
//             );
//           },
//         );
//       },
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize shared preferences
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? languageCode = sp.getString('Language_code');
  Locale initialLocale =
      languageCode != null ? Locale(languageCode) : Locale('es');

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  // Initialize Zego UI Kit
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService()
        .useSystemCallingUI([ZegoUIKitSignalingPlugin()]);
  });

  // Set theme
  ThemeHelper().changeTheme('primary');

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox('sessionBox');
  await Hive.openBox('settingsBox');

  ZIMKit().init(
    appID: Constant.appId, // your appid
    appSign: Constant.appsign, // your appSign
  );

  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderForStoringValues()),
        ChangeNotifierProvider(
          create: (_) =>
              LanguageChangeController()..changeLanguage(initialLocale),
        ),
      ],
      child: MyApp(navigatorKey: navigatorKey),
    ),
  );
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const MyApp({
    this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<LanguageChangeController>(
          builder: (context, provider, child) {
            return MaterialApp(
              navigatorKey: widget.navigatorKey,
              theme: theme,
              title: 'Doctari',
              supportedLocales: L10n.all,
              locale: provider.appLocale ?? Locale('en'),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}

//last code12/08
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await Prefs.init();

//   SharedPreferences sp = await SharedPreferences.getInstance();
//   String? languageCode = sp.getString('Language_code');
//   Locale initialLocale =
//       languageCode != null ? Locale(languageCode) : Locale('es');

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   // Define a navigator key
//   final navigatorKey = GlobalKey<NavigatorState>();

//   // Set navigator key to ZegoUIKitPrebuiltCallInvitationService
//   ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

//   // Call the useSystemCallingUI
//   ZegoUIKit().initLog().then((value) {
//     ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
//       [ZegoUIKitSignalingPlugin()],
//     );
//   });

//   ThemeHelper().changeTheme('primary');
//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDir.path);

//   await Hive.openBox('sessionBox');
//   await Hive.initFlutter();
//   await Hive.openBox('settingsBox');
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProviderForStoringValues()),
//         ChangeNotifierProvider(
//           create: (_) =>
//               LanguageChangeController()..changeLanguage(initialLocale),
//         ),
//       ],
//       child: MyApp(
//         navigatorKey: navigatorKey,
//       ),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final GlobalKey<NavigatorState>? navigatorKey;

//   const MyApp({
//     this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return Consumer<LanguageChangeController>(
//           builder: (context, provider, child) {
//             return MaterialApp(
//               navigatorKey: widget.navigatorKey,
//               theme: theme,
//               title: 'Doctari',
//               supportedLocales: L10n.all,
//               locale: provider.appLocale ?? Locale('en'),
//               localizationsDelegates: [
//                 AppLocalizations.delegate,
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//               ],
//               debugShowCheckedModeBanner: false,
//               home: SplashScreen(),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   final String languageCode = sp.getString('Language_code') ?? '';
//   print('Language code $languageCode');
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   // Define a navigator key
//   final navigatorKey = GlobalKey<NavigatorState>();

//   // Set navigator key to ZegoUIKitPrebuiltCallInvitationService
//   ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

//   // Call the useSystemCallingUI
//   ZegoUIKit().initLog().then((value) {
//     ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
//       [ZegoUIKitSignalingPlugin()],
//     );
//   });

//   ThemeHelper().changeTheme('primary');
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ProviderForStoringValues(),
//       child: MyApp(
//         navigatorKey: navigatorKey,
//         locale: languageCode,
//       ),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final String? locale;
//   final GlobalKey<NavigatorState>? navigatorKey;

//   const MyApp({
//     this.navigatorKey,
//     this.locale,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//             providers: [
//               ChangeNotifierProvider(create: (_) => LanguageChangeController()),
//             ],
//             child: Consumer<LanguageChangeController>(
//               builder: (context, provider, child) {
//                 // if (widget.locale!.isEmpty) {
//                 //   provider.changeLanguage(Locale('en'));
//                 // }
//                 print('Provider AppLocale: ${provider.appLocale}');

//                 return MaterialApp(
//                   navigatorKey: widget.navigatorKey,
//                   theme: theme,
//                   title: 'Doctari',
//                   supportedLocales: L10n.all,
//                   // locale: provider.appLocale,
//                   locale: widget.locale!.isEmpty
//                       ? Locale('en')
//                       : provider.appLocale == null
//                           ? Locale('en')
//                           : provider.appLocale,
//                   localizationsDelegates: [
//                     AppLocalizations.delegate,
//                     GlobalMaterialLocalizations.delegate,
//                     GlobalWidgetsLocalizations.delegate,
//                     GlobalCupertinoLocalizations.delegate,
//                   ],
//                   debugShowCheckedModeBanner: false,
//                   home: SplashScreen(),
//                 );
//               },
//             ));
//       },
//     );
//   }
// }
