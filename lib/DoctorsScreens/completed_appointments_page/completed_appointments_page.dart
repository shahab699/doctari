import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:intl/intl.dart';

import 'widgets/completedappointments_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class CompletedAppointmentsPage extends StatefulWidget {
  final int doctorId;
  final String token;

  const CompletedAppointmentsPage(
      {required this.doctorId, required this.token, Key? key})
      : super(
          key: key,
        );

  @override
  State<CompletedAppointmentsPage> createState() =>
      _CompletedAppointmentsPageState();
}

class _CompletedAppointmentsPageState extends State<CompletedAppointmentsPage> {
  late List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  bool? isLoading;
  void fetchAppointments() async {
    setState(() {
      isLoading = true; // Set isLoading to true while fetching data
    });

    try {
      final List<Map<String, dynamic>> fetchedAppointments =
          await DoctorApiService.fetchCompletedAppointmentsForDoc(
              widget.doctorId, true, widget.token);
      setState(() {
        appointments = fetchedAppointments;
        isLoading = false; // Set isLoading to false after data is fetched
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
                  body: Container(
                    width: double.maxFinite,
                    decoration: AppDecoration.fillOnErrorContainer1,
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
            return CompletedappointmentsItemWidget(
              // Pass appointment data to the widget
              appointmentData: appointment,
              date: formattedDate,
              time: formattedTime,
            );
          },
        ),
      ),
    );
    // Container(
    //   margin: EdgeInsets.symmetric(vertical: 10),
    //   padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 10),
    //   child: ListView.separated(
    //     physics: BouncingScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: 4,
    //     itemBuilder: (context, index) {
    //       return CompletedappointmentsItemWidget();
    //     },
    //     separatorBuilder: (context, index) {
    //       return SizedBox(
    //         height: 20,
    //       );
    //     },
    //   ),
    // );
  }
}
