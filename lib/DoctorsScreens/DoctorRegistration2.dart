import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_drop_down.dart';
import 'package:doctari/widgets/custom_checkbox_button.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

import '../doctorAPI/doctor_api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorRegistration2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String dob;
  final String specilization;
  final String phoneNumber;
  final String gender;

  DoctorRegistration2(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.dob,
      required this.gender,
      required this.phoneNumber,
      required this.specilization})
      : super(
          key: key,
        );

  @override
  State<DoctorRegistration2> createState() => _DoctorRegistration2State();
}

class _DoctorRegistration2State extends State<DoctorRegistration2> {
  TextEditingController docController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController licenseController = TextEditingController();

  DropdownItem? country;
  List<DropdownItem> dropdownItems = [];

  String selectedCity = '';

  bool isShowPassword = false;

  bool isShowConfirmPassword = false;

  // List<String> dropdownItemListCity = [
  //   "Item One",
  //   "Item Two",
  //   "Item Three",
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
  void _registerDoctor() {
    // Perform validation
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    // Check additional conditions
    bool areRequiredFieldsFilled = docController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        licenseController.text.isNotEmpty &&
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
        DoctorApiService()
            .registerDoctor(
          context,
          widget.email,
          passwordController.text.toString(),
          widget.firstName,
          widget.lastName,
          docController.text.toString(),
          widget.dob,
          widget.gender,
          widget.phoneNumber,
          country,
          cityController.text.toString(),
          licenseController.text.toString(),
          widget.specilization,
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
                builder: (context) => LoginScreen(),
              ));
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

    // if (docController.text.isEmpty ||
    //     cityController.text.isEmpty ||
    //     licenseController.text.isEmpty ||
    //     passwordController.text.isEmpty ||
    //     confirmpasswordController.text.isEmpty ||
    //     country?.value == null) {
    //   // Show error message for any empty field
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Text(
    //             '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}')),
    //   );
    //   return; // Exit function if validation fails
    // }

    // // Set _isRegistering to true to show the progress indicator
    // setState(() {
    //   _isRegistering = true;
    // });

    // // Call the API to register the doctor
    // DoctorApiService()
    //     .registerDoctor(
    //   context,
    //   widget.email,
    //   passwordController.text.toString(),
    //   widget.firstName,
    //   widget.lastName,
    //   docController.text.toString(),
    //   widget.dob,
    //   widget.gender,
    //   widget.phoneNumber,
    //   country,
    //   cityController.text.toString(),
    //   licenseController.text.toString(),
    //   widget.specilization,
    // )
    //     .then((_) {
    //   // Reset _isRegistering to false after registration is complete
    //   setState(() {
    //     _isRegistering = false;
    //   });

    //   // Navigate to the desired screen
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => DoctorBottomNavigation(),
    //   //   ),
    //   // );
    // }).catchError((error) {
    //   // Handle errors here, if any
    //   setState(() {
    //     _isRegistering = false;
    //   });
    //   print('Error: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
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
                  vertical: 21.v,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 19.v),
                    _buildDocument(context),
                    SizedBox(height: 20.v),
                    _buildName(context),
                    SizedBox(height: 21.v),
                    _buildCountry(context),

                    // DropdownButtonFormField<DropdownItem>(
                    //   decoration: InputDecoration(
                    //     hintText: 'Country',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide(
                    //         color: Colors.grey.withOpacity(0.6),
                    //         width: 1,
                    //       ),
                    //     ),
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    //   ),
                    //   value: country,
                    //   items: dropdownItemList.map((item) {
                    //     return DropdownMenuItem<DropdownItem>(
                    //       value: item,
                    //       child: Text(
                    //         item.label,
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    //   onChanged: (selectedItem) {
                    //     setState(() {
                    //       country =
                    //           selectedItem; // Assign the selected item directly
                    //       debugPrint(
                    //           "Selected country value: ${country!.value}");
                    //     });
                    //   },
                    // ),

