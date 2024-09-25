import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/presentation/patient_login_screen/patient_login_screen.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_iconbutton_one.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_drop_down.dart';
import 'package:doctari/widgets/custom_checkbox_button.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreenThreeScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String Dob;
  final String gender;
  final String phoneNumber;
  final List<TextInputFormatter>? inputFormatters; // Optional parameter

  SignUpScreenThreeScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.Dob,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    this.inputFormatters, // Optional parameter
  }) : super(
          key: key,
        );

  @override
  State<SignUpScreenThreeScreen> createState() =>
      _SignUpScreenThreeScreenState();
}

class _SignUpScreenThreeScreenState extends State<SignUpScreenThreeScreen> {
  TextEditingController documentController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController licenseNumberController = TextEditingController();
  DropdownItem? country;
  List<DropdownItem> dropdownItems = [];

  bool isShowPassword = false;

  bool isShowConfirmPassword = false;
  // String? city;
  // List<String> dropdownItemList1 = [
  //   "city One",
  //   "city Two",
  //   "city Three",
  // ];

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  bool iagreewiththeTermsofServicePri = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch patient data when the screen is initialized
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    List<DropdownItem> countries = await PatientApiService.fetchCountries();
    setState(() {
      dropdownItems = countries;
    });
  }

  bool _isRegistering = false;

  void _registerPatient() {
    // Perform validation
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    // Check additional conditions
    bool areRequiredFieldsFilled = documentController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmpasswordController.text.isNotEmpty &&
        country?.value != null;

    if (areRequiredFieldsFilled) {
      if (isFormValid) {
        // Set _isRegistering to true to show the progress indicator
        setState(() {
          _isRegistering = true;
        });

        // Call the API to register the patient
        PatientApiService()
            .registerPatient(
          context,
          widget.email,
          passwordController.text.trim(),
          widget.firstName,
          widget.lastName,
          documentController.text.trim(),
          widget.Dob,
          widget.gender,
          widget.phoneNumber,
          country,
          cityController.text.trim(),
          licenseNumberController.text.trim(),
        )
            .then((_) {
          // Reset _isRegistering to false after registration is complete
          setState(() {
            _isRegistering = false;
          });

          // Navigate to the desired screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientLoginScreen(),
            ),
          );
        }).catchError((error) {
          // Handle errors here, if any
          setState(() {
            _isRegistering = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppLocalizations.of(context)!.errorSC}: $error'),
            ),
          );
        });
      } else {
        // Handle the case where the form fields are filled but not valid (e.g., password validation fails)
        // Optionally, show an error message for invalid fields here if needed.
      }
    } else {
      // Show error message if required fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}',
          ),
        ),
      );
    }
  }

  // void _registerPatient() {
  //   // Perform validation
  //   bool isFormValid = _formKey.currentState?.validate() ?? false;

  //   // Check additional conditions
  //   bool areAdditionalFieldsValid = documentController.text.isNotEmpty &&
  //       cityController.text.isNotEmpty &&
  //       licenseNumberController.text.isNotEmpty &&
  //       passwordController.text.isNotEmpty &&
  //       confirmpasswordController.text.isNotEmpty &&
  //       country?.value != null;

  //   if (isFormValid && areAdditionalFieldsValid) {
  //     // Set _isRegistering to true to show the progress indicator
  //     setState(() {
  //       _isRegistering = true;
  //     });

  //     // Call the API to register the patient
  //     PatientApiService()
  //         .registerPatient(
  //       context,
  //       widget.email,
  //       passwordController.text.trim(),
  //       widget.firstName,
  //       widget.lastName,
  //       documentController.text.trim(),
  //       widget.Dob,
  //       widget.gender,
  //       widget.phoneNumber,
  //       country,
  //       cityController.text.trim(),
  //       licenseNumberController.text.trim(),
  //     )
  //         .then((_) {
  //       // Reset _isRegistering to false after registration is complete
  //       setState(() {
  //         _isRegistering = false;
  //       });

  //       // Navigate to the desired screen
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PatientLoginScreen(),
  //         ),
  //       );
  //     }).catchError((error) {
  //       // Handle errors here, if any
  //       setState(() {
  //         _isRegistering = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('${AppLocalizations.of(context)!.errorSC}: $error'),
  //         ),
  //       );
  //     });
  //   } else {
  //     // Show error message if validation fails
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}',
  //         ),
  //       ),
  //     );
  //   }
  // }

  // void _registerPatient() {
  //   // Perform validation
  //   if (_formKey.currentState?.validate() ?? false) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PatientLoginScreen(),
  //         ));
  //     // The form is valid
  //     // Proceed with form submission or other actions
  //   }
  //   if (documentController.text.isEmpty ||
  //       cityController.text.isEmpty ||
  //       licenseNumberController.text.isEmpty ||
  //       passwordController.text.isEmpty ||
  //       confirmpasswordController.text.isEmpty ||
  //       country?.value == null) {
  //     // Show error message for any empty field
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //               '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}')),
  //     );
  //     return; // Exit function if validation fails
  //   }

  //   // Set _isRegistering to true to show the progress indicator
  //   setState(() {
  //     _isRegistering = true;
  //   });

  //   // Call the API to register the doctor
  //   PatientApiService()
  //       .registerPatient(
  //     context,
  //     widget.email,
  //     passwordController.text.toString(),
  //     widget.firstName,
  //     widget.lastName,
  //     documentController.text.toString(),
  //     widget.Dob,
  //     widget.gender,
  //     widget.phoneNumber,
  //     country, // Pass the DropdownItem object directly
  //     cityController.text.toString(),
  //     licenseNumberController.text.toString(),
  //   )
  //       .then((_) {
  //     // Reset _isRegistering to false after registration is complete
  //     setState(() {
  //       _isRegistering = false;
  //     });

  //     // Navigate to the desired screen
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => DoctorBottomNavigation(),
  //     //   ),
  //     // );
  //   }).catchError((error) {
  //     // Handle errors here, if any
  //     setState(() {
  //       _isRegistering = false;
  //     });
  //     print('${AppLocalizations.of(context)!.errorSC}: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _buildDoc(context),
              SizedBox(height: 20.v),
              _buildName(context),
              SizedBox(height: 21.v),

              _buildCountry(context),

              SizedBox(height: 20.v),

              _buildCity(context),
              SizedBox(height: 20.v),
              _buildPassword(context),
              SizedBox(height: 20.v),
              _buildConfirmpassword(context),
              SizedBox(height: 90.v),
              // _buildIagreewiththeTermsofServicePri(context),
              SizedBox(height: 14.v),
              _buildSendRequest(context),
              SizedBox(height: 17.v),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PatientLoginScreen())));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
                      style: CustomTextStyles.bodyMediumff000000,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.logInDoctorRegistrationSC}",
                      style: CustomTextStyles.bodyMediumff004687,
                    )
                  ],
                ),
              ),

              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "Have an account? ",
              //         style: CustomTextStyles.bodyMediumff000000,
              //       ),
              //       TextSpan(
              //         text: "Log in",
              //         style: CustomTextStyles.bodyMediumff004687,

              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.left,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70,
      leadingWidth: 375.h,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomIconButton(
                height: 40.adaptSize,
                width: 40.adaptSize,
                padding: EdgeInsets.all(10),
                decoration: IconButtonStyleHelper.outlineBlueGray,
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowLeftGray50002,
                  color: Colors.grey,
                  height: 60,
                  width: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDoc(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        controller: documentController,
        hintText:
            "${AppLocalizations.of(context)!.documentNumberDoctorProfileScrenSC}",
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        textInputType: TextInputType.number,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25.h,
          vertical: 16.v,
        ),
      ),
    );
  }

  // section
  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: DropdownButtonFormField<DropdownItem>(
        decoration: InputDecoration(
          hintText:
              '${AppLocalizations.of(context)!.selectCountryDoctorRegistration2SC}',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        value: country,
        items: dropdownItems.map((item) {
          return DropdownMenuItem<DropdownItem>(
            value: item,
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            country = selectedItem;
          });
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        controller: licenseNumberController,
        hintText:
            "${AppLocalizations.of(context)!.licenseNumberDoctorRegistration2SC}",
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        textInputType: TextInputType.number,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25.h,
          vertical: 16.v,
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildPassword(BuildContext context) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     child: CustomTextFormField(
  //       borderDecoration: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.h),
  //         borderSide: BorderSide(
  //           color: Colors.grey.shade300,
  //           width: 1,
  //         ),
  //       ),
  //       controller: passwordController,
  //       hintText:
  //           "${AppLocalizations.of(context)!.passwordDoctorRegistration2SC}",
  //       hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
  //       textInputType: TextInputType.visiblePassword,
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
  //             color: Color(0xff677294),
  //           )),
  //       suffixConstraints: BoxConstraints(
  //         maxHeight: 54.v,
  //       ),
  //       obscureText: !isShowPassword,
  //     ),
  //   );
  // }

//new password validation use

  Widget _buildPassword(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        controller: passwordController,
        hintText: AppLocalizations.of(context)!.passwordDoctorRegistration2SC,
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        textInputType: TextInputType.visiblePassword,
        suffix: IconButton(
          onPressed: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
          icon: Icon(
            isShowPassword ? Icons.visibility : Icons.visibility_off,
            color: Color(0xff677294),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 54.v,
        ),
        obscureText: !isShowPassword,
        validator: (value) {
          // Check if value is null or empty
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          // Check password length
          if (value.length < 8) {
            return 'Password must be at least 8 characters long';
          }

          // Check for at least one lowercase letter
          if (!RegExp(r'[a-z]').hasMatch(value)) {
            return 'Password must contain at least one lowercase letter';
          }

          // Check for at least one uppercase letter
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return 'Password must contain at least one uppercase letter';
          }

          // Check for at least one number
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return 'Password must contain at least one number';
          }

          // Check for at least one special character
          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
            return 'Password must contain at least one symbol';
          }

          // Check if the password contains the email
          if (widget.email.isNotEmpty && value.contains(widget.email)) {
            return 'Password cannot contain the username';
          }

          return null; // Return null if the password is valid
        },
        onChanged: (value) {
          // Trigger validation when the text changes
          _formKey.currentState?.validate();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmpassword(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        controller: confirmpasswordController,
        hintText:
            "${AppLocalizations.of(context)!.confirmPasswordDoctorRegistration2SC}",
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: IconButton(
          onPressed: () {
            setState(() {
              isShowConfirmPassword = !isShowConfirmPassword;
            });
          },
          icon: Icon(
            isShowConfirmPassword ? Icons.visibility : Icons.visibility_off,
            color: Color(0xff677294),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 54.v,
        ),
        obscureText: !isShowConfirmPassword,
        validator: (value) {
          // Check if value is null or empty
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          // Check password length
          if (value.length < 8) {
            return 'Password must be at least 8 characters long';
          }

          // Check for at least one lowercase letter
          if (!RegExp(r'[a-z]').hasMatch(value)) {
            return 'Password must contain at least one lowercase letter';
          }

          // Check for at least one uppercase letter
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return 'Password must contain at least one uppercase letter';
          }

          // Check for at least one number
          if (!RegExp(r'[0-9]').hasMatch(value)) {
            return 'Password must contain at least one number';
          }

          // Check for at least one special character
          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
            return 'Password must contain at least one symbol';
          }

          // Check if the password contains the email
          if (widget.email.isNotEmpty && value.contains(widget.email)) {
            return 'Password cannot contain the username';
          }

          // Check if password and confirm password match
          if (passwordController.text != value) {
            return 'Passwords do not match';
          }

          return null; // Return null if the confirmation password is valid
        },
        onChanged: (value) {
          // Trigger validation when the text changes
          _formKey.currentState?.validate();
        },
      ),
    );
  }

  /// Section Widget
  // Widget _buildIagreewiththeTermsofServicePri(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: 50.h,
  //       right: 64.h,
  //     ),
  //     child: CustomCheckboxButton(
  //       text: "I agree Terms of Service & Privacy Policy",
  //       value: iagreewiththeTermsofServicePri,
  //       onChange: (value) {
  //         setState(() {
  //           iagreewiththeTermsofServicePri = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  // build city
  // build city field
//   Widget _buildCity(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 19),
//     child: CustomTextFormField(
//       controller: cityController,
//       hintText: "City",
//       textInputType: TextInputType.text,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//       ],
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 25.h,
//         vertical: 16.v,
//       ),
//       borderDecoration: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
//       ),
//     ),
//   );
// }
  // here add number in field
  Widget _buildCity(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: CustomTextFormField(
        controller: cityController,
        hintText: "${AppLocalizations.of(context)!.cityDoctorProfileScrenSC}",
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        textInputType: TextInputType.name,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25.h,
          vertical: 16.v,
        ),
        borderDecoration: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
      ),
    );
  }

  /// Section Widget
  Widget _buildSendRequest(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: _isRegistering ? null : _registerPatient,
            child: _isRegistering
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    '${AppLocalizations.of(context)!.signupDoctorRegistration2SC}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        ),
      ],
    );
    // CustomElevatedButton(
    //   width: MediaQuery.of(context).size.width * 0.8,
    //   onPressed: () async {
    //    if (documentController.text.isEmpty ||
    //     cityController.text.isEmpty ||
    //     licenseNumberController.text.isEmpty ||
    //     passwordController.text.isEmpty ||
    //     confirmpasswordController.text.isEmpty ||
    //     country?.value == null) {
    //   // Show error message for any empty field
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill in all fields')),
    //   );
    //   return; // Exit function if validation fails
    // }

    //  setState(() {
    //   _isRegistering = true;
    // });

    //     await PatientApiService().registerPatient(
    //       context,
    //       widget.email,
    //       passwordController.text.toString(),
    //       widget.firstName,
    //       widget.lastName,
    //       documentController.text.toString(),
    //       widget.Dob,
    //       widget.gender,
    //       widget.phoneNumber,
    //       country, // Pass the DropdownItem object directly
    //       cityController.text.toString(),
    //       licenseNumberController.text.toString(),
    //     ).then((_) {
    //   // Reset _isRegistering to false after registration is complete
    //   setState(() {
    //     _isRegistering = false;
    //   });
    //     }).catchError((error) {
    //   // Handle errors here, if any
    //   setState(() {
    //     _isRegistering = false;
    //   });
    //   print('Error: $error');
    // });

    //     debugPrint("first Name: ${widget.firstName}");
    //     debugPrint("last Name: ${widget.lastName}");

    //     debugPrint("Birthday: ${widget.Dob}");

    //     debugPrint("gender: ${widget.gender}");
    //     debugPrint("phone number: ${widget.phoneNumber}");
    //     debugPrint("email: ${widget.email}");
    //     debugPrint("document id: ${documentController.text.toString()}");
    //     debugPrint(
    //         "lisence number: ${licenseNumberController.text.toString()}");
    //     debugPrint("country: ${country}");
    //     debugPrint("city: ${cityController.text.toString()}");
    //     debugPrint("document id: ${passwordController.text.toString()}");
    //     debugPrint("document id: ${confirmpasswordController.text.toString()}");
    //   },
    //   text: "Sign Up",
    //   margin: EdgeInsets.symmetric(horizontal: 20.h),
    //   buttonStyle: CustomButtonStyles.fillPrimary,
    //   buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
    // );
  }
}

// Define a custom class to represent each dropdown item
class DropdownItem {
  final String value;
  final String label;

  DropdownItem({
    required this.value,
    required this.label,
  });
}
