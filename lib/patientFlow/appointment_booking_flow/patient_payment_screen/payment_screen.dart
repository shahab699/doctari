import 'package:doctari/patientFlow/appointment_booking_flow/patient_payment_screen/widgets/payment_success_pop_up.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/payment_item_widget.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_checkbox_button.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class PatientPaymentScreen extends StatefulWidget {
  PatientPaymentScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<PatientPaymentScreen> createState() => _PatientPaymentScreenState();
}

class _PatientPaymentScreenState extends State<PatientPaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController cvvController = TextEditingController();

  bool savecarddetails = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Payments", style: TextStyle(fontSize: 22),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 27.h,
              vertical: 4.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Online Consultation (Total)",
                  style: CustomTextStyles.titleMediumBlack90018,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "28.00 ",
                        style: CustomTextStyles.headlineLargeff1a1a1a,
                      ),
                      TextSpan(
                        text: "\$",
                        style: CustomTextStyles.headlineLargeff0ebe7f,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 19.v),
                _buildView(context),
                SizedBox(height: 16.v),
                Text(
                  "Select Card",
                  style: CustomTextStyles.titleMediumOnSecondaryContainer,
                ),
                SizedBox(height: 12.v),
                _buildPayment(context),
                SizedBox(height: 16.v),
                Text(
                  "Card Number",
                  style: CustomTextStyles.titleMediumOnSecondaryContainer,
                ),
                SizedBox(height: 12.v),
                CustomTextFormField(
                  controller: cardNumberController,
                  hintText: "1234  5678  9101  1121",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.v,
                  ),
                  borderDecoration: TextFormFieldStyleHelper.outlineGrayTL12,
                ),
                SizedBox(height: 22.v),
                _buildFrameSixtyTwo(context),
                SizedBox(height: 24.v),
                _buildSavecarddetails(context),
                SizedBox(height: 3.v),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildConfirm(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
          onTap: (){
            Navigator.pop(context);
          },
          imagePath: ImageConstant.imgArrowDownBlueGray800,
          margin: EdgeInsets.only(
            left: 24.h,
            top: 14.v,
            bottom: 17.v,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ));
  }

  /// Section Widget
  Widget _buildView(BuildContext context) {
    return SizedBox(
      // height: 205.v,

      child: SvgPicture.asset(
        'assets/myassets/visa.svg',
        semanticsLabel: 'VISA',
        fit: BoxFit.cover,
        width: 334.h,
      ),
    );
  }

  //section
  // Widget _buildPayment(BuildContext context) {
  //   return SizedBox(
  //     height: 20.v,
  //     child: ListView.separated(
  //       padding: EdgeInsets.only(right: 114.h),
  //       scrollDirection: Axis.horizontal,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return SizedBox(
  //           width: 30.h,
  //         );
  //       },
  //       itemCount: 3, // Change itemCount to 3 for three cards
  //       itemBuilder: (context, index) {
  //         // Provide each PaymentItemWidget with a corresponding card type
  //         String cardType;
  //         switch (index) {
  //           case 0:
  //             cardType = 'VisaCard';
  //             break;
  //           case 1:
  //             cardType = 'Mastercard';
  //             break;
  //           case 2:
  //             cardType = 'Mir';
  //             break;
  //           default:
  //             cardType = 'VisaCard'; // Default to Visa card
  //         }

  //         return PaymentItemWidget(
  //           cardType: cardType,
  //           onChanged: (bool isSelected) {
  //             // Handle onChanged event for each card type
  //             print('$cardType selected: $isSelected');
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget _buildPayment(BuildContext context) {
    return SizedBox(
      height: 20.v,
      child:
          PaymentSelectionWidget(), // Replace ListView.separated with PaymentSelectionWidget
    );
  }

  /// Section Widget
  Widget _buildFortySix(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Exp Date",
            style: CustomTextStyles.titleMediumOnSecondaryContainer,
          ),
          SizedBox(height: 13.v),
          CustomTextFormField(
            width: 197.h,
            controller: dateController,
            hintText: "MM/YY",
            hintStyle: CustomTextStyles.bodyLargeInterGray50001,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 13.v,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlineGrayTL12,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameSixtyTwo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFortySix(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CVV",
              style: CustomTextStyles.titleMediumOnSecondaryContainer,
            ),
            SizedBox(height: 14.v),
            CustomTextFormField(
              width: 122.h,
              controller: cvvController,
              hintText: "123",
              hintStyle: CustomTextStyles.bodyLargeInterGray50001,
              textInputAction: TextInputAction.done,
              suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 16.v, 11.h, 16.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgEye,
                  height: 14.v,
                  width: 16.h,
                ),
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 46.v,
              ),
              contentPadding: EdgeInsets.only(
                left: 14.h,
                top: 13.v,
                bottom: 13.v,
              ),
              borderDecoration: TextFormFieldStyleHelper.outlineGrayTL12,
            ),
          ],
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSavecarddetails(BuildContext context) {
    return CustomCheckboxButton(
      text: "Save card details",
      value: savecarddetails,
      textStyle: CustomTextStyles.bodyLargeInterGray50001,
      onChange: (value) {
        setState(() {
          savecarddetails = value;
        });
      },
    );
  }

  /// Section Widget
  Widget _buildConfirm(BuildContext context) {
    return CustomElevatedButton(
      // height: 54.v,
      text: "Confirm",
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomPopup();
          },
        );
      },
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 15.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
    );
  }
}
