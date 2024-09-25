// import 'dart:developer';
// import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
// import 'package:doctari/presentation/patient_login_screen/patient_login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart'; // Added import for showDatePicker
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:doctari/widgets/custom_icon_button.dart';
// import 'package:doctari/core/app_export.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:country_icons/country_icons.dart';

// class SignUpScreenOneForPatientScreen extends StatefulWidget {
//   SignUpScreenOneForPatientScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreenOneForPatientScreen> createState() =>
//       _SignUpScreenOneForPatientScreenState();
// }

// class _SignUpScreenOneForPatientScreenState
//     extends State<SignUpScreenOneForPatientScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   String selectedGender = ''; // Add a variable to store the selected gender
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController birthDateController = TextEditingController();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool isTab1 = false;
//   bool isTab2 = false;
//   bool isTab3 = false;
//   Country? selectedCountry;

//   void emailValid() {
//     final bool isValidEmail =
//         EmailValidator.validate(emailController.text.trim());

//     if (isValidEmail) {
//       if (_formKey.currentState!.validate()) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SignUpScreenThreeScreen(
//               Dob: birthDateController.text.toString(),
//               email: emailController.text.toString(),
//               firstName: nameController.text.toString(),
//               gender: selectedGender,
//               lastName: lastNameController.text.toString(),
//               phoneNumber: phoneNumberController.text.toString(),
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Phone number is not valid')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Email not valid')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 23.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: 21.0),
//                   Text(
//                     "${AppLocalizations.of(context)!.findSignUpScreenOnePatientSC} ${AppLocalizations.of(context)!.doctorsSignUpScreenOnePatientSC}, \n${AppLocalizations.of(context)!.bookSignUpScreenOnePatientSC} ${AppLocalizations.of(context)!.appointmentsSignUpScreenOnePatientSC}",
//                     textAlign: TextAlign.center,
//                     style: CustomTextStyles.headlineSmallff000000,
//                   ),
//                   SizedBox(height: 55.v),
//                   _buildName(context),
//                   SizedBox(height: 20.v),
//                   _buildLastName(context),
//                   SizedBox(height: 20.v),
//                   _buildBirthdate(context),
//                   SizedBox(height: 20.v),
//                   _buildGender(context),
//                   SizedBox(height: 20.v),
//                   _buildPhoneNumber(context),
//                   SizedBox(height: 20.v),
//                   _buildEmail(context),
//                   SizedBox(height: 22.v),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomIconButton(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         height: 54.adaptSize,
//                         width: 54.adaptSize,
//                         padding: EdgeInsets.all(20.h),
//                         decoration: IconButtonStyleHelper.outlineBlueGray,
//                         child: CustomImageView(
//                           imagePath: ImageConstant.imgArrowLeftGray50002,
//                           color: Colors.black,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (nameController.text.isEmpty ||
//                               birthDateController.text.isEmpty ||
//                               emailController.text.isEmpty ||
//                               lastNameController.text.isEmpty ||
//                               phoneNumberController.text.isEmpty ||
//                               selectedGender.isEmpty) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                     "${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}"),
//                                 duration: Duration(seconds: 3),
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                             return;
//                           }
//                           emailValid();
//                         },
//                         child: CustomIconButton(
//                           height: 54.adaptSize,
//                           width: 54.adaptSize,
//                           padding: EdgeInsets.all(20.h),
//                           decoration: IconButtonStyleHelper.fillPrimary,
//                           child: CustomImageView(
//                             imagePath: ImageConstant.imgArrowRight,
//                             color: Colors.white,
//                             height: 60.0,
//                             width: 60.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 45.v),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PatientLoginScreen(),
//                         ),
//                       );
//                     },
//                     child: Center(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
//                             style: CustomTextStyles.bodyMediumff000000,
//                           ),
//                           Text(
//                             "${AppLocalizations.of(context)!.logInDoctorRegistrationSC} ",
//                             style: CustomTextStyles.bodyMediumff004687,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildName(BuildContext context) {
//     return CustomTextFormField(
//       controller: nameController,
//       hintText:
//           "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
//       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
//       borderDecoration: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
//       ),
//     );
//   }

//   Widget _buildLastName(BuildContext context) {
//     return CustomTextFormField(
//       controller: lastNameController,
//       hintText: "${AppLocalizations.of(context)!.lastNameDoctorProfileScrenSC}",
//       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
//       borderDecoration: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime currentDate = DateTime.now();
//     DateTime lastDate =
//         DateTime(currentDate.year, currentDate.month, currentDate.day - 1);

//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: lastDate,
//       firstDate: DateTime(1900),
//       lastDate: lastDate,
//     );

//     if (picked != null) {
//       String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
//       setState(() {
//         birthDateController.text = formattedDate;
//       });
//     }
//   }