                    SizedBox(height: 20.v),

                    // CustomDropDown(
                    //   hintText: "City",
                    //   hintStyle: TextStyle(
                    //       fontWeight: FontWeight.w300,
                    //       color: Colors.grey.shade500),
                    //   items: dropdownItemListCity,
                    //   onChanged: (value) {
                    //     selectedCity = value;
                    //   },
                    // ),
                    _buildCity(context),
                    SizedBox(height: 20.v),
                    _buildPassword(context),
                    SizedBox(height: 20.v),
                    _buildConfirmpassword(context),
                    SizedBox(height: 90.v),
                    _buildIagreewiththeTermsofServicePri(context),
                    SizedBox(height: 14.v),
                    _buildSendRequest(context),
                    SizedBox(height: 17.v),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
                            style: CustomTextStyles.bodyMediumff000000,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.logInDoctorRegistrationSC}",
                              style: CustomTextStyles.bodyMediumff004687,
                            ),
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
  Widget _buildDocument(BuildContext context) {
    return CustomTextFormField(
      controller: docController,
      hintText:
          "${AppLocalizations.of(context)!.documentNumberSignUpScreenOnePatientSC}",
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
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
    );
  }

// build city field
  Widget _buildCity(BuildContext context) {
    return CustomTextFormField(
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
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: licenseController,
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
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
    );
  }

  // build country
  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField<DropdownItem>(
        isExpanded: true,
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
          //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

  // Widget _buildPassword(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: passwordController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.passwordDoctorRegistration2SC}",
  //     borderDecoration: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
  //     hintStyle:
  //         TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
  //     textInputType: TextInputType.visiblePassword,
  //     suffix: IconButton(
  //         onPressed: () {
  //           if (isShowPassword) {
  //             isShowPassword = false;
  //           } else {
  //             isShowPassword = true;
  //           }
  //           setState(() {});
  //         },
  //         icon: Icon(
  //           isShowPassword ? Icons.visibility : Icons.visibility_off,
  //           color: Color(0xff677294),
  //         )),
  //     suffixConstraints: BoxConstraints(
  //       maxHeight: 54.v,
  //     ),
  //     obscureText: !isShowPassword,
  //   );
  // }

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

  // Widget _buildConfirmpassword(BuildContext context) {
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
  //       controller: confirmpasswordController,
  //       hintText:
  //           "${AppLocalizations.of(context)!.confirmPasswordDoctorRegistration2SC}",
  //       hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
  //       textInputAction: TextInputAction.done,
  //       textInputType: TextInputType.visiblePassword,
  //       suffix: IconButton(
  //           onPressed: () {
  //             if (isShowConfirmPassword) {
  //               isShowConfirmPassword = false;
  //             } else {
  //               isShowConfirmPassword = true;
  //             }
  //             setState(() {});
  //           },
  //           icon: Icon(
  //             isShowConfirmPassword ? Icons.visibility : Icons.visibility_off,
  //             color: Color(0xff677294),
  //           )),
  //       suffixConstraints: BoxConstraints(
  //         maxHeight: 54.v,
  //       ),
  //       obscureText: !isShowConfirmPassword,
  //       validator: (value) {
  //         // Check if value is null or empty
  //         if (value == null || value.isEmpty) {
  //           return 'Please enter a password';
  //         }

  //         // Check password length
  //         if (value.length < 8) {
  //           return 'Password must be at least 8 characters long';
  //         }

  //         // Check for at least one lowercase letter
  //         if (!RegExp(r'[a-z]').hasMatch(value)) {
  //           return 'Password must contain at least one lowercase letter';
  //         }

  //         // Check for at least one uppercase letter
  //         if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //           return 'Password must contain at least one uppercase letter';
  //         }

  //         // Check for at least one number
  //         if (!RegExp(r'[0-9]').hasMatch(value)) {
  //           return 'Password must contain at least one number';
  //         }

  //         // Check for at least one special character
  //         if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
  //           return 'Password must contain at least one symbol';
  //         }

  //         // Check if the password contains the email
  //         if (widget.email.isNotEmpty && value.contains(widget.email)) {
  //           return 'Password cannot contain the username';
  //         }

  //         return null; // Return null if the password is valid
  //       },
  //       onChanged: (value) {
  //         // Trigger validation when the text changes
  //         _formKey.currentState?.validate();
  //       },
  //     ),
  //   );
  // }

  // Widget _buildConfirmpassword(BuildContext context) {
  //   return CustomTextFormField(
  //     hintStyle:
  //         TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
  //     controller: confirmpasswordController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.confirmPasswordDoctorRegistration2SC}",
  //     textInputAction: TextInputAction.done,
  //     textInputType: TextInputType.visiblePassword,
  //     suffix: IconButton(
  //         onPressed: () {
  //           if (isShowConfirmPassword) {
  //             isShowConfirmPassword = false;
  //           } else {
  //             isShowConfirmPassword = true;
  //           }
  //           setState(() {});
  //         },
  //         icon: Icon(
  //           isShowConfirmPassword ? Icons.visibility : Icons.visibility_off,
  //           color: Color(0xff677294),
  //         )),
  //     suffixConstraints: BoxConstraints(
  //       maxHeight: 54.v,
  //     ),
  //     obscureText: !isShowConfirmPassword,
  //   );
  // }

  /// Section Widget
  Widget _buildIagreewiththeTermsofServicePri(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25.h,
        right: 32.h,
      ),
      child: CustomCheckboxButton(
        text:
            "${AppLocalizations.of(context)!.termandServicesDoctorRegistration2SC}",
        value: iagreewiththeTermsofServicePri,
        onChange: (value) {
          setState(() {
            iagreewiththeTermsofServicePri = value;
          });
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSendRequest(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: _isRegistering ? null : _registerDoctor,
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
        ),
      ],
    );
    // CustomElevatedButton(
    //   // onPressed: () {
    //   //   Navigator.push(
    //   //       context,
    //   //       MaterialPageRoute(
    //   //         builder: (context) => LoginScreen(),
    //   //       ));
    //   //   DoctorApiService().registerDoctor(
    //   //       context,
    //   //       widget.email,
    //   //       passwordController.text.toString(),
    //   //       widget.firstName,
    //   //       widget.lastName,
    //   //       docController.text.toString(),
    //   //       widget.dob,
    //   //       widget.gender,
    //   //       widget.phoneNumber,
    //   //       country,
    //   //       cityController.text.toString(),
    //   //       licenseController.text.toString(),
    //   //       widget.specilization);
    //   //   debugPrint("country: ${country!.value}");
    //   //   debugPrint(
    //   //     cityController.text.toString(),
    //   //   );
    //   //   debugPrint(licenseController.text.toString());
    //   //   debugPrint(passwordController.text.toString());

    //   //   // Navigator.push(
    //   //   //     context,
    //   //   //     MaterialPageRoute(
    //   //   //       builder: (context) => DoctorBottomNavigation(),
    //   //   //     ));
    //   // },
    //     onPressed: _isRegistering ? null : _registerDoctor,

    //   text: "Sign Up",
    //   margin: EdgeInsets.symmetric(horizontal: 20.h),
    //   buttonStyle: CustomButtonStyles.fillPrimary,
    //   buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
    // );
  }
}





