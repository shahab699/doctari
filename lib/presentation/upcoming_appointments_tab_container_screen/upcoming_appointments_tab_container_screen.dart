// import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
// import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/upcoming_appointments_one_page/upcoming_appointments_one_page.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/appointments_and_completed_appointments/completed_appointments_one_page/completed_appointments_one_page.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// class UpcomingAppointmentsTabContainerScreen extends StatefulWidget {
//   const UpcomingAppointmentsTabContainerScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   UpcomingAppointmentsTabContainerScreenState createState() =>
//       UpcomingAppointmentsTabContainerScreenState();
// }

// class UpcomingAppointmentsTabContainerScreenState
//     extends State<UpcomingAppointmentsTabContainerScreen>
//     with TickerProviderStateMixin {
//   late TabController tabviewController;

//   @override
//   void initState() {
//     super.initState();
//     tabviewController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: _buildAppBar(context),
//         body: SizedBox(
//           width: double.maxFinite,
//           child: Column(
//             children: [
//               SizedBox(height: 11.v),
//               _buildTabview(context),
//               Expanded(
//                 child: SizedBox(
//                   height: 615.v,
//                   child: TabBarView(
//                     controller: tabviewController,
//                     children: [
//                       UpcomingAppointmentsOnePage(),
//                       CompletedAppointmentsOnePage(),
//                     ],
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
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       centerTitle: true,
//       title: AppbarSubtitleSeven(
//         text: "Appointments",
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildTabview(BuildContext context) {
//     return Container(
//       height: 39.v,
//       width: double.maxFinite,
//       child: TabBar(
//         controller: tabviewController,
//         labelPadding: EdgeInsets.zero,
//         labelColor: theme.colorScheme.primary,
//         labelStyle: TextStyle(
//           fontSize: 16.fSize,
//           fontFamily: 'Nunito',
//           fontWeight: FontWeight.w700,
//         ),
//         unselectedLabelColor: theme.colorScheme.onPrimaryContainer,
//         unselectedLabelStyle: TextStyle(
//           fontSize: 16.fSize,
//           fontFamily: 'Nunito',
//           fontWeight: FontWeight.w700,
//         ),
//         indicatorColor: theme.colorScheme.primary,
//         tabs: [
//           Tab(
//             child: Text(
//               "Upcoming",
//             ),
//           ),
//           Tab(
//             child: Text(
//               "Completed",
//             ),
//           ),
//         ],
//       ),
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
//         imagePath: ImageConstant.imgGroupPrimary48x201,
//         height: 48.v,
//         width: 201.h,
//         margin: EdgeInsets.fromLTRB(94.h, 13.v, 95.h, 13.v),
//       ),
//     );
//   }
// }
