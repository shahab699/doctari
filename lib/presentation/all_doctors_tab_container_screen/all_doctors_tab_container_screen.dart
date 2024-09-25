import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_nine.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'package:doctari/presentation/all_doctors_page/all_doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class AllDoctorsTabContainerScreen extends StatefulWidget {
  const AllDoctorsTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  AllDoctorsTabContainerScreenState createState() =>
      AllDoctorsTabContainerScreenState();
}

class AllDoctorsTabContainerScreenState
    extends State<AllDoctorsTabContainerScreen> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 1.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: CustomSearchView(
                          controller: searchController,
                          hintText: "Search doctor...",
                          contentPadding: EdgeInsets.only(
                            top: 11.v,
                            right: 30.h,
                            bottom: 11.v,
                          ),
                          borderDecoration: SearchViewStyleHelper.fillGray,
                          fillColor: appTheme.gray100,
                        ),
                      ),
                      SizedBox(height: 24.v),
                      _buildTabview(context),
                      SizedBox(
                        height: 566.v,
                        child: TabBarView(
                          controller: tabviewController,
                          children: [
                            AllDoctorsPage(),
                            AllDoctorsPage(),
                            AllDoctorsPage(),
                            AllDoctorsPage(),
                          ],
                        ),
                      ),
                    ],
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlueGray800,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 16.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleNine(
        text: "All Doctors",
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 37.v,
      width: 366.h,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        labelColor: theme.colorScheme.onErrorContainer.withOpacity(1),
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: theme.colorScheme.primary,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
        ),
        indicator: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(
            18.h,
          ),
        ),
        tabs: [
          Tab(
            child: Text(
              "All",
            ),
          ),
          Tab(
            child: Text(
              "General",
            ),
          ),
          Tab(
            child: Text(
              "Cardiologist",
            ),
          ),
          Tab(
            child: Text(
              "Dentist",
            ),
          ),
        ],
      ),
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
        imagePath: ImageConstant.imgGroup48x268,
        height: 48.v,
        width: 268.h,
        margin: EdgeInsets.symmetric(
          horizontal: 61.h,
          vertical: 13.v,
        ),
      ),
    );
  }
}
