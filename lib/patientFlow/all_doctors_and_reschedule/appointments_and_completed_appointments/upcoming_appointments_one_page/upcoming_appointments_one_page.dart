import 'dart:developer';

import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:intl/intl.dart';
import 'widgets/cards_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class UpcomingAppointmentsOnePage extends StatefulWidget {
  final int patientId;
  final String patientAccessToken;

  const UpcomingAppointmentsOnePage(
      {required this.patientId, required this.patientAccessToken, Key? key})
      : super(
          key: key,
        );

  @override
  UpcomingAppointmentsOnePageState createState() =>
      UpcomingAppointmentsOnePageState();
}

class UpcomingAppointmentsOnePageState
    extends State<UpcomingAppointmentsOnePage>
    with AutomaticKeepAliveClientMixin<UpcomingAppointmentsOnePage> {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    print("patientId ${widget.patientId}");
    fetchAppointments();
  }

  bool? isLoading;

  void fetchAppointments() async {
    setState(() {
      isLoading = true; // Set isLoading to true while fetching data
    });
    try {
      final List<Map<String, dynamic>> fetchedAppointments =
          await PatientApiService.fetchPatientAppointments(
              widget.patientId, widget.patientAccessToken);

      // Replace 4 with actual doctor ID
      setState(() {
        appointments = fetchedAppointments;

        isLoading = false;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        isLoading = false; // Set isLoading to false if an error occurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(), // Show loading indicator
          )
        : appointments.isEmpty
            ? Center(
                child: Text(
                  '${AppLocalizations.of(context)!.noAppiontavailableCompletedAppionmentPageSC}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ), // Show message if no appointments
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  body: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(height: 15.v),
                        _buildCards(context),
                      ],
                    ),
                  ),
                ),
              );
  }

  /// Section Widget
  Widget _buildCards(BuildContext context) {
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
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            String combinedDateTimeString = appointment['date'];

// Parse the combined date and time string into a DateTime object
            DateTime combinedDateTime = DateTime.parse(combinedDateTimeString);

// Format date
            String formattedDate =
                DateFormat('yyyy-MM-dd').format(combinedDateTime);

// Format time
            String formattedTime =
                DateFormat('hh:mm a').format(combinedDateTime);

            print("Date: $formattedDate");
            print("Time: $formattedTime");
            return CardsItemWidget(
              // Pass appointment data to the widget
              appointmentData: appointment,
              date: formattedDate,
              time: formattedTime,
            );
          },
        ),
      ),
    );
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.h),
    //   child: ListView.separated(
    //     physics: BouncingScrollPhysics(),
    //     shrinkWrap: true,
    //     separatorBuilder: (
    //       context,
    //       index,
    //     ) {
    //       return Padding(
    //         padding: EdgeInsets.symmetric(vertical: 5.0.v),
    //         child: SizedBox(
    //           height: 22.v,
    //           child: Divider(
    //             color: Colors.grey.shade300,
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: 2,
    //     itemBuilder: (context, index) {
    //       return CardsItemWidget();
    //     },
    //   ),
    // );
  }
}
