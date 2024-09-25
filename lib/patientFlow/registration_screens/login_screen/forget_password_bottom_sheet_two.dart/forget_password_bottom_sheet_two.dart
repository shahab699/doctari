import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/forget_password_bottom_sheet_three.dart/bottom_sheet.dart';
import 'package:doctari/theme/custom_button_style.dart';
import 'package:doctari/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordTwoBottomSheet extends StatefulWidget {
  ForgetPasswordTwoBottomSheet({Key? key}) : super(key: key);

  @override
  _ForgetPasswordTwoBottomSheetState createState() =>
      _ForgetPasswordTwoBottomSheetState();
}

class _ForgetPasswordTwoBottomSheetState
    extends State<ForgetPasswordTwoBottomSheet> {
  List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      height: 500,
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
            '${AppLocalizations.of(context)!.enterCodeForgotPasswordBottomSheetSC}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black,
                fontFamily: 'Nunito'),
          ),
          SizedBox(height: 16.0),
          Text(
            '${AppLocalizations.of(context)!.sentCodeForgotPasswordBottomSheetSC}.',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          SizedBox(height: 30.0),
          _buildOtpBoxes(context),
          SizedBox(height: 30.0),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text:
          "${AppLocalizations.of(context)!.continueForgotPasswordBottomSheet2SC}",
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
      onPressed: () {
        String otpCode = _otpControllers.fold<String>(
          '',
          (prev, controller) => prev + controller.text,
        );
        print('Entered OTP Code: $otpCode');
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ForgetPasswordThreeBottomSheet();
          },
        );
      },
    );
  }

  Widget _buildOtpBoxes(BuildContext context) {
    // return OtpPinField(
    //     key: _otpPinFieldController,
    //     autoFillEnable: false,
    //     textInputAction: TextInputAction.send,
    //     onSubmit: (text) {},
    //     onChange: (text) {},
    //     onCodeChanged: (code) {},
    //     otpPinFieldStyle: OtpPinFieldStyle(
    //       fieldPadding: 20,
    //       fieldBorderRadius: 20,
    //       defaultFieldBackgroundColor: Colors.white,
    //       activeFieldBorderColor: Colors.transparent,
    //       defaultFieldBorderColor:
    //       Colors.transparent,
    //       activeFieldBackgroundColor: Colors.white,
    //       filledFieldBackgroundColor: Colors.white,
    //       filledFieldBorderColor:
    //       Colors.grey.shade200,
    //     ),
    //     maxLength: 4,
    //     cursorColor: const Color(0xff677294),
    //     upperChild: Column(
    //       children: [
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height * 0.01,
    //         )
    //       ],
    //     ),
    //     cursorWidth: 1,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration
    // );

    return OtpPinField(
      key: _otpPinFieldController,
      autoFillEnable: false,
      textInputAction: TextInputAction.send,
      onSubmit: (text) {},
      onChange: (text) {},
      onCodeChanged: (code) {},
      otpPinFieldStyle: OtpPinFieldStyle(
        fieldPadding: 20,
        fieldBorderRadius: 20,
        defaultFieldBackgroundColor: Colors.white,
        activeFieldBorderColor: Colors.transparent,
        defaultFieldBorderColor: Colors.transparent,
        activeFieldBackgroundColor: Colors.white,
        filledFieldBackgroundColor: Colors.white,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontFamily: 'Nunito', fontSize: 22),
        filledFieldBorderColor: Colors.grey.shade200,
      ),
      maxLength: 4,
      cursorColor: const Color(0xff677294),
      upperChild: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
      cursorWidth: 1,
      mainAxisAlignment: MainAxisAlignment.center,
      otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
    );
  }
}