//   // Widget _buildBirthdate(BuildContext context) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       _selectDate(context);
//   //     },
//   //     child: AbsorbPointer(
//   //       child: TextFormField(
//   //         readOnly: true,
//   //         style: TextStyle(
//   //           fontSize: 15.0,
//   //           color: Colors.grey.shade500,
//   //           fontWeight: FontWeight.w500,
//   //         ),
//   //         controller: birthDateController,
//   //         decoration: InputDecoration(
//   //           suffixText: "YYYY-MM-DD",
//   //           labelText:
//   //               "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
//   //           border: OutlineInputBorder(
//   //             borderRadius: BorderRadius.circular(8.0),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   /// Section Widget
//   Widget _buildBirthdate(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _selectDate(context);
//       },
//       child: AbsorbPointer(
//         child: TextFormField(
//           readOnly: true,
//           style: TextStyle(
//             fontSize: 15,
//             color: Colors.grey.shade500,
//             fontWeight: FontWeight.w500,
//           ),
//           controller: birthDateController,
//           decoration: InputDecoration(
//             suffix: Text("YYYY-MM-DD"),
//             labelText:
//                 "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
//             enabled: false,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildGender(BuildContext context) {
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//   //     decoration: BoxDecoration(
//   //       borderRadius: BorderRadius.circular(8.0),
//   //       border: Border.all(color: Colors.grey.shade300, width: 1.0),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Text(
//   //           "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}",
//   //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//   //         ),
//   //         SizedBox(height: 8.0),
//   //         Row(
//   //           children: [
//   //             Expanded(
//   //               child: RadioListTile<String>(
//   //                 title: Text("Male"),
//   //                 value: 'Male',
//   //                 groupValue: selectedGender,
//   //                 onChanged: (value) {
//   //                   setState(() {
//   //                     selectedGender = value!;
//   //                   });
//   //                 },
//   //               ),
//   //             ),
//   //             Expanded(
//   //               child: RadioListTile<String>(
//   //                 title: Text("Female"),
//   //                 value: 'Female',
//   //                 groupValue: selectedGender,
//   //                 onChanged: (value) {
//   //                   setState(() {
//   //                     selectedGender = value!;
//   //                   });
//   //                 },
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   /// Section Widget
//   Widget _buildGender(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.grey.shade300, width: 1)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}",
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           Row(
//             children: [
//               Radio(
//                 value: "M",
//                 activeColor: Colors.grey.shade300,
//                 groupValue: selectedGender,
//                 fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedGender = value!;
//                   });
//                 },
//               ),
//               Text(
//                 "M",
//                 style: TextStyle(color: Colors.grey),
//               ),
//               SizedBox(width: 20),
//               Radio(
//                 value: "F",
//                 groupValue: selectedGender,
//                 activeColor: Colors.grey.shade300,
//                 fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedGender = value!;
//                   });
//                 },
//               ),
//               Text(
//                 "F",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPhoneNumber(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: phoneNumberController,
//               decoration: InputDecoration(
//                 hintText: "Phone Number",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.red, width: 1),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 25, vertical: 16),
//                 prefixIcon: GestureDetector(
//                   onTap: () {
//                     showCountryPicker(
//                       context: context,
//                       onSelect: (country) {
//                         setState(() {
//                           selectedCountry = country;
//                           phoneNumberController.text = '+${country.phoneCode} ';
//                         });
//                       },
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: selectedCountry != null
//                         ? Image.asset(
//                             'packages/country_icons/icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
//                             package: 'country_icons',
//                             width: 32,
//                             errorBuilder: (context, error, stackTrace) {
//                               // Fallback icon when the image is not found
//                               return Icon(Icons.flag);
//                             },
//                           )
//                         : Icon(Icons.flag),
//                   ),
//                 ),
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildPhoneNumber(BuildContext context) {
//   //   return CustomTextFormField(
//   //     controller: phoneNumberController,
//   //     hintText: "Phone Number",
//   //     //hintText: "${AppLocalizations.of(context)!.phoneNumberDoctorProfileScrenSC}",
//   //     textInputType: TextInputType.phone,
//   //     contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
//   //     borderDecoration: OutlineInputBorder(
//   //       borderRadius: BorderRadius.circular(8.0),
//   //       borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
//   //     ),
//   //   );
//   // }

//   Widget _buildEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: emailController,
//       hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
//       borderDecoration: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//       ),
//       textInputAction: TextInputAction.done,
//       textInputType: TextInputType.emailAddress,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 25.0,
//         vertical: 16.0,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter an email address';
//         } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
//             .hasMatch(value)) {
//           return 'Please enter a valid email address';
//         }
//         return null;
//       },
//     );
//   }

//   // Widget _buildEmail(BuildContext context) {
//   //   return CustomTextFormField(
//   //     controller: emailController,
//   //     hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
//   //     textInputType: TextInputType.emailAddress,
//   //     contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
//   //     borderDecoration: OutlineInputBorder(
//   //       borderRadius: BorderRadius.circular(8.0),
//   //       borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
//   //     ),
//   //   );
//   // }
// }

// import 'dart:developer';

import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/presentation/patient_login_screen/patient_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Added import for showDatePicker
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'widgets/gender_item_widget.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';
import 'package:country_picker/country_picker.dart';

class SignUpScreenOneForPatientScreen extends StatefulWidget {
  SignUpScreenOneForPatientScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SignUpScreenOneForPatientScreen> createState() =>
      _SignUpScreenOneForPatientScreenState();
}

class _SignUpScreenOneForPatientScreenState
    extends State<SignUpScreenOneForPatientScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  String selectedGender = ''; // Add a variable to store the selected gender

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController birthDateController = TextEditingController();
  // Added birthDateController
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isTab1 = false;
  bool isTab2 = false;
  bool isTab3 = false;
  Country? selectedCountry;
//create function for check email valid or not

  void emailValid() {
    final bool isValidEmail =
        EmailValidator.validate(emailController.text.trim());

    if (isValidEmail) {
      if (_formKey.currentState!.validate()) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpScreenThreeScreen(
                    Dob: birthDateController.text.toString(),
                    email: emailController.text.toString(),
                    firstName: nameController.text.toString(),
                    gender: selectedGender,
                    lastName: lastNameController.text.toString(),
                    phoneNumber: phoneNumberController.text.toString(),
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number is not valid')),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email not valid')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 23.v,
              ),
              child: Column(
                children: [
                  SizedBox(height: 21.v),
                  SizedBox(
                    width: 218.h,
                    child: RichText(
                      text: TextSpan(
                        style: CustomTextStyles.headlineSmallff000000,
                        children: [
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.findSignUpScreenOnePatientSC} ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.doctorsSignUpScreenOnePatientSC}, \n",
                            style: TextStyle(color: Color(0xff00008B)),
                          ),
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.bookSignUpScreenOnePatientSC} ",
                            style: CustomTextStyles.headlineSmallff000000,
                          ),
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.appointmentsSignUpScreenOnePatientSC}",
                            style: TextStyle(color: Color(0xff00008B)),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 55.v),
                  _buildName(context),
                  SizedBox(height: 20.v),
                  _buildLastName(context),
                  SizedBox(height: 20.v),
                  _buildBirthdate(context),
                  SizedBox(height: 20.v),
                  _buildGender(context),
                  SizedBox(height: 20.v),
                  _buildPhoneNumber(context),
                  SizedBox(height: 20.v),
                  _buildEmail(context),
                  SizedBox(height: 22.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIconButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          height: 54.adaptSize,
                          width: 54.adaptSize,
                          padding: EdgeInsets.all(20.h),
                          decoration: IconButtonStyleHelper.outlineBlueGray,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowLeftGray50002,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (nameController.text.isEmpty ||
                                birthDateController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                lastNameController.text.isEmpty ||
                                phoneNumberController.text.isEmpty ||
                                selectedGender.isEmpty) {
                              // Show error message for any empty field
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}"),
                                  duration: Duration(
                                      seconds: 3), // Adjust duration as needed
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                      // bottom: MediaQuery.of(context)
                                      //         .viewInsets
                                      //         .bottom +
                                      //     0, // Adjust as needed
                                      ),
                                ),
                              );

                              return; // Exit function if validation fails
                            }
                            emailValid();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SignUpScreenThreeScreen(
                            //             Dob:
                            //                 birthDateController.text.toString(),
                            //             email: emailController.text.toString(),
                            //             firstName:
                            //                 nameController.text.toString(),
                            //             gender: selectedGender,
                            //             lastName:
                            //                 lastNameController.text.toString(),
                            //             phoneNumber: phoneNumberController.text
                            //                 .toString(),
                            //           )),
                            // );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.h),
                            child: CustomIconButton(
                              height: 54.adaptSize,
                              width: 54.adaptSize,
                              padding: EdgeInsets.all(20.h),
                              decoration: IconButtonStyleHelper.fillPrimary,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgArrowRight,
                                color: Colors.white,
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 51.v),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientLoginScreen(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
                          style: CustomTextStyles.bodyMediumff000000,
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.logInDoctorRegistrationSC} ",
                          style: CustomTextStyles.bodyMediumff004687,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: nameController,
      hintText:
          "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.h,
        vertical: 16.v,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
    );
  }

  /// Section Widget
  Widget _buildLastName(BuildContext context) {
    return CustomTextFormField(
      controller: lastNameController,
      hintText: "${AppLocalizations.of(context)!.lastNameDoctorProfileScrenSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.h,
        vertical: 16.v,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastDate;

    if (currentDate.day == 1) {
      // If today is the first of the month, set lastDate to the last day of the previous month
      lastDate = DateTime(currentDate.year, currentDate.month, 0);
    } else {
      // Otherwise, set lastDate to the previous day
      lastDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day - 1);
    }

    DateTime initialDate =
        currentDate.isAfter(lastDate) ? lastDate : currentDate;

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        birthDateController.text = formattedDate;
      });
    }
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   if (picked != null && picked != DateTime.now()) {
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
  //     setState(() {
  //       birthDateController.text = formattedDate;
  //     });
  //   }
  // }

  /// Section Widget
  Widget _buildBirthdate(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          controller: birthDateController,
          decoration: InputDecoration(
            suffix: Text("YYYY-MM-DD"),
            labelText:
                "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
            enabled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGender(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Radio(
                value: "M",
                activeColor: Colors.grey.shade300,
                groupValue: selectedGender,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              Text(
                "M",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 20),
              Radio(
                value: "F",
                groupValue: selectedGender,
                activeColor: Colors.grey.shade300,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              Text(
                "F",
                style: TextStyle(color: Colors.grey),
              ),
              // SizedBox(width: 20),
              // Radio(
              //   value: "Custom",
              //   activeColor: Colors.grey.shade300,
              //   fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
              //   groupValue: selectedGender,
              //   onChanged: (String? value) {
              //     setState(() {
              //       selectedGender = value!;
              //     });
              //   },
              // ),
              // Text(
              //   "Custom",
              //   style: TextStyle(color: Colors.grey),
              // ),
            ],
          ),
        ],
      ),
    );
  }

