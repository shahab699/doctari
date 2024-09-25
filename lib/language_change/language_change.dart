import 'package:doctari/controller/language_change_controller.dart';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientFlow/dashBoard/dashboard_one_screen/dashboard_one_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageChangeScreen extends StatefulWidget {
  const LanguageChangeScreen({Key? key}) : super(key: key);

  @override
  State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
}

class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
  late String selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize selected language based on current locale
    final locale = Localizations.localeOf(context);
    selectedLanguage = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    int usersId = int.parse(userId!);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          '${AppLocalizations.of(context)!.languageChangeSC}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(child: Consumer<LanguageChangeController>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(
              //   'Select Language',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 20),
              ListTile(
                title: Text('${AppLocalizations.of(context)!.spanish}'),
                leading: Radio<String>(
                  value: 'es',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'es';
                  });
                },
              ),
              ListTile(
                title: Text('${AppLocalizations.of(context)!.english}'),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'en';
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    // Apply the selected language
                    if (selectedLanguage == 'es') {
                      provider.changeLanguage(Locale('es'));
                    } else {
                      provider.changeLanguage(Locale('en'));
                    }

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context)!.save}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )

          // child: Consumer<LanguageChangeController>(
          //   builder: (context, provider, child) {
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         // Text(
          //         //   'Select Language',
          //         //   style: TextStyle(
          //         //       color: Colors.black,
          //         //       fontSize: 16,
          //         //       fontWeight: FontWeight.bold),
          //         // ),
          //         SizedBox(height: 20),
          //         ListTile(
          //           title: Text('Spanish'),
          //           leading: Radio<String>(
          //             value: 'es',
          //             groupValue: selectedLanguage,
          //             onChanged: (value) {
          //               setState(() {
          //                 selectedLanguage = value!;
          //               });
          //             },
          //           ),
          //         ),
          //         ListTile(
          //           title: Text('English'),
          //           leading: Radio<String>(
          //             value: 'en',
          //             groupValue: selectedLanguage,
          //             onChanged: (value) {
          //               setState(() {
          //                 selectedLanguage = value!;
          //               });
          //             },
          //           ),
          //         ),
          //         SizedBox(height: 20),
          //         Container(
          //           height: 50,
          //           width: 120,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               // Apply the selected language
          //               if (selectedLanguage == 'es') {
          //                 provider.changeLanguage(Locale('es'));
          //               } else {
          //                 provider.changeLanguage(Locale('en'));
          //               }
          //               Navigator.pop(context);
          //             },
          //             child: Text(
          //               'Save',
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white),
          //             ),
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: theme.primaryColor,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          ),
    );
  }
}


// import 'package:doctari/controller/language_change_controller.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class LanguageChangeScreen extends StatefulWidget {
//   const LanguageChangeScreen({Key? key}) : super(key: key);

//   @override
//   State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
// }

// class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         title: Text(
//           '${AppLocalizations.of(context)!.languageChangeSC}',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: theme.primaryColor,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SafeArea(
//         child: Consumer<LanguageChangeController>(
//           builder: (context, provider, child) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Select Language',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 50,
//                             width: 120,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 provider.changeLanguage(Locale('es'));
//                               },
//                               child: Text(
//                                 'Spanish',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: theme.primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Container(
//                             height: 50,
//                             width: 120,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 provider.changeLanguage(Locale('en'));
//                               },
//                               child: Text(
//                                 'English',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: theme.primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




// import 'package:doctari/controller/language_change_controller.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class LanguageChangeScreen extends StatefulWidget {
//   const LanguageChangeScreen({Key? key}) : super(key: key);

//   @override
//   State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
// }

// class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         title: Text(
//           '${AppLocalizations.of(context)!.languageChangeSC}',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: theme.primaryColor,
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           Consumer<LanguageChangeController>(
//             builder: (context, provider, child) {
//               return PopupMenuButton<Locale>(
//                 onSelected: (Locale locale) {
//                   provider.changeLanguage(locale);
//                 },
//                 itemBuilder: (BuildContext context) => [
//                   PopupMenuItem<Locale>(
//                     value: Locale('es'),
//                     child:
//                         Text('Spanish', style: TextStyle(color: Colors.black)),
//                   ),
//                   PopupMenuItem<Locale>(
//                     value: Locale('en'),
//                     child:
//                         Text('English', style: TextStyle(color: Colors.black)),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Consumer<LanguageChangeController>(
//           builder: (context, provider, child) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Container(
//                       height: height * 0.06,
//                       width: width * 0.7,
//                       decoration: BoxDecoration(
//                         color: theme.primaryColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(
//                           provider.currentLanguageName,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }







// import 'package:doctari/controller/language_change_controller.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:doctari/patientFlow/dashBoard/dashboard_one_screen/dashboard_one_screen.dart';
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen/onboarding_screen.dart';
// import 'package:doctari/patientFlow/patientMenu/PatientDrawer/MainDrawerScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LanguageChangeScreen extends StatefulWidget {
//   const LanguageChangeScreen({Key? key}) : super(key: key);

//   @override
//   State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
// }

// class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width * 1;
//     final height = MediaQuery.of(context).size.height * 1;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         title: Text(
//           'Language Change',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: theme.primaryColor,
//         iconTheme:
//             IconThemeData(color: Colors.white), // Sets icon color to white
//         actions: [
//           Consumer<LanguageChangeController>(
//             builder: (context, provider, child) {
//               return PopupMenuButton<Language>(
//                 onSelected: (Language item) {
//                   // ignore: sdk_version_since
//                   if (Language.english.name == item.name) {
//                     provider.changeLanguage(Locale('es'));
//                   } else {
//                     provider.changeLanguage(Locale('en'));
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => [
//                   PopupMenuItem<Language>(
//                     value: Language.english,
//                     child: Text('Spanish',
//                         style: TextStyle(
//                             color: Colors.black)), // Set text color if needed
//                   ),
//                   PopupMenuItem<Language>(
//                     value: Language.spanish,
//                     child: Text('English',
//                         style: TextStyle(
//                             color: Colors.black)), // Set text color if needed
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.7,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                     child: Text(
//                   "Home Screen",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 )),
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
