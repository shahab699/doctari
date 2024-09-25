// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
// import 'package:doctari/widgets/app_bar/appbar_subtitle_nine.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// // ignore_for_file: must_be_immutable
// class PatientSettingScreen extends StatefulWidget {
//   final String token;
//   PatientSettingScreen({required this.token, Key? key}) : super(key: key);

//   @override
//   State<PatientSettingScreen> createState() => _PatientSettingScreenState();
// }

// class _PatientSettingScreenState extends State<PatientSettingScreen> {
//   TextEditingController passwordController = TextEditingController();

//   TextEditingController newpasswordController = TextEditingController();

//   TextEditingController confirmpasswordController = TextEditingController();

//   bool currentPassword = false;

//   bool newPassword = false;

//   bool confirmPassword = false;

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(
//                 "Settings",
//                 style: CustomTextStyles.titleLargeBluegray800.copyWith(
//                   color: appTheme.blueGray800,
//                 ),
//               ),
//             ),
//             body: SizedBox(
//                 width: SizeUtils.width,
//                 child: SingleChildScrollView(
//                     padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom),
//                     child: Form(
//                         key: _formKey,
//                         child: Container(
//                             width: 375.h,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20.h, vertical: 25.v),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Change Password",
//                                       style:
//                                           CustomTextStyles.titleLargeBlack900),
//                                   SizedBox(height: 26.v),
//                                   _buildPassword(context),
//                                   SizedBox(height: 17.v),
//                                   _buildNewpassword(context),
//                                   SizedBox(height: 20.v),
//                                   _buildConfirmpassword(context),
//                                   SizedBox(height: 5.v)
//                                 ]))))),
//             bottomNavigationBar: _buildChangePassword(context)));
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//         height: 70.v,
//         leadingWidth: 50.h,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.grey,
//               size: 20,
//             )),
//         title: AppbarSubtitleNine(
//             text: "Settings", margin: EdgeInsets.only(left: 19.h)));
//   }

//   /// Section Widget
//   Widget _buildPassword(BuildContext context) {
//     return CustomTextFormField(
//         controller: passwordController,
//         hintText: "Current Password",
//         hintStyle: CustomTextStyles.titleMediumBluegray500,
//         textInputType: TextInputType.visiblePassword,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter your Current password';
//           }
//           return null;
//         },
//         suffix: IconButton(
//             onPressed: () {
//               if (currentPassword) {
//                 currentPassword = false;
//               } else {
//                 currentPassword = true;
//               }
//               setState(() {});
//             },
//             icon: Icon(
//               currentPassword ? Icons.visibility : Icons.visibility_off,
//               color: Color(0xff677294),
//             )),
//         suffixConstraints: BoxConstraints(maxHeight: 54.v),
//         obscureText: !currentPassword);
//   }

//   /// Section Widget
//   Widget _buildNewpassword(BuildContext context) {
//     return CustomTextFormField(
//         controller: newpasswordController,
//         hintText: "New Password",
//         hintStyle: CustomTextStyles.titleMediumBluegray500,
//         textInputType: TextInputType.visiblePassword,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter your New password';
//           }
//           return null;
//         },
//         suffix: IconButton(
//             onPressed: () {
//               if (newPassword) {
//                 newPassword = false;
//               } else {
//                 newPassword = true;
//               }
//               setState(() {});
//             },
//             icon: Icon(
//               newPassword ? Icons.visibility : Icons.visibility_off,
//               color: Color(0xff677294),
//             )),
//         suffixConstraints: BoxConstraints(maxHeight: 54.v),
//         obscureText: !newPassword);
//   }

//   /// Section Widget
//   Widget _buildConfirmpassword(BuildContext context) {
//     return CustomTextFormField(
//         controller: confirmpasswordController,
//         hintText: "Confirm Password",
//         hintStyle: CustomTextStyles.titleMediumBluegray500,
//         textInputAction: TextInputAction.done,
//         textInputType: TextInputType.visiblePassword,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter your New password again';
//           }
//           return null;
//         },
//         suffix: IconButton(
//             onPressed: () {
//               if (confirmPassword) {
//                 confirmPassword = false;
//               } else {
//                 confirmPassword = true;
//               }
//               setState(() {});
//             },
//             icon: Icon(
//               confirmPassword ? Icons.visibility : Icons.visibility_off,
//               color: Color(0xff677294),
//             )),
//         suffixConstraints: BoxConstraints(maxHeight: 54.v),
//         obscureText: !confirmPassword);
//   }

//   /// Section Widget
//   Widget _buildChangePassword(BuildContext context) {
//     return CustomElevatedButton(
//         height: 54.v,
//         text: "Change Password",
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             //    PatientApiService().changePassword(
//             //   context,
//             //   passwordController.text,
//             //   newPassword.toString(),
//             //   widget.token,
//             // );
//             print('click');
//           }
//         },
//         margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 27.v),
//         buttonStyle: CustomButtonStyles.fillPrimary,
//         buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_1);
//   }
// }

import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_nine.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientSettingScreen extends StatefulWidget {
  final String token;
  PatientSettingScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<PatientSettingScreen> createState() => _PatientSettingScreenState();
}

class _PatientSettingScreenState extends State<PatientSettingScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  bool currentPassword = false;
  bool newPassword = false;
  bool confirmPassword = false;
  bool isLoadingButton = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "${AppLocalizations.of(context)!.settingsSettingScreenSC}",
                style: CustomTextStyles.titleLargeBluegray800.copyWith(
                  color: appTheme.blueGray800,
                ),
              ),
            ),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: 375.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 25.v),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}",
                                      style:
                                          CustomTextStyles.titleLargeBlack900),
                                  SizedBox(height: 26.v),
                                  _buildPassword(context),
                                  SizedBox(height: 17.v),
                                  _buildNewpassword(context),
                                  SizedBox(height: 20.v),
                                  _buildConfirmpassword(context),
                                  SizedBox(height: 5.v)
                                ]))))),
            bottomNavigationBar: _buildChangePassword(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 70.v,
        leadingWidth: 50.h,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            )),
        title: AppbarSubtitleNine(
            text: "${AppLocalizations.of(context)!.settingsSettingScreenSC}",
            margin: EdgeInsets.only(left: 19.h)));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText:
            "${AppLocalizations.of(context)!.currentPasswordSettingScreenSC}",
        hintStyle: CustomTextStyles.titleMediumBluegray500,
        textInputType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${AppLocalizations.of(context)!.enterCurrentPasswordSettingScreenSC}';
          }
          return null;
        },
        suffix: IconButton(
            onPressed: () {
              if (currentPassword) {
                currentPassword = false;
              } else {
                currentPassword = true;
              }
              setState(() {});
            },
            icon: Icon(
              currentPassword ? Icons.visibility : Icons.visibility_off,
              color: Color(0xff677294),
            )),
        suffixConstraints: BoxConstraints(maxHeight: 54.v),
        obscureText: !currentPassword);
  }

  /// Section Widget
  // Widget _buildNewpassword(BuildContext context) {
  //   return CustomTextFormField(
  //       controller: newpasswordController,
  //       hintText: "${AppLocalizations.of(context)!.newPasswordSettingScreenSC}",
  //       hintStyle: CustomTextStyles.titleMediumBluegray500,
  //       textInputType: TextInputType.visiblePassword,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return '${AppLocalizations.of(context)!.enterNewPasswordSettingScreenSC}';
  //         }
  //         return null;
  //       },
  //       suffix: IconButton(
  //           onPressed: () {
  //             if (newPassword) {
  //               newPassword = false;
  //             } else {
  //               newPassword = true;
  //             }
  //             setState(() {});
  //           },
  //           icon: Icon(
  //             newPassword ? Icons.visibility : Icons.visibility_off,
  //             color: Color(0xff677294),
  //           )),
  //       suffixConstraints: BoxConstraints(maxHeight: 54.v),
  //       obscureText: !newPassword);
  // }

  //New Validation of password use here

  Widget _buildNewpassword(BuildContext context) {
    return CustomTextFormField(
      controller: newpasswordController,
      hintText: "${AppLocalizations.of(context)!.newPasswordSettingScreenSC}",
      hintStyle: CustomTextStyles.titleMediumBluegray500,
      textInputType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${AppLocalizations.of(context)!.enterNewPasswordSettingScreenSC}';
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
          return 'Password must contain at least one special character';
        }

        // Check if the password contains the username
        // if (widget.email.isNotEmpty && value.contains(widget.email)) {
        //   return 'Password cannot contain the username';
        // }

        return null; // Return null if the password is valid
      },
      suffix: IconButton(
        onPressed: () {
          setState(() {
            newPassword = !newPassword;
          });
        },
        icon: Icon(
          newPassword ? Icons.visibility : Icons.visibility_off,
          color: Color(0xff677294),
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 54.v),
      obscureText: !newPassword,
    );
  }

