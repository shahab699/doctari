import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctari/widgets/custom_rating_bar.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Alldoctors1ItemWidget extends StatelessWidget {
  const Alldoctors1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.h),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              right: 49.h,
            ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage87x92,
                  height: 87.v,
                  width: 92.h,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.h,
                    top: 3.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Aaron",
                        style: CustomTextStyles.titleMediumBluegray9000518,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.cardiologistCancelItemWidgetSC}",
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            color: Colors.grey,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "${AppLocalizations.of(context)!.cardiologyCenterBooknow1ItemWidgetSC}, USA",
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.v),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "\$",
                              style: CustomTextStyles.titleMediumff0ebe7f,
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "28.00/hr",
                              style: CustomTextStyles.bodyLargee5677294,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 17.v,
                    bottom: 1.v,
                  ),
                  child: CustomRatingBar(
                    ignoreGestures: true,
                    initialRating: 0,
                  ),
                ),
                _buildBookNow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookNow(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(),
            ));
      },
      height: 34.v,
      width: 112.h,
      text: "${AppLocalizations.of(context)!.bookNowBooknow1ItemWidgetSC}",
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }
}
