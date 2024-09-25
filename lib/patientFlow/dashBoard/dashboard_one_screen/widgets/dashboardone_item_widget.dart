import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardoneItemWidget extends StatelessWidget {
  const DashboardoneItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10.0 : 17.0),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage87x92,
                height: isSmallScreen ? 70.0 : 87.0,
                width: isSmallScreen ? 75.0 : 92.0,
                radius: BorderRadius.circular(isSmallScreen ? 4.0 : 6.0),
              ),
              SizedBox(width: isSmallScreen ? 10.0 : 13.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Aaron Smith",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 12.0 : 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "${AppLocalizations.of(context)!.cardiologistCancelItemWidgetSC}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 14.0,
                          width: 14.0,
                          color: Colors.grey,
                          margin: EdgeInsets.only(bottom: 2.0),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          "${AppLocalizations.of(context)!.cardiologyCenterBooknow1ItemWidgetSC}, USA",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$",
                            style: CustomTextStyles.titleMediumff0ebe7f,
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                            text: "28.00",
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
          SizedBox(height: isSmallScreen ? 8.0 : 13.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isSmallScreen ? 10.0 : 17.0,
                  bottom: isSmallScreen ? 5.0 : 1.0,
                ),
                child: CustomRatingBar(
                  ignoreGestures: true,
                  initialRating: 0,
                ),
              ),
              _buildBookNow(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookNow(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(),
            ));
      },
      height: 34.0,
      width: 112.0,
      text: "${AppLocalizations.of(context)!.bookNowBooknow1ItemWidgetSC}",
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }
}