//New validation for confirm password use here

  Widget _buildConfirmpassword(BuildContext context) {
    return CustomTextFormField(
      controller: confirmpasswordController,
      hintText:
          "${AppLocalizations.of(context)!.confirmPasswordSettingScreenSC}",
      hintStyle: CustomTextStyles.titleMediumBluegray500,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return '${AppLocalizations.of(context)!.enterNewPasswordAgainSettingScreenSC}';
      //   }

      //   // Check if the confirmation password matches the new password
      //   if (value != newpasswordController.text) {
      //     return '${AppLocalizations.of(context)!.donotMatchSettingScreenSC}';
      //   }

      //   return null; // Return null if the confirmation password is valid
      // },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${AppLocalizations.of(context)!.enterNewPasswordSettingScreenSC}';
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
          return 'Password must contain at least one special character';
        }

        // Check if the password contains the username
        // if (widget.email.isNotEmpty && value.contains(widget.email)) {
        //   return 'Password cannot contain the username';
        // }

        // Check if the confirmation password matches the new password
        if (value != newpasswordController.text) {
          return '${AppLocalizations.of(context)!.donotMatchSettingScreenSC}';
        }

        return null; // Return null if the password is valid
      },
      suffix: IconButton(
        onPressed: () {
          setState(() {
            confirmPassword = !confirmPassword;
          });
        },
        icon: Icon(
          confirmPassword ? Icons.visibility : Icons.visibility_off,
          color: Color(0xff677294),
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 54.v),
      obscureText: !confirmPassword,
    );
  }

  /// Section Widget
  // Widget _buildConfirmpassword(BuildContext context) {
  //   return CustomTextFormField(
  //       controller: confirmpasswordController,
  //       hintText:
  //           "${AppLocalizations.of(context)!.confirmPasswordSettingScreenSC}",
  //       hintStyle: CustomTextStyles.titleMediumBluegray500,
  //       textInputAction: TextInputAction.done,
  //       textInputType: TextInputType.visiblePassword,
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return '${AppLocalizations.of(context)!.enterNewPasswordAgainSettingScreenSC}';
  //         }
  //         if (value != newpasswordController.text) {
  //           return '${AppLocalizations.of(context)!.donotMatchSettingScreenSC}';
  //         }
  //         return null;
  //       },
  //       suffix: IconButton(
  //           onPressed: () {
  //             if (confirmPassword) {
  //               confirmPassword = false;
  //             } else {
  //               confirmPassword = true;
  //             }
  //             setState(() {});
  //           },
  //           icon: Icon(
  //             confirmPassword ? Icons.visibility : Icons.visibility_off,
  //             color: Color(0xff677294),
  //           )),
  //       suffixConstraints: BoxConstraints(maxHeight: 54.v),
  //       obscureText: !confirmPassword);
  // }

  /// Section Widget
  Widget _buildChangePassword(BuildContext context) {
    return isLoadingButton
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CustomElevatedButton(
            height: 54.v,
            text:
                "${AppLocalizations.of(context)!.changePasswordDoctorMenuScreenSC}",
            onPressed: () {
              setState(() {
                isLoadingButton = true;
                print("True Here");
              });
              if (_formKey.currentState!.validate()) {
                // Perform the password change operation
                PatientApiService().changePassword(
                  context,
                  passwordController.text,
                  newpasswordController.text,
                  widget.token,
                );
              }
              setState(() {
                isLoadingButton = false;
                print("False Here");
              });
            },
            margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 27.v),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_1);
  }
}
