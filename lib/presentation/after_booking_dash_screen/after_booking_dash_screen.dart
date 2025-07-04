// import 'widgets/cancel1_item_widget.dart';
// import 'package:doctari/widgets/custom_elevated_button.dart';
// import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
// import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
// import 'package:doctari/widgets/app_bar/appbar_title.dart';
// import 'package:doctari/widgets/app_bar/appbar_trailing_circleimage.dart';
// import 'package:doctari/widgets/custom_search_view.dart';
// import 'widgets/booknow5_item_widget.dart';
// import 'package:doctari/widgets/custom_icon_button.dart';
// import 'package:doctari/widgets/custom_outlined_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// class AfterBookingDashScreen extends StatelessWidget {
//   AfterBookingDashScreen({Key? key})
//       : super(
//           key: key,
//         );

//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SizedBox(
//           // width: 375.h,
//           child: Column(
//             children: [
//               _buildCancel1(context),
//               SizedBox(height: 20.v),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 7.v),
//                     padding: EdgeInsets.symmetric(horizontal: 19.h),
//                     child: Column(
//                       children: [
//                         CustomSearchView(
//                           controller: searchController,
//                           hintText: "Name",
//                         ),
//                         SizedBox(height: 20.v),
//                         _buildBookNow(context),
//                         SizedBox(height: 40.v),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Opacity(
//                               opacity: 0.5,
//                               child: CustomIconButton(
//                                 height: 32.adaptSize,
//                                 width: 32.adaptSize,
//                                 padding: EdgeInsets.all(4.h),
//                                 decoration:
//                                     IconButtonStyleHelper.fillBlueGrayTL4,
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.imgArrowLeft,
//                                 ),
//                               ),
//                             ),
//                             _buildOne(context),
//                             _buildTwo(context),
//                             Container(
//                               width: 32.adaptSize,
//                               margin: EdgeInsets.only(left: 8.h),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 10.h,
//                                 vertical: 2.v,
//                               ),
//                               decoration: AppDecoration.outlineGray300.copyWith(
//                                 borderRadius: BorderRadiusStyle.roundedBorder6,
//                               ),
//                               child: Text(
//                                 "...",
//                                 style: CustomTextStyles.titleSmallBluegray90003,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 8.h),
//                               child: CustomIconButton(
//                                 height: 32.adaptSize,
//                                 width: 32.adaptSize,
//                                 padding: EdgeInsets.all(4.h),
//                                 decoration: IconButtonStyleHelper.outlineGray,
//                                 child: CustomImageView(
//                                   imagePath:
//                                       ImageConstant.imgArrowRightBlueGray10001,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCancel(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         height: 37.v,
//         text: "Cancel",
//         buttonStyle: CustomButtonStyles.fillGray,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildReschedule(BuildContext context) {
//     return Expanded(
//       child: CustomElevatedButton(
//         height: 37.v,
//         text: "Reschedule",
//         margin: EdgeInsets.only(left: 16.h),
//         buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCancel1(BuildContext context) {
//     return SizedBox(
//       height: 360.v,
//       width: 375.h,
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 20.h,
//                 top: 90.v,
//                 right: 20.h,
//               ),
//               child: ListView.separated(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 separatorBuilder: (
//                   context,
//                   index,
//                 ) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(vertical: 0.5.v),
//                     child: SizedBox(
//                       width: 310.h,
//                       child: Divider(
//                         height: 1.v,
//                         thickness: 1.v,
//                         color: appTheme.gray200,
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: 1,
//                 itemBuilder: (context, index) {
//                   return Cancel1ItemWidget();
//                 },
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               margin: EdgeInsets.only(left: 362.h),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 11.h,
//                 vertical: 12.v,
//               ),
//               decoration: AppDecoration.outlineGray.copyWith(
//                 borderRadius: BorderRadiusStyle.roundedBorder12,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 4.h),
//                     child: Text(
//                       "Upcoming Consultation",
//                       style: theme.textTheme.titleMedium,
//                     ),
//                   ),
//                   SizedBox(height: 12.v),
//                   Divider(
//                     color: appTheme.gray200,
//                   ),
//                   SizedBox(height: 11.v),
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 109.adaptSize,
//                         width: 109.adaptSize,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             CustomImageView(
//                               imagePath: ImageConstant.imgImage,
//                               height: 109.adaptSize,
//                               width: 109.adaptSize,
//                               radius: BorderRadius.circular(
//                                 12.h,
//                               ),
//                               alignment: Alignment.center,
//                             ),
//                             CustomImageView(
//                               imagePath: ImageConstant.imgImage1,
//                               height: 109.adaptSize,
//                               width: 109.adaptSize,
//                               radius: BorderRadius.circular(
//                                 12.h,
//                               ),
//                               alignment: Alignment.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             left: 12.h,
//                             top: 4.v,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Sep 30, 2024 - 10.00 AM",
//                                 style: theme.textTheme.titleMedium,
//                               ),
//                               SizedBox(height: 2.v),
//                               Text(
//                                 "Dr. Aaron",
//                                 style: theme.textTheme.titleMedium,
//                               ),
//                               SizedBox(height: 4.v),
//                               Text(
//                                 "Cardiologist",
//                                 style: CustomTextStyles.titleSmallBluegray700,
//                               ),
//                               SizedBox(height: 8.v),
//                               Row(
//                                 children: [
//                                   CustomImageView(
//                                     imagePath: ImageConstant.imgSettings,
//                                     height: 14.adaptSize,
//                                     width: 14.adaptSize,
//                                     margin: EdgeInsets.symmetric(vertical: 3.v),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 4.h),
//                                     child: Text(
//                                       "Cardiology Center, USA",
//                                       style: CustomTextStyles
//                                           .bodyMediumBluegray700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.v),
//                   Divider(
//                     color: appTheme.gray200,
//                   ),
//                   SizedBox(height: 11.v),
//                   Row(
//                     children: [
//                       _buildCancel(context),
//                       _buildReschedule(context),
//                     ],
//                   ),
//                   SizedBox(height: 3.v),
//                 ],
//               ),
//             ),
//           ),
//           CustomAppBar(
//             height: 127.v,
//             title: Padding(
//               padding: EdgeInsets.only(
//                 left: 19.h,
//                 top: 16.v,
//                 bottom: 48.v,
//               ),
//               child: Column(
//                 children: [
//                   AppbarSubtitleEight(
//                     text: "Hi Abdul! ",
//                     margin: EdgeInsets.only(right: 112.h),
//                   ),
//                   AppbarTitle(
//                     text: "Find Your Doctor",
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               AppbarTrailingCircleimage(
//                 imagePath: ImageConstant.imgEllipse2660x60,
//                 margin: EdgeInsets.fromLTRB(20.h, 7.v, 20.h, 60.v),
//               ),
//             ],
//             styleType: Style.bgGradientnamelightblueA200nameprimary,
//           ),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildBookNow(BuildContext context) {
//     return ListView.separated(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       separatorBuilder: (
//         context,
//         index,
//       ) {
//         return SizedBox(
//           height: 10.v,
//         );
//       },
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return Booknow5ItemWidget();
//       },
//     );
//   }

//   /// Section Widget
//   Widget _buildOne(BuildContext context) {
//     return CustomElevatedButton(
//       height: 32.v,
//       width: 32.h,
//       text: "1",
//       margin: EdgeInsets.only(left: 8.h),
//       buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
//     );
//   }

//   /// Section Widget
//   Widget _buildTwo(BuildContext context) {
//     return CustomOutlinedButton(
//       width: 32.h,
//       text: "2",
//       margin: EdgeInsets.only(left: 8.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildBottomBar(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.colorScheme.onErrorContainer.withOpacity(1),
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20.h),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: appTheme.black900.withOpacity(0.25),
//             spreadRadius: 2.h,
//             blurRadius: 2.h,
//             offset: Offset(
//               0,
//               4,
//             ),
//           ),
//         ],
//       ),
//       child: CustomImageView(
//         imagePath: ImageConstant.imgGroupPrimary48x281,
//         height: 48.v,
//         width: 281.h,
//         margin: EdgeInsets.fromLTRB(44.h, 13.v, 50.h, 13.v),
//       ),
//     );
//   }
// }

