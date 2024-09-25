// import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
// import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../patientFlow/registration_screens/login_screen/forget_password_bottom_sheets/forget_password.dart';

// class PatientLoginScreen extends StatefulWidget {
//   PatientLoginScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   State<PatientLoginScreen> createState() => _PatientLoginScreenState();
// }

// class _PatientLoginScreenState extends State<PatientLoginScreen> {
//   TextEditingController emailController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();

//   bool isShowPassword = false;

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoggedIn = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Container(
//                 width: 375.h,
//                 padding: EdgeInsets.all(20.h),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 57.v),
//                     CustomImageView(
//                       imagePath: ImageConstant.imgDoctariIcon51,
//                       height: 54.v,
//                       width: 214.h,
//                     ),
//                     SizedBox(height: 14.v),
//                     Text(
//                       "Welcome back!",
//                       style: CustomTextStyles.titleLargeBlack900,
//                     ),
//                     SizedBox(height: 79.v),
//                     _buildEmail(context),
//                     SizedBox(height: 18.v),
//                     _buildPassword(context),
//                     SizedBox(height: 32.v),
//                     _buildLogin(context),
//                     SizedBox(height: 13.v),
//                     GestureDetector(
//                       onTap: () {
//                         print("Bottom Sheet is Opened or Clicked");
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return ForgetPasswordOneBottomSheet();
//                           },
//                         );
//                       },
//                       child: Text(
//                         "Forgot password",
//                         style: CustomTextStyles.bodyMedium14,
//                       ),
//                     ),
//                     SizedBox(height: 31.v),
//                     _buildLoginWithGoogle(context),
//                     SizedBox(height: 15.v),
//                     _buildLoginWithApple(context),
//                     SizedBox(height: 90.v),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => RegisterAsScreen(),
//                             ));
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Don’t have an account? ",
//                               style: CustomTextStyles.bodyMediumff000000,
//                             ),
//                             TextSpan(
//                               text: "Join us",
//                               style: CustomTextStyles.bodyMediumff004687,
//                             ),
//                           ],
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: emailController,
//       hintText: "abdulrehman@gmail.com",
//       textInputType: TextInputType.emailAddress,
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
//       suffix: Container(
//         margin: EdgeInsets.fromLTRB(30.h, 21.v, 15.h, 21.v),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgCheckmark,
//           height: 11.v,
//           width: 15.h,
//           color: Color(0xff677294),
//         ),
//       ),
//       suffixConstraints: BoxConstraints(
//         maxHeight: 54.v,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildPassword(BuildContext context) {
//     return CustomTextFormField(
//       controller: passwordController,
//       hintText: "Password",
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Colors.grey.shade300,
//           )),
//       textInputAction: TextInputAction.done,
//       suffix: IconButton(
//           onPressed: () {
//             if (isShowPassword) {
//               isShowPassword = false;
//             } else {
//               isShowPassword = true;
//             }
//             setState(() {});
//           },
//           icon: Icon(
//             isShowPassword ? Icons.visibility : Icons.visibility_off,
//           )),
//       obscureText: !isShowPassword,
//     );
//   }

//   /// Section Widget
//   Widget _buildLogin(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Container(
//             // width: MediaQuery.of(context).size.width * 0.9,
//             height: 50,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.blue),
//                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)))),
//               onPressed: _isLoggedIn
//                   ? null
//                   : () async {
//                       setState(() {
//                         _isLoggedIn = true;
//                       });
//                       await PatientApiService().PatientLogin(
//                           context,
//                           emailController.text.toString(),
//                           passwordController.text.toString());
//                       setState(() {
//                         _isLoggedIn = false;
//                       });
//                     },
//               child: _isLoggedIn
//                   ? CircularProgressIndicator(
//                       color: Colors.white,
//                     )
//                   : Text(
//                       'Sign In',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//     // CustomElevatedButton(
//     //   text: "Login",
//     //   onPressed: () async {
//     // await PatientApiService().PatientLogin(
//     //     context,
//     //     emailController.text.toString(),
//     //     passwordController.text.toString());
//     //   },
//     //   margin: EdgeInsets.symmetric(horizontal: 20.h),
//     //   buttonStyle: CustomButtonStyles.fillPrimary,
//     //   buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
//     // );
//   }

//   /// Section Widget
//   Widget _buildLoginWithGoogle(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Login with Google",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 12.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgGroup18x18,
//           height: 18.adaptSize,
//           width: 18.adaptSize,
//         ),
//       ),
//       buttonStyle: CustomButtonStyles.outlineBlack,
//       buttonTextStyle: theme.textTheme.bodyLarge!,
//     );
//   }

//   /// Section Widget
//   Widget _buildLoginWithApple(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Login with Apple",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 18.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgApplelogo1,
//           height: 18.v,
//           width: 15.h,
//         ),
//       ),
//       buttonStyle: CustomButtonStyles.outlineBlack,
//       buttonTextStyle: theme.textTheme.bodyLarge!,
//     );
//   }
// }

import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/onboarding_screens/register_as_screen/register_as_screen.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../patientFlow/registration_screens/login_screen/forget_password_bottom_sheets/forget_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientLoginScreen extends StatefulWidget {
  PatientLoginScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: 375.h,
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    SizedBox(height: 57.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgDoctariIcon51,
                      height: 54.v,
                      width: 214.h,
                    ),
                    SizedBox(height: 14.v),
                    Text(
                      "${AppLocalizations.of(context)!.welcomeBackPatientLoginScreenSC}!",
                      style: CustomTextStyles.titleLargeBlack900,
                    ),
                    SizedBox(height: 79.v),
                    _buildEmail(context),
                    SizedBox(height: 18.v),
                    _buildPassword(context),
                    SizedBox(height: 32.v),
                    _buildLogin(context),
                    SizedBox(height: 13.v),
                    GestureDetector(
                      onTap: () {
                        print("Bottom Sheet is Opened or Clicked");
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ForgetPasswordOneBottomSheet();
                          },
                        );
                      },
                      child: Text(
                        "${AppLocalizations.of(context)!.forgotPasswordForgotPasswordSC}",
                        style: CustomTextStyles.bodyMedium14,
                      ),
                    ),
                    // SizedBox(height: 31.v),
                    // _buildLoginWithGoogle(context),
                    // SizedBox(height: 15.v),
                    // _buildLoginWithApple(context),
                    SizedBox(height: 20.v),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterAsScreen(),
                            ));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${AppLocalizations.of(context)!.dontAccountLoginScreendSC}? ",
                              style: CustomTextStyles.bodyMediumff000000,
                            ),
                            TextSpan(
                              text:
                                  "${AppLocalizations.of(context)!.joinUsLoginScreendSC}",
                              style: CustomTextStyles.bodyMediumff004687,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      textInputType: TextInputType.emailAddress,
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 21.v, 15.h, 21.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgCheckmark,
          height: 11.v,
          width: 15.h,
          color: Color(0xff677294),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 54.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      hintText:
          "${AppLocalizations.of(context)!.passwordDoctorRegistration2SC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          )),
      textInputAction: TextInputAction.done,
      suffix: IconButton(
          onPressed: () {
            if (isShowPassword) {
              isShowPassword = false;
            } else {
              isShowPassword = true;
            }
            setState(() {});
          },
          icon: Icon(
            isShowPassword ? Icons.visibility : Icons.visibility_off,
          )),
      obscureText: !isShowPassword,
    );
  }

  /// Section Widget
  Widget _buildLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: _isLoggedIn
                  ? null
                  : () async {
                      setState(() {
                        _isLoggedIn = true;
                      });
                      await PatientApiService().PatientLogin(
                          context,
                          emailController.text.toString(),
                          passwordController.text.toString());
                      setState(() {
                        _isLoggedIn = false;
                      });

                      // Show a Snackbar after the login attempt
                      // if (!mounted) return;
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(_isLoggedIn
                      //         ? 'Login Successful'
                      //         : 'Login Failed'),
                      //     behavior: SnackBarBehavior.floating,
                      //     margin: EdgeInsets.only(
                      //         bottom:
                      //             MediaQuery.of(context).viewInsets.bottom + 20,
                      //         left: 20,
                      //         right: 20),
                      //   ),
                      // );
                    },
              child: _isLoggedIn
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      '${AppLocalizations.of(context)!.signInLoginScreendSC}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
//   Widget _buildLoginWithGoogle(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Login with Google",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 12.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgGroup18x18,
//           height: 18.adaptSize,
//           width: 18.adaptSize,
//         ),
//       ),
//       buttonStyle: CustomButtonStyles.outlineBlack,
//       buttonTextStyle: theme.textTheme.bodyLarge!,
//     );
//   }

//   /// Section Widget
//   Widget _buildLoginWithApple(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Login with Apple",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 18.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgApplelogo1,
//           height: 18.v,
//           width: 15.h,
//         ),
//       ),
//       buttonStyle: CustomButtonStyles.outlineBlack,
//       buttonTextStyle: theme.textTheme.bodyLarge!,
//     );
//   }
}
