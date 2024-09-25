//here first updated code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordOneBottomSheet extends StatefulWidget {
  ForgetPasswordOneBottomSheet({Key? key}) : super(key: key);

  @override
  _ForgetPasswordOneBottomSheetState createState() =>
      _ForgetPasswordOneBottomSheetState();
}

class _ForgetPasswordOneBottomSheetState
    extends State<ForgetPasswordOneBottomSheet> {
  TextEditingController _bottomSheetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the keyboard height
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: keyboardHeight), // Adjust padding for keyboard
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            color: Color(0xffC4C4C4),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.forgotPasswordForgotPasswordSC}',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: 'Nunito'),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '${AppLocalizations.of(context)!.verificationEmailForgotPasswordSC}.',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  _buildEmail(context),
                  SizedBox(height: 30.0),
                  _buildContinueButton(context),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text: "${AppLocalizations.of(context)!.sendEmailForgotPasswordSC}",
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
      onPressed: () async {
        await PatientApiService().patientResetPassword(
            context, _bottomSheetEmailController.text.toString());
        //Navigator.of(context).pop();
      },
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: _bottomSheetEmailController,
      hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
      textInputType: TextInputType.emailAddress,
    );
  }

  @override
  void dispose() {
    _bottomSheetEmailController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ForgetPasswordOneBottomSheet extends StatefulWidget {
//   ForgetPasswordOneBottomSheet({Key? key}) : super(key: key);

//   @override
//   _ForgetPasswordOneBottomSheetState createState() =>
//       _ForgetPasswordOneBottomSheetState();
// }

// class _ForgetPasswordOneBottomSheetState
//     extends State<ForgetPasswordOneBottomSheet> {
//   TextEditingController _bottomSheetEmailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             color: Colors.white, // Ensure the background color is set
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 5,
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       decoration: BoxDecoration(
//                           color: Color(0xffC4C4C4),
//                           borderRadius: BorderRadius.circular(20)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${AppLocalizations.of(context)!.forgotPasswordForgotPasswordSC}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 22,
//                           color: Colors.black,
//                           fontFamily: 'Nunito'),
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       '${AppLocalizations.of(context)!.verificationEmailForgotPasswordSC}.',
//                       style: TextStyle(fontSize: 14.0, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30.0),
//                 _buildEmail(context),
//                 SizedBox(height: 30.0),
//                 _buildContinueButton(context),
//                 SizedBox(height: 30.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "${AppLocalizations.of(context)!.sendEmailForgotPasswordSC}",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       buttonStyle: CustomButtonStyles.fillPrimary,
//       buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
//       onPressed: () async {
//         await PatientApiService().patientResetPassword(
//             context, _bottomSheetEmailController.text.toString());
//       },
//     );
//   }

//   Widget _buildEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: _bottomSheetEmailController,
//       hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
//       textInputType: TextInputType.emailAddress,
//     );
//   }

//   @override
//   void dispose() {
//     _bottomSheetEmailController.dispose();
//     super.dispose();
//   }
// }



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:doctari/core/utils/image_constant.dart';
// import 'package:doctari/widgets/custom_image_view.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ForgetPasswordOneBottomSheet extends StatefulWidget {
//   ForgetPasswordOneBottomSheet({Key? key}) : super(key: key);

//   @override
//   _ForgetPasswordOneBottomSheetState createState() =>
//       _ForgetPasswordOneBottomSheetState();
// }

// class _ForgetPasswordOneBottomSheetState
//     extends State<ForgetPasswordOneBottomSheet> {
//   TextEditingController _bottomSheetEmailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 5,
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       decoration: BoxDecoration(
//                           color: Color(0xffC4C4C4),
//                           borderRadius: BorderRadius.circular(20)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${AppLocalizations.of(context)!.forgotPasswordForgotPasswordSC}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 22,
//                           color: Colors.black,
//                           fontFamily: 'Nunito'),
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       '${AppLocalizations.of(context)!.verificationEmailForgotPasswordSC}.',
//                       style: TextStyle(fontSize: 14.0, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30.0),
//                 _buildEmail(context),
//                 SizedBox(height: 30.0),
//                 _buildContinueButton(context),
//                 SizedBox(height: 30.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "${AppLocalizations.of(context)!.sendEmailForgotPasswordSC}",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       buttonStyle: CustomButtonStyles.fillPrimary,
//       buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
//       onPressed: () async {
//         await PatientApiService().patientResetPassword(
//             context, _bottomSheetEmailController.text.toString());
//       },
//     );
//   }

//   Widget _buildEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: _bottomSheetEmailController,
//       hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
//       textInputType: TextInputType.emailAddress,
//     );
//   }

//   @override
//   void dispose() {
//     _bottomSheetEmailController.dispose();
//     super.dispose();
//   }
// }

//last code 15/08
// import 'package:doctari/core/app_export.dart';
// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/patientFlow/registration_screens/login_screen/forget_password_bottom_sheet_two.dart/forget_password_bottom_sheet_two.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/utils/image_constant.dart';
// import 'package:doctari/widgets/custom_image_view.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ForgetPasswordOneBottomSheet extends StatefulWidget {
//   ForgetPasswordOneBottomSheet({Key? key}) : super(key: key);

//   @override
//   _ForgetPasswordOneBottomSheetState createState() =>
//       _ForgetPasswordOneBottomSheetState();
// }

// class _ForgetPasswordOneBottomSheetState
//     extends State<ForgetPasswordOneBottomSheet> {
//   double bottomSheetHeight = 500;

//   TextEditingController _bottomSheetEmailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: AlwaysScrollableScrollPhysics(),
//       child: Container(
//         height: bottomSheetHeight,
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 5,
//                   width: MediaQuery.of(context).size.width * 0.5,
//                   decoration: BoxDecoration(
//                       color: Color(0xffC4C4C4),
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${AppLocalizations.of(context)!.forgotPasswordForgotPasswordSC}',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 22,
//                       color: Colors.black,
//                       fontFamily: 'Nunito'),
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   '${AppLocalizations.of(context)!.verificationEmailForgotPasswordSC}.',
//                   style: TextStyle(fontSize: 14.0, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30.0),
//             GestureDetector(
//                 onTap: () {
//                   bottomSheetHeight = 500;
//                 },
//                 child: _buildEmail(context)),
//             SizedBox(height: 30.0),
//             _buildContinueButton(context),
//             SizedBox(height: 30.0),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "${AppLocalizations.of(context)!.sendEmailForgotPasswordSC}",
//       margin: EdgeInsets.symmetric(horizontal: 20.h),
//       buttonStyle: CustomButtonStyles.fillPrimary,
//       buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
//       onPressed: () async {
//         // Navigator.pop(context);
//         // showModalBottomSheet(
//         //   context: context,
//         //   builder: (BuildContext context) {
//         //     return ForgetPasswordTwoBottomSheet();
//         //   },
//         // );
//         await PatientApiService().patientResetPassword(
//             context, _bottomSheetEmailController.text.toString());
//         //Navigator.pop(context);
//       },
//     );
//   }

//   Widget _buildEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: _bottomSheetEmailController,
//       hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
//       textInputType: TextInputType.emailAddress,
//     );
//   }

//   @override
//   void dispose() {
//     _bottomSheetEmailController.dispose();
//     super.dispose();
//   }
// }