import 'widgets/cancel1_item_widget.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
import 'package:doctari/widgets/app_bar/appbar_title.dart';
import 'package:doctari/widgets/app_bar/appbar_trailing_circleimage.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'widgets/booknow5_item_widget.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class AfterBookingDashScreen extends StatelessWidget {
  AfterBookingDashScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          // width: 375.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 20.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Name",
                ),
              ),
              SizedBox(height: 20.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUpcomingConsultation(context),
                        SizedBox(height: 40.v),
                        _buildBookNow(context),
                        SizedBox(height: 40.v),
                        _buildPagination(context),
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

  Widget _buildUpcomingConsultation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Consultation",
          style: theme.textTheme.headlineMedium,
        ),
        SizedBox(height: 20.v),
        Cancel1ItemWidget(), // Placeholder for upcoming consultation item
        SizedBox(height: 20.v),
      ],
    );
  }

  Widget _buildBookNow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Book Now",
          style: theme.textTheme.headlineMedium,
        ),
        SizedBox(height: 20.v),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 10.v),
          itemCount: 5,
          itemBuilder: (context, index) => Booknow5ItemWidget(),
        ),
      ],
    );
  }

  Widget _buildPagination(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding: EdgeInsets.all(4.h),
            decoration: IconButtonStyleHelper.fillBlueGrayTL4,
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
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.v),
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
              imagePath: ImageConstant.imgArrowRightBlueGray10001,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOne(BuildContext context) {
    return CustomElevatedButton(
      height: 32.v,
      width: 32.h,
      text: "1",
      margin: EdgeInsets.only(left: 8.h),
      buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
    );
  }

  Widget _buildTwo(BuildContext context) {
    return CustomOutlinedButton(
      width: 32.h,
      text: "2",
      margin: EdgeInsets.only(left: 8.h),
    );
  }

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
            offset: Offset(0, 4),
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
