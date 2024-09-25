import 'widgets/completedappointments_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore_for_file: must_be_immutable
class CompletedAppointmentsPage extends StatefulWidget {
  const CompletedAppointmentsPage({Key? key})
      : super(
          key: key,
        );

  @override
  CompletedAppointmentsPageState createState() =>
      CompletedAppointmentsPageState();
}

class CompletedAppointmentsPageState extends State<CompletedAppointmentsPage>
    with AutomaticKeepAliveClientMixin<CompletedAppointmentsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 15.v),
              _buildCompletedAppointments(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCompletedAppointments(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 7.5.v),
            child: SizedBox(
              width: 310.h,
              height: 10.v,
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return CompletedappointmentsItemWidget();
        },
      ),
    );
  }
}
