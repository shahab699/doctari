// import 'package:doctari/controller/language_change_controller.dart';
// import 'package:doctari/l10n/l10n.dart';
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_three_screen/onboarding_screen_three_screen.dart';
// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_two_screen/onboarding_screen_two_screen.dart';
// import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:provider/provider.dart';

// enum Language { english, spanish }

// class OnboardingScreenOneScreen extends StatelessWidget {
//   const OnboardingScreenOneScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('${AppLocalizations.of(context)!.helloWorld}'),
//           actions: [
//             Consumer<LanguageChangeController>(
//                 builder: (context, provider, child) {
//               return PopupMenuButton(
//                   onSelected: (Language item) {
//                     if (Language.english.name == item.name) {
//                       provider.changeLanguage(Locale('en'));
//                     } else {
//                       print(Language.spanish);
//                       provider.changeLanguage(Locale('es'));
//                     }
//                   },
//                   itemBuilder: (BuildContext context) =>
//                       <PopupMenuEntry<Language>>[
//                         const PopupMenuItem(
//                             value: Language.english, child: Text('English')),
//                         const PopupMenuItem(
//                             value: Language.spanish, child: Text('Spanish')),
//                       ]);
//             })
//           ],
//         ),
//         body: SizedBox(
//           // width: 375.h,
//           child: Column(
//             children: [
//               // Text(context.Localizations.language),
//               // Text(context.Localizations.helloWorld),
//               // ElevatedButton(onPressed: () {}, child: Text('he')),
//               //////////add here language change
//               //          Center(
//               //   child: Column(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: <Widget>[
//               //       Text(localizedStrings.message), // Another example
//               //       SizedBox(height: 20),
//               //       DropdownButton<Locale>(
//               //         value: Localizations.localeOf(context),
//               //         onChanged: (Locale? newValue) {
//               //           if (newValue != null) {
//               //             changeLanguage!(newValue); // Call changeLanguage method
//               //           }
//               //         },
//               //         items: [
//               //           DropdownMenuItem(
//               //             value: const Locale('en', ''),
//               //             child: Text('English'),
//               //           ),
//               //           DropdownMenuItem(
//               //             value: const Locale('es', ''),
//               //             child: Text('Español'),
//               //           ),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               ///////////////////////////////////
//               _buildImage(context),
//               SizedBox(height: 83.v),
//               Center(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "${AppLocalizations.of(context)!.findTrustedDocOnboardingScreenOneSC}",
//                         textAlign: TextAlign.center,
//                         style: theme.textTheme.headlineMedium,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.v),
//               Container(
//                 width: 275.h,
//                 margin: EdgeInsets.only(
//                   left: 50.h,
//                   right: 49.h,
//                 ),
//                 child: Text(
//                   "${AppLocalizations.of(context)!.loremIpsumOnboardingScreenOneSC}.",
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
//                     height: 1.66,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 48.v),
//               CustomElevatedButton(
//                 text:
//                     "${AppLocalizations.of(context)!.getStartedOnboardingScreenOneSC}",
//                 onPressed: () {
//                   print("on the first onbarding screen");
//                   // Navigator.pushReplacementNamed(
//                   //     context, AppRoutes.onboardingScreenTwoScreen);
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) => OnboardingScreenTwoScreen())));
//                 },
//                 margin: EdgeInsets.symmetric(horizontal: 40.h),
//                 buttonStyle: CustomButtonStyles.fillPrimary,
//                 buttonTextStyle:
//                     CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
//               ),
//               SizedBox(height: 16.v),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) => RegisterAsScreen())));
//                 },
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 164.h),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.skipOnboardingScreenOneSC}",
//                       style: CustomTextStyles.bodyMediumBluegray50014_1,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildImage(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: SizedBox(
//         height: 400.v,
//         width: 356.h,
//         child: Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             CustomImageView(
//               imagePath: ImageConstant.imgEllipse153,
//               height: 295.v,
//               width: 238.h,
//               alignment: Alignment.topLeft,
//             ),
//             CustomImageView(
//               imagePath: ImageConstant.imgEllipse154,
//               height: 336.adaptSize,
//               width: 336.adaptSize,
//               radius: BorderRadius.circular(
//                 168.h,
//               ),
//               alignment: Alignment.bottomRight,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class OnboardingScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final List<Widget> onboardingScreens = [
// //       OnboardingScreenOneScreen(context),
// //       OnboardingScreenTwoScreen(context),
// //       OnboardingScreenThreeScreen(context),
// //     ];

