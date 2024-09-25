import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/BookAppointment.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import '../../../theme/theme_helper.dart';
import 'widgets/tabbar_item_widget.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int? docId;
  const DoctorDetailsScreen({Key? key, this.docId})
      : super(
          key: key,
        );

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late Future<Doctor> _doctorFuture;

  @override
  void initState() {
    super.initState();
    _doctorFuture = _fetchDoctorProfile();
  }

  Future<Doctor> _fetchDoctorProfile() async {
    try {
      // Fetch doctor profile from the API
      Doctor fetchedDoctor =
          await PatientApiService().fetchDoctorProfile(widget.docId!);

      return fetchedDoctor;
    } catch (error) {
      // Handle errors
      print("Error fetching doctor profile: $error");
      throw error; // Rethrow the error to indicate failure to fetch doctor profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: _buildAppBar(context),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: theme.colorScheme.primary,
          title: Text('${AppLocalizations.of(context)!.doctorDetailsDoctorSC}'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        body: FutureBuilder<Doctor>(
          future: _doctorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the data to load, display a loading indicator
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else if (snapshot.hasError) {
              // If an error occurs, display an error message
              return Text(
                  '${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}');
            } else {
              // Once the data is successfully fetched, display the doctor's details
              Doctor doctor = snapshot.data!;
              return Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 3.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(context, doctor.profile_image, doctor.full_name,
                        doctor.specialty, doctor.city),
                    //SizedBox(height: 34.v),
                    // _buildTabBar(context, doctor.score),
                    //doctor.Firstname,
                    SizedBox(height: 26.v),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Doctor Email',
                                style: theme.textTheme.titleLarge),
                            SizedBox(height: 8.v),
                            Text(
                              '${doctor.email}',
                              style: CustomTextStyles.bodyMediumGray600,
                            ),
                          ],
                        )),
                    //SizedBox(height: 26.v),
                    // _buildAboutMe(context),
                    SizedBox(height: 26.v),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Doctor Liecense Number',
                                style: theme.textTheme.titleLarge),
                            SizedBox(height: 8.v),
                            Text(
                              '${doctor.license_no}',
                              style: CustomTextStyles.bodyMediumGray600,
                            ),
                          ],
                        )),
                    SizedBox(height: 26.v),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Doctor Score',
                                style: theme.textTheme.titleLarge),
                            SizedBox(height: 8.v),
                            Text(
                              '${doctor.score}',
                              style: CustomTextStyles.bodyMediumGray600,
                            ),
                          ],
                        )),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "${AppLocalizations.of(context)!.workingTimeDoctorDetailsScreenSC}",
                    //     style: theme.textTheme.titleLarge,
                    //   ),
                    // ),

                    // SizedBox(height: 8.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "Monday-Friday, 08.00 AM-18.00 PM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),

                    SizedBox(height: 24.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "${AppLocalizations.of(context)!.pastConsultationsDoctorDetailsScreenSC}",
                    //     style: theme.textTheme.titleLarge,
                    //   ),
                    // ),

                    SizedBox(height: 10.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),

                    SizedBox(height: 9.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),
                    SizedBox(height: 9.v),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 24.h),
                    //   child: Text(
                    //     "April 3rd, 2023 - 10 AM",
                    //     style: CustomTextStyles.bodyMediumGray600,
                    //   ),
                    // ),

                    SizedBox(height: 5.v),
                  ],
                ),
              );
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text('Doctor Name: ${doctor.specialty}'),
              //     // Add more widgets to display other doctor details
              //   ],
              // );
            }
          },
        ),
        //     Container(
        //   width: double.maxFinite,
        //   padding: EdgeInsets.symmetric(vertical: 3.v),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       _buildCard(context),
        //       SizedBox(height: 34.v),
        //       _buildTabBar(context),
        //       SizedBox(height: 26.v),
        //       _buildAboutMe(context),
        //       SizedBox(height: 26.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "Working Time",
        //           style: theme.textTheme.titleLarge,
        //         ),
        //       ),
        //       SizedBox(height: 8.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "Monday-Friday, 08.00 AM-18.00 PM",
        //           style: CustomTextStyles.bodyMediumGray600,
        //         ),
        //       ),
        //       SizedBox(height: 24.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "Past Consultations",
        //           style: theme.textTheme.titleLarge,
        //         ),
        //       ),
        //       SizedBox(height: 10.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "April 3rd, 2023 - 10 AM",
        //           style: CustomTextStyles.bodyMediumGray600,
        //         ),
        //       ),
        //       SizedBox(height: 9.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "April 3rd, 2023 - 10 AM",
        //           style: CustomTextStyles.bodyMediumGray600,
        //         ),
        //       ),
        //       SizedBox(height: 9.v),
        //       Padding(
        //         padding: EdgeInsets.only(left: 24.h),
        //         child: Text(
        //           "April 3rd, 2023 - 10 AM",
        //           style: CustomTextStyles.bodyMediumGray600,
        //         ),
        //       ),
        //       SizedBox(height: 5.v),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: _buildBookAppointment(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowDownBlueGray800,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 16.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleSeven(
        text: "${AppLocalizations.of(context)!.doctorDetailsDoctorSC}",
      ),
    );
  }

  /// Section Widget
  Widget _buildCard(BuildContext context, String profileImage, String docName,
      String specialty, String city) {
    print("specialty: $specialty");
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingAppointmentDetails(
                        doctorId: widget.docId!,
                      )));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.h),
          padding: EdgeInsets.all(11.h),
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Adjusted cross axis alignment
            children: [
              // CustomImageView(
              //   imagePath: ImageConstant.imgImage1,
              //   height: 109.adaptSize,
              //   width: 109.adaptSize,
              //   radius: BorderRadius.circular(
              //     12.h,
              //   ),
              // ),
              profileImage ==
                      '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                  ? Container(
                      height: 87.v,
                      width: 92.h,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/doc.jpg'),
                        ),
                      ),
                    )
                  : Container(
                      height: 87.v,
                      width: 92.h,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(profileImage),
                        ),
                      ),
                    ),
              SizedBox(width: 12.h), // Added spacing between image and text
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 9.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$docName",
                        // textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,

                        overflow: TextOverflow.ellipsis, // Handles overflow
                        maxLines: 2, // Limits to a single line
                      ),
                      SizedBox(height: 9.v),
                      Divider(
                        color: appTheme.gray200,
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        "$specialty",
                        style: CustomTextStyles.titleSmallBluegray700,
                      ),
                      SizedBox(height: 11.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            color: Colors.grey,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            margin: EdgeInsets.only(bottom: 3.v),
                          ),
                          SizedBox(
                              width:
                                  4.h), // Added spacing between icon and text
                          Expanded(
                            child: Text(
                              "$city",
                              style:
                                  CustomTextStyles.bodyMediumInterBluegray700,
                              overflow:
                                  TextOverflow.ellipsis, // Handles overflow
                              maxLines: 1, // Limits to a single line
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCard(
  //     BuildContext context, String docName, String specialty, String city) {
  //   return Align(
  //     alignment: Alignment.center,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(horizontal: 24.h),
  //       padding: EdgeInsets.all(11.h),
  //       decoration: AppDecoration.outlineGray.copyWith(
  //         borderRadius: BorderRadiusStyle.roundedBorder12,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           CustomImageView(
  //             imagePath: ImageConstant.imgImage1,
  //             height: 109.adaptSize,
  //             width: 109.adaptSize,
  //             radius: BorderRadius.circular(
  //               12.h,
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(
  //               left: 12.h,
  //               top: 9.v,
  //               bottom: 9.v,
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(
  //                       // Dr. Aaron Smith
  //                       "$docName",
  //                       style: theme.textTheme.titleMedium,
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 9.v),
  //                 SizedBox(
  //                   width: 197.h,
  //                   child: Divider(
  //                     color: appTheme.gray200,
  //                   ),
  //                 ),
  //                 SizedBox(height: 8.v),
  //                 Text(
  //                   // Cardiologist
  //                   "$specialty",
  //                   style: CustomTextStyles.titleSmallBluegray700,
  //                 ),
  //                 SizedBox(height: 11.v),
  //                 Row(
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgSettings,
  //                       color: Colors.grey,
  //                       height: 14.adaptSize,
  //                       width: 14.adaptSize,
  //                       margin: EdgeInsets.only(bottom: 3.v),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 4.h),
  //                       child: Text(
  //                         // Golden Cardiology Center
  //                         "$city",
  //                         style: CustomTextStyles.bodyMediumInterBluegray700,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildTabBar(BuildContext context, double score) {
    return Container(
      height: 102.v,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      decoration: AppDecoration.fillOnErrorContainer1,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 32.h,
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return TabbarItemWidget(
            index: index,
            score: score,
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutMe(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.appointmentPriceDoctorSC}",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 8.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${AppLocalizations.of(context)!.onlineDoctorSC}:",
                        style: CustomTextStyles.titleMediumff333333,
                      ),
                      TextSpan(
                          text: " \$",
                          style: TextStyle(color: Color(0xff0EBE7F))),
                      TextSpan(
                        text: "",
                        style: CustomTextStyles.titleMediumff0ebe7f,
                      ),
                      TextSpan(
                        text: "100.00",
                        style: CustomTextStyles.bodyLargee5677294,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 36.v),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.inPersonDoctorSC}:",
                      style: CustomTextStyles.titleMediumff333333,
                    ),
                    TextSpan(
                        text: " \$",
                        style: TextStyle(color: Color(0xff0EBE7F))),
                    TextSpan(
                      text: "",
                      style: CustomTextStyles.titleMediumff0ebe7f,
                    ),
                    TextSpan(
                      text: "100.00",
                      style: CustomTextStyles.bodyLargee5677294,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBookAppointment(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingAppointmentDetails(
                      doctorId: widget.docId!,
                    )));
      },
      text: "${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}",
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 25.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
    );
  }
}