// import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
// import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
// import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
// import 'package:doctari/widgets/custom_icon_button.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:doctari/widgets/custom_drop_down.dart';
// import 'package:doctari/widgets/custom_checkbox_button.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// import '../doctorAPI/doctor_api_service.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class DoctorRegistration2 extends StatefulWidget {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String dob;
//   final String specilization;
//   final String phoneNumber;
//   final String gender;

//   DoctorRegistration2(
//       {Key? key,
//       required this.firstName,
//       required this.lastName,
//       required this.email,
//       required this.dob,
//       required this.gender,
//       required this.phoneNumber,
//       required this.specilization})
//       : super(
//           key: key,
//         );

//   @override
//   State<DoctorRegistration2> createState() => _DoctorRegistration2State();
// }

// class _DoctorRegistration2State extends State<DoctorRegistration2> {
//   TextEditingController docController = TextEditingController();
//   TextEditingController cityController = TextEditingController();

//   TextEditingController licenseController = TextEditingController();

//   DropdownItem? country;
//   List<DropdownItem> dropdownItems = [];

//   String selectedCity = '';

//   bool isShowPassword = false;

//   bool isShowConfirmPassword = false;

//   // List<String> dropdownItemListCity = [
//   //   "Item One",
//   //   "Item Two",
//   //   "Item Three",
//   // ];

