import 'package:doctari/core/app_export.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordThreeBottomSheet extends StatefulWidget {
  ForgetPasswordThreeBottomSheet({Key? key}) : super(key: key);

  @override
  _ForgetPasswordThreeBottomSheetState createState() =>
      _ForgetPasswordThreeBottomSheetState();
}

class _ForgetPasswordThreeBottomSheetState
    extends State<ForgetPasswordThreeBottomSheet> {
  TextEditingController _bottomSheetOldPasswordController =
      TextEditingController();
  TextEditingController _bottomSheetNewPasswordController =
      TextEditingController();

  bool oldPassword = false;
  bool newPassword = false;

  Future<void> changePassword(BuildContext context, String oldPassword,
      String newPassword, String token) async {
    try {
      final String apiUrl =
          "https://api-b2c-refactor.doctari.com/change_password/";
      final Map<String, String> requestBody = {
        'old_password': oldPassword,
        'new_password': newPassword,
      };

      final Uri uri = Uri.parse(apiUrl);

      print('Sending request to: $uri');

      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
        body: jsonEncode(requestBody),
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Password changed successfully
        // Show success Snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.passwordChangePatientApiServceSC}'),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      } else {
        // Password change failed
        // Parse response body for error messages
        Map<String, dynamic> responseBody = json.decode(response.body);
        String errorMessage = responseBody['detail'] ?? response.reasonPhrase;
        // Show Snackbar message with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.failedPasswordChangePatientApiServceSC}: $errorMessage'),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      }
    } catch (e) {
      // Error occurred during password change
      // Show Snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.failedPasswordChangePatientApiServceSC}: $e'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        height: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Color(0xffC4C4C4),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '${AppLocalizations.of(context)!.resetPasswordBottomSheetSC}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.black,
                  fontFamily: 'Nunito'),
            ),
            SizedBox(height: 10.0),
            Text(
              '${AppLocalizations.of(context)!.setNewPasswordBottomSheetSC}\n${AppLocalizations.of(context)!.loginandAccessBottomSheetSC}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 30.0),
            _buildPassword(context),
            SizedBox(height: 25.0),
            _buildConfirmPassword(context),
            SizedBox(height: 30.0),
            _buildContinueButton(context),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text: "${AppLocalizations.of(context)!.updatePasswordBottomSheetSC}",
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
      onPressed: () async {
        // Navigator.pop(context);
        await changePassword(
            context,
            oldPassword.toString(),
            newPassword.toString(),
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxMjQ3MDgzMywiaWF0IjoxNzEyMDM4ODMzLCJqdGkiOiJhMzI3Zjg2YzZmMzQ0ZjJkYTMxMzUwZjU4NjRjYzk2NiIsInVzZXJfaWQiOjJ9.XHRu_fLDc4vW3loqI7H9KoCCcogeKcMnI9-hFi78rWc");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       backgroundColor: Colors.white,
        //       content: Text(
        //         "Your Password is Successfully Updated",
        //         style: TextStyle(
        //             fontSize: 12,
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold,
        //             fontFamily: 'Nunito'),
        //       )),
        // );
      },
    );
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      controller: _bottomSheetOldPasswordController,
      hintText: "${AppLocalizations.of(context)!.oldPasswordBottomSheetSC}",
      textInputType: TextInputType.emailAddress,
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
      suffix: IconButton(
          onPressed: () {
            if (oldPassword) {
              oldPassword = false;
            } else {
              oldPassword = true;
            }
            setState(() {});
          },
          icon: Icon(
            oldPassword ? Icons.visibility : Icons.visibility_off,
            size: 20,
            color: Color(0xff677294),
          )),
      obscureText: !oldPassword,
    );
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return CustomTextFormField(
      controller: _bottomSheetNewPasswordController,
      hintText: "${AppLocalizations.of(context)!.newPasswordBottomSheetSC}",
      textInputType: TextInputType.emailAddress,
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300)),
      suffix: IconButton(
          onPressed: () {
            if (newPassword) {
              newPassword = false;
            } else {
              newPassword = true;
            }
            setState(() {});
          },
          icon: Icon(
            newPassword ? Icons.visibility : Icons.visibility_off,
            size: 20,
            color: Color(0xff677294),
          )),
      obscureText: !newPassword,
    );
  }

  @override
  void dispose() {
    _bottomSheetOldPasswordController.dispose();
    super.dispose();
  }
}
