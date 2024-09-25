import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'widgets/cancel_item_widget.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:doctari/widgets/app_bar/appbar_title.dart';
import 'package:doctari/widgets/app_bar/appbar_trailing_circleimage.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'widgets/booknow1_item_widget.dart';
import 'widgets/booknow2_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardAfterBookingPScreen extends StatelessWidget {
  DashboardAfterBookingPScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: mediaQuery.size.width,
          child: Column(
            children: [
              _buildCancel1(context),
              SizedBox(height: 20.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        CustomSearchView(
                          controller: searchController,
                          fillColor: Colors.grey.shade100,
                          borderDecoration: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          prefix: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: Color(0xff677294),
                              )),
                          hintText:
                              "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
                          suffix: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.filter_list,
                                color: Color(0xff677294),
                              )),
                        ),
                        SizedBox(height: 20.v),
                        _buildBookNow(context),
                        SizedBox(height: 20.v),
                        _buildBookNow(context),
                        SizedBox(height: 20.v),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCancel1(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height * 0.42,
      width: mediaQuery.size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Container(
          //   height: 50,
          //   width: mediaQuery.size.width,
          //   color: Colors.red,
          // ),
          Positioned(
            top: 0,
            child: Container(
              height: mediaQuery.size.height * 0.18,
              width: mediaQuery.size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
                gradient: LinearGradient(
                  colors: [
                    appTheme.lightBlueA200,
                    theme.colorScheme.primary,
                  ],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 19.h,
                      top: 16.v,
                      bottom: 48.v,
                    ),
                    child: Column(
                      children: [
                        AppbarSubtitleSeven(
                          text: "Hi Abdul! ",
                          margin: EdgeInsets.only(right: 112.h),
                        ),
                        AppbarTitle(
                          text:
                              "${AppLocalizations.of(context)!.findDoctorDashboardAfterBookingScrnSC}",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              right: 20.h,
            ),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (
                context,
                index,
              ) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.5.v),
                  child: SizedBox(
                    width: 310.h,
                    child: Divider(
                      height: 1.v,
                      thickness: 1.v,
                      color: appTheme.gray200,
                    ),
                  ),
                );
              },
              itemCount: 1,
              itemBuilder: (context, index) {
                return CancelItemWidget();
              },
            ),
          ),

          // CustomAppBar(
          //   height: mediaQuery.size.height*0.2,
          //   title: Padding(
          //     padding: EdgeInsets.only(
          //       left: 19.h,
          //       top: 16.v,
          //       bottom: 48.v,
          //     ),
          //     child: Column(
          //       children: [
          //         AppbarSubtitleSeven(
          //           text: "Hi Abdul! ",
          //           margin: EdgeInsets.only(right: 112.h),
          //         ),
          //         AppbarTitle(
          //           text: "Find Your Doctor",
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: [
          //     AppbarTrailingCircleimage(
          //       imagePath: ImageConstant.imgEllipse2660x60,
          //       margin: EdgeInsets.fromLTRB(20.h, 7.v, 20.h, 60.v),
          //     ),
          //   ],
          //   styleType: Style.bgGradientnamelightblueA200nameprimary,
          // ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookNow(BuildContext context) {
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
      itemCount: 5,
      itemBuilder: (context, index) {
        return Booknow1ItemWidget();
      },
    );
  }
}
