import 'package:doctari/controller/language_change_controller.dart';
import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_one_screen/onboarding_screen_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_three_screen/onboarding_screen_three_screen.dart';
import 'package:doctari/patientFlow/onboarding_screens/onboarding_screen_two_screen/onboarding_screen_two_screen.dart';
import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

enum Language { english, spanish }

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingScreens = [
      OnboardingScreenbuildone(context),
      // onboardingScreen1(),
      OnboardingScreenbuildtwo(context),
      // onboardingScreen2(),
      OnboardingScreenbuildthree(context),
      // onboardingScreen3(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: onboardingScreens,
            ),
          ),
          
        ],
      ),
    );
  }

/////////Onboarding Screen One Start

  Widget OnboardingScreenbuildone(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text('${AppLocalizations.of(context)!.helloWorld}'),
          actions: [
            Consumer<LanguageChangeController>(
                builder: (context, provider, child) {
              return PopupMenuButton(
                  onSelected: (Language item) {
                    // ignore: sdk_version_since
                    if (Language.english.name == item.name) {
                      provider.changeLanguage(Locale(('es')));
                    } else {
                      provider.changeLanguage(Locale(('en')));
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                        const PopupMenuItem(
                            value: Language.english, child: Text('Spanish')),
                        const PopupMenuItem(
                            value: Language.spanish, child: Text('English')),
                      ]);
            })
          ],
        ),
        body: SizedBox(
          // width: 375.h,
          child: Column(
            children: [
              _buildImage1(context),
              SizedBox(height: 83.v),
              // SizedBox(height: 60.v),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${AppLocalizations.of(context)!.bestProfessionalsOnboardingScreenOneSC}",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              // SizedBox(height: 6.v),
              Container(
                width: 275.h,
                margin: EdgeInsets.only(
                  left: 50.h,
                  right: 49.h,
                ),
                child: Text(
                  "${AppLocalizations.of(context)!.doctariFindProfessionalOnboardingScreenOneSC}.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
                    height: 1.66,
                  ),
                ),
              ),
              
              SizedBox(height: 5.v),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2].map((index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: _currentPage == index ? 20.0 : 10.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImage1(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 400.v,
        width: 356.h,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse153,
              height: 295.v,
              width: 238.h,
              alignment: Alignment.topLeft,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse154,
              height: 336.adaptSize,
              width: 336.adaptSize,
              radius: BorderRadius.circular(
                168.h,
              ),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ),
    );
  }
  /////////Onboarding Screen One End

  /////////Onboarding Screen Two Start
  Widget OnboardingScreenbuildtwo(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // width: 375.h,
          child: Column(
            children: [
              _buildImage2(context),
              SizedBox(height: 34.v),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  "${AppLocalizations.of(context)!.specialistsWhereWhenOnboardingScreenTwoSC}!",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 17.v),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  "${AppLocalizations.of(context)!.doctariGivesAccessOnboardingScreenTwoSC}.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
                    height: 1.66,
                  ),
                ),
              ),
              
              SizedBox(height: 5.v),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2].map((index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: _currentPage == index ? 20.0 : 10.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /////////Onboarding Screen Three Start

  Widget OnboardingScreenbuildthree(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // width: 375.h,
          child: Column(
            children: [
              _buildImage3(context),
              SizedBox(height: 92.v),
              Text(
                "${AppLocalizations.of(context)!.itSimpleOnboardingScreenThreeSC}",
                style: theme.textTheme.headlineMedium,
              ),
              Container(
                width: 275.h,
                margin: EdgeInsets.only(
                  left: 52.h,
                  right: 47.h,
                ),
                child: Text(
                  "${AppLocalizations.of(context)!.doctariisEasyOnboardingScreenThreeSC}.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
                    height: 1.66,
                  ),
                ),
              ),
              //SizedBox(height: 48.v),
              SizedBox(height: 5.v),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2].map((index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: _currentPage == index ? 20.0 : 10.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(
                height: 40.v,
              ),
              CustomElevatedButton(
                text:
                    "${AppLocalizations.of(context)!.getStartedOnboardingScreenThreeSC}",
                onPressed: () {
                  // Navigator.pushReplacementNamed(
                  //     context, AppRoutes.registerAsScreen);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterAsScreen())));
                },
                margin: EdgeInsets.symmetric(horizontal: 40.h),
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle:
                    CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
              ),
              SizedBox(height: 16.v),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterAsScreen())));
                },
                child: Text(
                  "${AppLocalizations.of(context)!.skipOnboardingScreenThreeSC}",
                  style: CustomTextStyles.bodyMediumBluegray50014_1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget onboardingScreen1() {
//   return Container(
//     color: Colors.red,
//     child: Center(
//       child: Text(
//         'Welcome to App 1',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     ),
//   );
// }
/////////Onboarding Screen One End

// /////////Onboarding Screen Two Start
// Widget OnboardingScreenbuildtwo(BuildContext context) {
//   return SafeArea(
//     child: Scaffold(
//       body: SizedBox(
//         // width: 375.h,
//         child: Column(
//           children: [
//             _buildImage2(context),
//             SizedBox(height: 34.v),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 35),
//               child: Text(
//                 "${AppLocalizations.of(context)!.specialistsWhereWhenOnboardingScreenTwoSC}!",
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: theme.textTheme.headlineMedium,
//               ),
//             ),
//             SizedBox(height: 17.v),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 35),
//               child: Text(
//                 "${AppLocalizations.of(context)!.doctariGivesAccessOnboardingScreenTwoSC}.",
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
//                   height: 1.66,
//                 ),
//               ),
//             ),
//             // SizedBox(height: 48.v),
//             // CustomElevatedButton(
//             //   text:
//             //       "${AppLocalizations.of(context)!.getStartedOnboardingScreenTwoSC}",
//             //   onPressed: () {
//             //     // Navigator.pushReplacementNamed(
//             //     //     context, AppRoutes.onboardingScreenThreeScreen);
//             //     Navigator.pushReplacement(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: ((context) => OnboardingScreenThreeScreen())));
//             //   },
//             //   margin: EdgeInsets.symmetric(horizontal: 40.h),
//             //   buttonStyle: CustomButtonStyles.fillPrimary,
//             //   buttonTextStyle:
//             //       CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
//             // ),
//             // SizedBox(height: 16.v),
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.pushReplacement(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: ((context) => RegisterAsScreen())));
//             //   },
//             //   child: Text(
//             //     "${AppLocalizations.of(context)!.skipOnboardingScreenTwoSC}",
//             //     style: CustomTextStyles.bodyMediumBluegray50014_1,
//             //   ),
//             // ),
//             SizedBox(height: 50.v),
//               Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [0, 1, 2].map((index) {
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       margin: EdgeInsets.symmetric(horizontal: 8.0),
//                       width: _currentPage == index ? 24.0 : 12.0,
//                       height: 12.0,
//                       decoration: BoxDecoration(
//                         color:
//                             _currentPage == index ? Colors.black : Colors.grey,
//                         borderRadius: BorderRadius.circular(6.0),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),

//           ],
//         ),
//       ),
//     ),
//   );
// }

/// Section Widget
Widget _buildImage2(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: SizedBox(
      height: 400.v,
      width: 355.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse153295x200,
            height: 295.v,
            width: 238.h,
            alignment: Alignment.topRight,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse154336x336,
            height: 336.adaptSize,
            width: 336.adaptSize,
            radius: BorderRadius.circular(
              168.h,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    ),
  );
}

// Widget onboardingScreen2() {
//   return Container(
//     color: Colors.green,
//     child: Center(
//       child: Text(
//         'Welcome to App 2',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     ),
//   );
// }
/////////Onboarding Screen Two End

/////////Onboarding Screen Three Start

// Widget OnboardingScreenbuildthree(BuildContext context) {
//   return SafeArea(
//     child: Scaffold(
//       body: SizedBox(
//         // width: 375.h,
//         child: Column(
//           children: [
//             _buildImage3(context),
//             SizedBox(height: 92.v),
//             Text(
//               "${AppLocalizations.of(context)!.itSimpleOnboardingScreenThreeSC}",
//               style: theme.textTheme.headlineMedium,
//             ),
//             Container(
//               width: 275.h,
//               margin: EdgeInsets.only(
//                 left: 52.h,
//                 right: 47.h,
//               ),
//               child: Text(
//                 "${AppLocalizations.of(context)!.doctariisEasyOnboardingScreenThreeSC}.",
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: CustomTextStyles.bodyMediumBluegray50014.copyWith(
//                   height: 1.66,
//                 ),
//               ),
//             ),
//             SizedBox(height: 48.v),
//             CustomElevatedButton(
//               text:
//                   "${AppLocalizations.of(context)!.getStartedOnboardingScreenThreeSC}",
//               onPressed: () {
//                 // Navigator.pushReplacementNamed(
//                 //     context, AppRoutes.registerAsScreen);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: ((context) => RegisterAsScreen())));
//               },
//               margin: EdgeInsets.symmetric(horizontal: 40.h),
//               buttonStyle: CustomButtonStyles.fillPrimary,
//               buttonTextStyle:
//                   CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
//             ),
//             SizedBox(height: 16.v),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: ((context) => RegisterAsScreen())));
//               },
//               child: Text(
//                 "${AppLocalizations.of(context)!.skipOnboardingScreenThreeSC}",
//                 style: CustomTextStyles.bodyMediumBluegray50014_1,
//               ),
//             ),
//             SizedBox(height: 50.v),
//               Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [0, 1, 2].map((index) {
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       margin: EdgeInsets.symmetric(horizontal: 8.0),
//                       width: _currentPage == index ? 24.0 : 12.0,
//                       height: 12.0,
//                       decoration: BoxDecoration(
//                         color:
//                             _currentPage == index ? Colors.black : Colors.grey,
//                         borderRadius: BorderRadius.circular(6.0),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),

//           ],
//         ),
//       ),
//     ),
//   );
// }

/// Section Widget
Widget _buildImage3(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      height: 400.v,
      width: 356.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse153295x238,
            height: 295.v,
            width: 238.h,
            alignment: Alignment.topLeft,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse1541,
            height: 336.adaptSize,
            width: 336.adaptSize,
            radius: BorderRadius.circular(
              168.h,
            ),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    ),
  );
}

// Widget onboardingScreen3() {
//   return Container(
//     color: Colors.blue,
//     child: Center(
//       child: Text(
//         'Welcome to App 3',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     ),
//   );
// }
/////////Onboarding Screen Three End