// //     return Scaffold(
// //       body: CarouselSlider(
// //         options: CarouselOptions(
// //           height: 400.0,
// //           enlargeCenterPage: true,
// //           autoPlay: true,
// //           aspectRatio: 16 / 9,
// //           autoPlayCurve: Curves.fastOutSlowIn,
// //           enableInfiniteScroll: true,
// //           autoPlayAnimationDuration: Duration(milliseconds: 800),
// //           viewportFraction: 0.8,
// //         ),
// //         items: onboardingScreens.map((screen) {
// //           return Builder(
// //             builder: (BuildContext context) {
// //               return Container(
// //                 width: MediaQuery.of(context).size.width,
// //                 margin: EdgeInsets.symmetric(horizontal: 5.0),
// //                 child: screen,
// //               );
// //             },
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }

// //   Widget OnboardingScreenOneScreen(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: SizedBox(
// //           // width: 375.h,
// //           child: Column(
// //             children: [
// //               _buildImage(context),
// //               SizedBox(height: 83.v),
// //               Center(
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         "${AppLocalizations.of(context)!.findTrustedDocOnboardingScreenOneSC}",
// //                         textAlign: TextAlign.center,
// //                         style: theme.textTheme.headlineMedium,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: 8.v),
// //               Container(
// //                 width: 275.h,
// //                 margin: EdgeInsets.only(
// //                   left: 50.h,
// //                   right: 49.h,
// //                 ),
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.loremIpsumOnboardingScreenOneSC}.",
// //                   maxLines: 3,
// //                   overflow: TextOverflow.ellipsis,
// //                   textAlign: TextAlign.center,
// //                   style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
// //                     height: 1.66,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 48.v),
// //               CustomElevatedButton(
// //                 text:
// //                     "${AppLocalizations.of(context)!.getStartedOnboardingScreenOneSC}",
// //                 onPressed: () {
// //                   print("on the first onbarding screen");
// //                   // Navigator.pushReplacementNamed(
// //                   //     context, AppRoutes.onboardingScreenTwoScreen);
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) =>
// //                               OnboardingScreenTwoScreen(context))));
// //                 },
// //                 margin: EdgeInsets.symmetric(horizontal: 40.h),
// //                 buttonStyle: CustomButtonStyles.fillPrimary,
// //                 buttonTextStyle:
// //                     CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
// //               ),
// //               SizedBox(height: 16.v),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) => RegisterAsScreen())));
// //                 },
// //                 child: Align(
// //                   alignment: Alignment.centerRight,
// //                   child: Padding(
// //                     padding: EdgeInsets.only(right: 164.h),
// //                     child: Text(
// //                       "${AppLocalizations.of(context)!.skipOnboardingScreenOneSC}",
// //                       style: CustomTextStyles.bodyMediumBluegray50014_1,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 5.v),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildImage(BuildContext context) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: SizedBox(
// //         height: 400.v,
// //         width: 356.h,
// //         child: Stack(
// //           alignment: Alignment.bottomRight,
// //           children: [
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse153,
// //               height: 295.v,
// //               width: 238.h,
// //               alignment: Alignment.topLeft,
// //             ),
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse154,
// //               height: 336.adaptSize,
// //               width: 336.adaptSize,
// //               radius: BorderRadius.circular(
// //                 168.h,
// //               ),
// //               alignment: Alignment.bottomRight,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Widget onboardingScreen1() {
// //   //   return Container(
// //   //     color: Colors.red,
// //   //     child: Center(
// //   //       child: Text(
// //   //         'Welcome to App 1',
// //   //         style: TextStyle(fontSize: 24, color: Colors.white),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //   Widget OnboardingScreenTwoScreen(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: SizedBox(
// //           // width: 375.h,
// //           child: Column(
// //             children: [
// //               _buildImageTwo(context),
// //               SizedBox(height: 34.v),
// //               Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 35),
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.findSpecialistOnboardingScreenTwoSC}!",
// //                   maxLines: 2,
// //                   overflow: TextOverflow.ellipsis,
// //                   textAlign: TextAlign.center,
// //                   style: theme.textTheme.headlineMedium,
// //                 ),
// //               ),
// //               SizedBox(height: 17.v),
// //               Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 35),
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.loremIpsumOnboardingScreenTwoSC}.",
// //                   maxLines: 3,
// //                   overflow: TextOverflow.ellipsis,
// //                   textAlign: TextAlign.center,
// //                   style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
// //                     height: 1.66,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 48.v),
// //               CustomElevatedButton(
// //                 text:
// //                     "${AppLocalizations.of(context)!.getStartedOnboardingScreenTwoSC}",
// //                 onPressed: () {
// //                   // Navigator.pushReplacementNamed(
// //                   //     context, AppRoutes.onboardingScreenThreeScreen);
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) =>
// //                               OnboardingScreenThreeScreen(context))));
// //                 },
// //                 margin: EdgeInsets.symmetric(horizontal: 40.h),
// //                 buttonStyle: CustomButtonStyles.fillPrimary,
// //                 buttonTextStyle:
// //                     CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
// //               ),
// //               SizedBox(height: 16.v),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) => RegisterAsScreen())));
// //                 },
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.skipOnboardingScreenTwoSC}",
// //                   style: CustomTextStyles.bodyMediumBluegray50014_1,
// //                 ),
// //               ),
// //               SizedBox(height: 5.v),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// Section Widget
// //   Widget _buildImageTwo(BuildContext context) {
// //     return Align(
// //       alignment: Alignment.topRight,
// //       child: SizedBox(
// //         height: 400.v,
// //         width: 355.h,
// //         child: Stack(
// //           alignment: Alignment.bottomLeft,
// //           children: [
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse153295x200,
// //               height: 295.v,
// //               width: 238.h,
// //               alignment: Alignment.topRight,
// //             ),
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse154336x336,
// //               height: 336.adaptSize,
// //               width: 336.adaptSize,
// //               radius: BorderRadius.circular(
// //                 168.h,
// //               ),
// //               alignment: Alignment.bottomLeft,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Widget onboardingScreen2() {
// //   //   return Container(
// //   //     color: Colors.green,
// //   //     child: Center(
// //   //       child: Text(
// //   //         'Welcome to App 2',
// //   //         style: TextStyle(fontSize: 24, color: Colors.white),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //   Widget OnboardingScreenThreeScreen(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: SizedBox(
// //           // width: 375.h,
// //           child: Column(
// //             children: [
// //               _buildImageThree(context),
// //               SizedBox(height: 92.v),
// //               Text(
// //                 "${AppLocalizations.of(context)!.easyAppointmentsOnboardingScreenThreeSC}",
// //                 style: theme.textTheme.headlineMedium,
// //               ),
// //               Container(
// //                 width: 275.h,
// //                 margin: EdgeInsets.only(
// //                   left: 52.h,
// //                   right: 47.h,
// //                 ),
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.loremIpsumOnboardingScreenThreeSC}.",
// //                   maxLines: 3,
// //                   overflow: TextOverflow.ellipsis,
// //                   textAlign: TextAlign.center,
// //                   style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
// //                     height: 1.66,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 48.v),
// //               CustomElevatedButton(
// //                 text:
// //                     "${AppLocalizations.of(context)!.getStartedOnboardingScreenThreeSC}",
// //                 onPressed: () {
// //                   // Navigator.pushReplacementNamed(
// //                   //     context, AppRoutes.registerAsScreen);
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) => RegisterAsScreen())));
// //                 },
// //                 margin: EdgeInsets.symmetric(horizontal: 40.h),
// //                 buttonStyle: CustomButtonStyles.fillPrimary,
// //                 buttonTextStyle:
// //                     CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
// //               ),
// //               SizedBox(height: 16.v),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: ((context) => RegisterAsScreen())));
// //                 },
// //                 child: Text(
// //                   "${AppLocalizations.of(context)!.skipOnboardingScreenThreeSC}",
// //                   style: CustomTextStyles.bodyMediumBluegray50014_1,
// //                 ),
// //               ),
// //               SizedBox(height: 5.v),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// Section Widget
// //   Widget _buildImageThree(BuildContext context) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: SizedBox(
// //         height: 400.v,
// //         width: 356.h,
// //         child: Stack(
// //           alignment: Alignment.bottomRight,
// //           children: [
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse153295x238,
// //               height: 295.v,
// //               width: 238.h,
// //               alignment: Alignment.topLeft,
// //             ),
// //             CustomImageView(
// //               imagePath: ImageConstant.imgEllipse1541,
// //               height: 336.adaptSize,
// //               width: 336.adaptSize,
// //               radius: BorderRadius.circular(
// //                 168.h,
// //               ),
// //               alignment: Alignment.bottomRight,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //   // Widget onboardingScreen3() {
// //   //   return Container(
// //   //     color: Colors.blue,
// //   //     child: Center(
// //   //       child: Text(
// //   //         'Welcome to App 3',
// //   //         style: TextStyle(fontSize: 24, color: Colors.white),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// // }
