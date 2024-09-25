// import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_three_screen/onboarding_screen_three_screen.dart';
// import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class OnboardingScreenTwoScreen extends StatelessWidget {
//   const OnboardingScreenTwoScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           // width: 375.h,
//           child: Column(
//             children: [
//               _buildImage(context),
//               SizedBox(height: 34.v),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 35),
//                 child: Text(
//                   "${AppLocalizations.of(context)!.findSpecialistOnboardingScreenTwoSC}!",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: theme.textTheme.headlineMedium,
//                 ),
//               ),
//               SizedBox(height: 17.v),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 35),
//                 child: Text(
//                   "${AppLocalizations.of(context)!.loremIpsumOnboardingScreenTwoSC}.",
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
//                     "${AppLocalizations.of(context)!.getStartedOnboardingScreenTwoSC}",
//                 onPressed: () {
//                   // Navigator.pushReplacementNamed(
//                   //     context, AppRoutes.onboardingScreenThreeScreen);
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) =>
//                               OnboardingScreenThreeScreen())));
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
//                 child: Text(
//                   "${AppLocalizations.of(context)!.skipOnboardingScreenTwoSC}",
//                   style: CustomTextStyles.bodyMediumBluegray50014_1,
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
//       alignment: Alignment.topRight,
//       child: SizedBox(
//         height: 400.v,
//         width: 355.h,
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             CustomImageView(
//               imagePath: ImageConstant.imgEllipse153295x200,
//               height: 295.v,
//               width: 238.h,
//               alignment: Alignment.topRight,
//             ),
//             CustomImageView(
//               imagePath: ImageConstant.imgEllipse154336x336,
//               height: 336.adaptSize,
//               width: 336.adaptSize,
//               radius: BorderRadius.circular(
//                 168.h,
//               ),
//               alignment: Alignment.bottomLeft,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