//   TextEditingController passwordController = TextEditingController();

//   TextEditingController confirmpasswordController = TextEditingController();

//   bool iagreewiththeTermsofServicePri = false;

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch patient data when the screen is initialized
//     _fetchCountries();
//   }

//   Future<void> _fetchCountries() async {
//     List<DropdownItem> countries = await PatientApiService.fetchCountries();
//     setState(() {
//       dropdownItems = countries;
//     });
//   }

//   bool _isRegistering = false;
//   void _registerDoctor() {
//     // Perform validation
//     if (docController.text.isEmpty ||
//         cityController.text.isEmpty ||
//         licenseController.text.isEmpty ||
//         passwordController.text.isEmpty ||
//         confirmpasswordController.text.isEmpty ||
//         country?.value == null) {
//       // Show error message for any empty field
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}')),
//       );
//       return; // Exit function if validation fails
//     }

//     // Set _isRegistering to true to show the progress indicator
//     setState(() {
//       _isRegistering = true;
//     });

//     // Call the API to register the doctor
//     DoctorApiService()
//         .registerDoctor(
//       context,
//       widget.email,
//       passwordController.text.toString(),
//       widget.firstName,
//       widget.lastName,
//       docController.text.toString(),
//       widget.dob,
//       widget.gender,
//       widget.phoneNumber,
//       country,
//       cityController.text.toString(),
//       licenseController.text.toString(),
//       widget.specilization,
//     )
//         .then((_) {
//       // Reset _isRegistering to false after registration is complete
//       setState(() {
//         _isRegistering = false;
//       });

//       // Navigate to the desired screen
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => DoctorBottomNavigation(),
//       //   ),
//       // );
//     }).catchError((error) {
//       // Handle errors here, if any
//       setState(() {
//         _isRegistering = false;
//       });
//       print('${AppLocalizations.of(context)!.errorSC}: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _buildAppBar(context),
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
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20.h,
//                   vertical: 21.v,
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 19.v),
//                     _buildDocument(context),
//                     SizedBox(height: 20.v),
//                     _buildName(context),
//                     SizedBox(height: 21.v),
//                     _buildCountry(context),

//                     // DropdownButtonFormField<DropdownItem>(
//                     //   decoration: InputDecoration(
//                     //     hintText: 'Country',
//                     //     border: OutlineInputBorder(
//                     //       borderRadius: BorderRadius.circular(12),
//                     //       borderSide: BorderSide(
//                     //         color: Colors.grey.withOpacity(0.6),
//                     //         width: 1,
//                     //       ),
//                     //     ),
//                     //     contentPadding:
//                     //         EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     //   ),
//                     //   value: country,
//                     //   items: dropdownItemList.map((item) {
//                     //     return DropdownMenuItem<DropdownItem>(
//                     //       value: item,
//                     //       child: Text(
//                     //         item.label,
//                     //         style: TextStyle(
//                     //           fontSize: 16,
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),
//                     //     );
//                     //   }).toList(),
//                     //   onChanged: (selectedItem) {
//                     //     setState(() {
//                     //       country =
//                     //           selectedItem; // Assign the selected item directly
//                     //       debugPrint(
//                     //           "Selected country value: ${country!.value}");
//                     //     });
//                     //   },
//                     // ),