//add new validation for phone number

  Widget _buildPhoneNumber(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                prefixIcon: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (country) {
                        setState(() {
                          selectedCountry = country;
                          phoneNumberController.text = '+${country.phoneCode} ';
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: 
                    // selectedCountry != null
                    //     ? Image.asset(
                    //         'packages/country_icons/icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
                    //         package: 'country_icons',
                    //         width: 32,
                    //         errorBuilder: (context, error, stackTrace) {
                    //           // Fallback icon when the image is not found
                    //           return Icon(
                    //             Icons.flag,
                    //             //color: Colors.grey,
                    //           );
                    //         },
                    //       )
                    //     : 
                        Icon(
                            Icons.flag,
                            //color: Colors.grey,
                          ),
                  ),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPhoneNumber(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: TextFormField(
  //           controller: phoneNumberController,
  //           decoration: InputDecoration(
  //             hintText: "Phone Number",
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             errorBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(
  //                   color: Colors.red,
  //                   width: 1), // Optional: Customize error border color
  //             ),
  //             disabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 25, vertical: 16),
  //             prefixIcon: GestureDetector(
  //               onTap: () {
  //                 showCountryPicker(
  //                   context: context,
  //                   onSelect: (country) {
  //                     setState(() {
  //                       selectedCountry = country;
  //                       phoneNumberController.text = '+${country.phoneCode} ';
  //                     });
  //                   },
  //                 );
  //               },
  //               // child: Container(
  //               //   padding: EdgeInsets.symmetric(horizontal: 8.0),
  //               //   child: selectedCountry != null
  //               //       ? Image.asset(
  //               //           'icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
  //               //           package: 'country_icons',
  //               //           width: 32,
  //               //         )
  //               //       : Icon(Icons.flag),
  //               // ),
  //             ),
  //           ),
  //           keyboardType: TextInputType.phone,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /// Section Widget
  // Widget _buildPhoneNumber(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: phoneNumberController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.phoneNumberDoctorRegistrationSC}",
  //     textInputType: TextInputType.phone,
  //     borderDecoration: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 25.h,
  //       vertical: 16.v,
  //     ),
  //   );
  // }

  // Widget _buildPhoneNumber(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: phoneNumberController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.phoneNumberDoctorRegistrationSC}",
  //     textInputType: TextInputType.phone,
  //     borderDecoration: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 25.h,
  //       vertical: 16.v,
  //     ),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter a phone number';
  //       }
  //       if (value.length != 12) {
  //         return 'Phone number must be 12 digits';
  //       }
  //       if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
  //         return 'Phone number must contain only digits';
  //       }
  //       return null;
  //     },
  //   );
  // }

  /// Section Widget
  // Widget _buildEmail(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: emailController,
  //     hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
  //     borderDecoration: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
  //     textInputAction: TextInputAction.done,
  //     textInputType: TextInputType.emailAddress,
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 25.h,
  //       vertical: 16.v,
  //     ),
  //   );
  // }
//ADD here validation for email
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 16.0,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
