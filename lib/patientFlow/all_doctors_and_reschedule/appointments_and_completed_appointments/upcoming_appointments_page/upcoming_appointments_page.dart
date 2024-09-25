import 'widgets/upcomingappointments_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class UpcomingAppointmentsPage extends StatefulWidget {
  const UpcomingAppointmentsPage({Key? key})
      : super(
          key: key,
        );

  @override
  UpcomingAppointmentsPageState createState() =>
      UpcomingAppointmentsPageState();
}

class UpcomingAppointmentsPageState extends State<UpcomingAppointmentsPage>
    with AutomaticKeepAliveClientMixin<UpcomingAppointmentsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer1,
          child: Column(
            children: [
              SizedBox(height: 15.v),
              _buildUpcomingAppointments(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUpcomingAppointments(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.v),
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
          itemCount: 3,
          itemBuilder: (context, index) {
            return UpcomingappointmentsItemWidget();
          },
        ),
      ),
    );
  }
}
