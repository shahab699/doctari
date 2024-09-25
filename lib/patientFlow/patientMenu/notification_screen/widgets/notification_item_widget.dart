import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 4.v,
            bottom: 6.v,
          ),
          child: CustomIconButton(
            height: 60.adaptSize,
            width: 60.adaptSize,
            padding: EdgeInsets.all(18.h),
            decoration: IconButtonStyleHelper.fillGreen,
            child: CustomImageView(
              imagePath: ImageConstant.imgCalendarErrorcontainer,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "${AppLocalizations.of(context)!.appointmentSuccessNotificationItemWidgetsSC}",
                        style: CustomTextStyles.titleMediumBluegray90002,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.v),
                      child: Text(
                        "1h",
                        style: CustomTextStyles.bodyMediumGray600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.v),
                SizedBox(
                  width: 223.h,
                  child: Text(
                    "${AppLocalizations.of(context)!.haveSuccessfulybookNotificationItemWidgetsSC} Dr. Emily Walker.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodyMediumGray600.copyWith(
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