//                     SizedBox(height: 20.v),

//                     // CustomDropDown(
//                     //   hintText: "City",
//                     //   hintStyle: TextStyle(
//                     //       fontWeight: FontWeight.w300,
//                     //       color: Colors.grey.shade500),
//                     //   items: dropdownItemListCity,
//                     //   onChanged: (value) {
//                     //     selectedCity = value;
//                     //   },
//                     // ),
//                     _buildCity(context),
//                     SizedBox(height: 20.v),
//                     _buildPassword(context),
//                     SizedBox(height: 20.v),
//                     _buildConfirmpassword(context),
//                     SizedBox(height: 90.v),
//                     _buildIagreewiththeTermsofServicePri(context),
//                     SizedBox(height: 14.v),
//                     _buildSendRequest(context),
//                     SizedBox(height: 17.v),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ));
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
//                             style: CustomTextStyles.bodyMediumff000000,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => LoginScreen(),
//                                   ));
//                             },
//                             child: Text(
//                               "${AppLocalizations.of(context)!.logInDoctorRegistrationSC}",
//                               style: CustomTextStyles.bodyMediumff004687,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),

//                     // RichText(
//                     //   text: TextSpan(
//                     //     children: [
//                     //       TextSpan(
//                     //         text: "Have an account? ",
//                     //         style: CustomTextStyles.bodyMediumff000000,
//                     //       ),
//                     //       TextSpan(
//                     //         text: "Log in",
//                     //         style: CustomTextStyles.bodyMediumff004687,

//                     //       ),
//                     //     ],
//                     //   ),
//                     //   textAlign: TextAlign.left,
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       height: 70,
//       leadingWidth: 375.h,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: CustomIconButton(
//                 height: 40.adaptSize,
//                 width: 40.adaptSize,
//                 padding: EdgeInsets.all(10),
//                 decoration: IconButtonStyleHelper.outlineBlueGray,
//                 child: CustomImageView(
//                   imagePath: ImageConstant.imgArrowLeftGray50002,
//                   color: Colors.grey,
//                   height: 60,
//                   width: 60,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildDocument(BuildContext context) {
//     return CustomTextFormField(
//       controller: docController,
//       hintText:
//           "${AppLocalizations.of(context)!.documentNumberDoctorProfileScrenSC}",
//       textInputType: TextInputType.number,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 25.h,
//         vertical: 16.v,
//       ),
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
//     );
//   }

// // build city field
//   Widget _buildCity(BuildContext context) {
//     return CustomTextFormField(
//       controller: cityController,
//       hintText: "${AppLocalizations.of(context)!.cityDoctorProfileScrenSC}",
//       textInputType: TextInputType.name,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 25.h,
//         vertical: 16.v,
//       ),
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
//     );
//   }

//   /// Section Widget
//   Widget _buildName(BuildContext context) {
//     return CustomTextFormField(
//       controller: licenseController,
//       hintText:
//           "${AppLocalizations.of(context)!.licenseNumberDoctorRegistration2SC}",
//       textInputType: TextInputType.number,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: 25.h,
//         vertical: 16.v,
//       ),
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
//     );
//   }

