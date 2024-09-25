import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
import 'package:doctari/widgets/app_bar/appbar_title.dart';
import 'package:doctari/widgets/app_bar/appbar_trailing_circleimage.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'package:doctari/widgets/custom_drop_down.dart';
import 'widgets/dashboardthree_item_widget.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class DashboardThreeScreen extends StatelessWidget {
  DashboardThreeScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildHiAbdul(context),
              SizedBox(height: 17.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 19.h),
                    child: Column(
                      children: [
                        _buildBanner(context),
                        SizedBox(height: 19.v),
                        _buildDashboardThree(context),
                        SizedBox(height: 20.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: CustomIconButton(
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                padding: EdgeInsets.all(4.h),
                                decoration:
                                    IconButtonStyleHelper.fillBlueGrayTL4,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowLeft,
                                ),
                              ),
                            ),
                            _buildOne(context),
                            _buildTwo(context),
                            Container(
                              width: 32.adaptSize,
                              margin: EdgeInsets.only(left: 8.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.h,
                                vertical: 2.v,
                              ),
                              decoration: AppDecoration.outlineGray300.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder6,
                              ),
                              child: Text(
                                "...",
                                style: CustomTextStyles.titleSmallBluegray90003,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: CustomIconButton(
                                height: 32.adaptSize,
                                width: 32.adaptSize,
                                padding: EdgeInsets.all(4.h),
                                decoration: IconButtonStyleHelper.outlineGray,
                                child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgArrowRightBlueGray10001,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildHiAbdul(BuildContext context) {
    return SizedBox(
      height: 219.v,
      width: 375.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomAppBar(
            height: 127.v,
            title: Padding(
              padding: EdgeInsets.only(
                left: 19.h,
                top: 16.v,
                bottom: 48.v,
              ),
              child: Column(
                children: [
                  AppbarSubtitleEight(
                    text: "Hi Abdul! ",
                    margin: EdgeInsets.only(right: 112.h),
                  ),
                  AppbarTitle(
                    text: "Find Your Doctor",
                  ),
                ],
              ),
            ),
            actions: [
              AppbarTrailingCircleimage(
                imagePath: ImageConstant.imgEllipse2660x60,
                margin: EdgeInsets.fromLTRB(20.h, 7.v, 20.h, 60.v),
              ),
            ],
            styleType: Style.bgGradientnamelightblueA200nameprimary,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSearchView(
                    controller: searchController,
                    hintText: "Name",
                  ),
                  SizedBox(height: 14.v),
                  CustomDropDown(
                    hintText: "Select Specialty",
                    hintStyle: CustomTextStyles.bodyMediumBluegray50015,
                    items: dropdownItemList,
                    borderDecoration: DropDownStyleHelper.outlineBlack,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBanner(BuildContext context) {
    return SizedBox(
      height: 163.v,
      width: 334.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage163x334,
            height: 163.v,
            width: 334.h,
            radius: BorderRadius.circular(
              12.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(right: 163.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 105.v,
                    width: 171.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgBackground1,
                          height: 99.v,
                          width: 114.h,
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 11.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160.h,
                                  child: Text(
                                    "Looking for\nSpecialist Doctors?",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleMediumTeal300
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.v),
                                Container(
                                  width: 138.h,
                                  margin: EdgeInsets.only(right: 21.h),
                                  child: Text(
                                    "Schedule an appointment with our top doctors.",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .bodySmallSecondaryContainer
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 12.v,
                      width: 83.h,
                      margin: EdgeInsets.only(right: 20.h),
                      decoration: BoxDecoration(
                        color: appTheme.blueGray10033,
                        borderRadius: BorderRadius.circular(
                          41.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDashboardThree(BuildContext context) {
    return ListView.separated(
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
      itemCount: 8,
      itemBuilder: (context, index) {
        return DashboardthreeItemWidget();
      },
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return CustomElevatedButton(
      height: 32.v,
      width: 32.h,
      text: "1",
      margin: EdgeInsets.only(left: 8.h),
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
    );
  }

  /// Section Widget
  Widget _buildTwo(BuildContext context) {
    return CustomOutlinedButton(
      width: 32.h,
      text: "2",
      margin: EdgeInsets.only(left: 8.h),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgGroupPrimary48x281,
        height: 48.v,
        width: 281.h,
        margin: EdgeInsets.fromLTRB(44.h, 13.v, 50.h, 13.v),
      ),
    );
  }
}
