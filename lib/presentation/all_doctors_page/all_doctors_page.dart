import 'widgets/alldoctors1_item_widget.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AllDoctorsPage extends StatefulWidget {
  const AllDoctorsPage({Key? key})
      : super(
          key: key,
        );

  @override
  AllDoctorsPageState createState() => AllDoctorsPageState();
}

class AllDoctorsPageState extends State<AllDoctorsPage>
    with AutomaticKeepAliveClientMixin<AllDoctorsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 26.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 24.h,
                    right: 27.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "532 founds",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 9.v),
                      _buildAllDoctors(context),
                      SizedBox(height: 10.v),
                      _buildDoctor4(context),
                      SizedBox(height: 10.v),
                      _buildDoctor1(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAllDoctors(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 10.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Alldoctors1ItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildBookNow(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 112.h,
      text: "Book Now",
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }

  /// Section Widget
  Widget _buildDoctor4(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: _buildDrTranquilli(
              context,
              image: ImageConstant.imgRectangle5061,
              drTranquilli: "Dr. Shoemaker",
              specilistMedicine: "Specilist Patheology",
              cardiologyCenter: "Cardiology Center, USA",
              price: " 28.00/hr",
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              right: 5.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 16.v,
                  ),
                  child: Text(
                    "5",
                    style: CustomTextStyles.bodySmallInterGray600,
                  ),
                ),
                Spacer(),
                _buildBookNow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookNow1(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 112.h,
      text: "Book Now",
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }

  /// Section Widget
  Widget _buildDoctor1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: _buildDrTranquilli(
              context,
              image: ImageConstant.imgRectangle5062,
              drTranquilli: "Dr. Tranquilli",
              specilistMedicine: "Specilist medicine",
              cardiologyCenter: "Cardiology Center, USA",
              price: " 28.00/hr",
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              right: 5.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSignal,
                  height: 15.adaptSize,
                  width: 15.adaptSize,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    top: 17.v,
                    bottom: 1.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 16.v,
                  ),
                  child: Text(
                    "5",
                    style: CustomTextStyles.bodySmallInterGray600,
                  ),
                ),
                Spacer(),
                _buildBookNow1(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildDrTranquilli(
    BuildContext context, {
    required String image,
    required String drTranquilli,
    required String specilistMedicine,
    required String cardiologyCenter,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomImageView(
          imagePath: image,
          height: 87.v,
          width: 92.h,
          radius: BorderRadius.circular(
            4.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                drTranquilli,
                style: CustomTextStyles.titleMediumBluegray9000518.copyWith(
                  color: appTheme.blueGray90005,
                ),
              ),
              Text(
                specilistMedicine,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgSettings,
                    height: 14.adaptSize,
                    width: 14.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 2.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      cardiologyCenter,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: appTheme.blueGray700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "",
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
    );
  }
}