//   // build country
//   Widget _buildCountry(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0),
//       child: DropdownButtonFormField<DropdownItem>(
//         decoration: InputDecoration(
//           hintText:
//               '${AppLocalizations.of(context)!.selectCountryDoctorRegistration2SC}',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: Colors.grey.withOpacity(0.6),
//               width: 1,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//         value: country,
//         items: dropdownItems.map((item) {
//           return DropdownMenuItem<DropdownItem>(
//             value: item,
//             child: Text(
//               item.label,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           );
//         }).toList(),
//         onChanged: (selectedItem) {
//           setState(() {
//             country = selectedItem;
//           });
//         },
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildPassword(BuildContext context) {
//     return CustomTextFormField(
//       controller: passwordController,
//       hintText:
//           "${AppLocalizations.of(context)!.passwordDoctorRegistration2SC}",
//       borderDecoration: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
//       hintStyle:
//           TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
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
//     );
//   }

//   /// Section Widget
//   Widget _buildConfirmpassword(BuildContext context) {
//     return CustomTextFormField(
//       hintStyle:
//           TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
//       controller: confirmpasswordController,
//       hintText:
//           "${AppLocalizations.of(context)!.confirmPasswordDoctorRegistration2SC}",
//       textInputAction: TextInputAction.done,
//       textInputType: TextInputType.visiblePassword,
//       suffix: IconButton(
//           onPressed: () {
//             if (isShowConfirmPassword) {
//               isShowConfirmPassword = false;
//             } else {
//               isShowConfirmPassword = true;
//             }
//             setState(() {});
//           },
//           icon: Icon(
//             isShowConfirmPassword ? Icons.visibility : Icons.visibility_off,
//             color: Color(0xff677294),
//           )),
//       suffixConstraints: BoxConstraints(
//         maxHeight: 54.v,
//       ),
//       obscureText: !isShowConfirmPassword,
//     );
//   }

//   /// Section Widget
//   Widget _buildIagreewiththeTermsofServicePri(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 25.h,
//         right: 32.h,
//       ),
//       child: CustomCheckboxButton(
//         text:
//             "${AppLocalizations.of(context)!.termandServicesDoctorRegistration2SC}",
//         value: iagreewiththeTermsofServicePri,
//         onChange: (value) {
//           setState(() {
//             iagreewiththeTermsofServicePri = value;
//           });
//         },
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildSendRequest(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 50,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.blue),
//                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)))),
//               onPressed: _isRegistering ? null : _registerDoctor,
//               child: _isRegistering
//                   ? CircularProgressIndicator(
//                       color: Colors.white,
//                     )
//                   : Text(
//                       '${AppLocalizations.of(context)!.signupDoctorRegistration2SC}',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//     // CustomElevatedButton(
//     //   // onPressed: () {
//     //   //   Navigator.push(
//     //   //       context,
//     //   //       MaterialPageRoute(
//     //   //         builder: (context) => LoginScreen(),
//     //   //       ));
//     //   //   DoctorApiService().registerDoctor(
//     //   //       context,
//     //   //       widget.email,
//     //   //       passwordController.text.toString(),
//     //   //       widget.firstName,
//     //   //       widget.lastName,
//     //   //       docController.text.toString(),
//     //   //       widget.dob,
//     //   //       widget.gender,
//     //   //       widget.phoneNumber,
//     //   //       country,
//     //   //       cityController.text.toString(),
//     //   //       licenseController.text.toString(),
//     //   //       widget.specilization);
//     //   //   debugPrint("country: ${country!.value}");
//     //   //   debugPrint(
//     //   //     cityController.text.toString(),
//     //   //   );
//     //   //   debugPrint(licenseController.text.toString());
//     //   //   debugPrint(passwordController.text.toString());

//     //   //   // Navigator.push(
//     //   //   //     context,
//     //   //   //     MaterialPageRoute(
//     //   //   //       builder: (context) => DoctorBottomNavigation(),
//     //   //   //     ));
//     //   // },
//     //     onPressed: _isRegistering ? null : _registerDoctor,

//     //   text: "Sign Up",
//     //   margin: EdgeInsets.symmetric(horizontal: 20.h),
//     //   buttonStyle: CustomButtonStyles.fillPrimary,
//     //   buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
//     // );
//   }
// }
