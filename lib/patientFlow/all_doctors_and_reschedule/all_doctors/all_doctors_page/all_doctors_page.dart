// import 'package:doctari/patientAPI/patient_apis_service.dart';
// import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/all_doctors_page/widgets/horizontal_tabs.dart';
// import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
// import 'package:doctari/widgets/custom_text_form_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'widgets/alldoctors1_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// class AllDoctorsScreen extends StatefulWidget {
//   AllDoctorsScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
// }

// class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
//   final TextEditingController _searchController = TextEditingController();
// late List<Map<String, dynamic>> doctors; // List to store fetched doctors

//   @override
//   void initState() {
//     super.initState();
//     doctors = []; // Initialize doctors list
//     _fetchDoctors(); // Fetch doctors when the screen initializes
//   }

//   Future<void> _fetchDoctors() async {
//     try {
//       // Fetch doctors from the API
//       var fetchedDoctors = await PatientApiService().fetchDoctors();
//       setState(() {
//         // Update the state with the fetched doctors
//         doctors = fetchedDoctors;
//       });
//     } catch (error) {
//       // Handle errors
//       print("Error fetching doctors: $error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       child: Container(
//         color: Colors.grey.shade100,
//         width: SizeUtils.width,
//         child: Column(
//           children: [
//             AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.person),
//                 onPressed: () async {
//                   await PatientApiService().fetchDoctors();
//                 },
//               ),
//               surfaceTintColor: Colors.grey.shade100,
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.grey.shade100,
//               title: AppbarSubtitleSeven(
//                 text: "All Doctors",
//               ),
//               centerTitle: true,
//             ),
//             SizedBox(height: 10.v),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: CustomTextFormField(
//                       // width: 197.h,
//                       controller: _searchController,
//                       prefix: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                           size: 20,
//                         ),
//                       ),
//                       hintText: "Search",
//                       hintStyle: CustomTextStyles.bodyLargeInterGray50001,
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16.h,
//                         vertical: 13.v,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       borderDecoration: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade300, width: 1))),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 HorizontalScrollableTabs(
//                   tabTitles: [
//                     'All',
//                     'General',
//                     'Cardialogist',
//                     'Dentist',
//                     'Surgan',
//                     'Child Specilist'
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     "532 founds",
//                     style: theme.textTheme.titleMedium,
//                   ),
//                 ),
//                 SizedBox(height: 20.v),
//                 Container(
//                     height: MediaQuery.of(context).size.height * 0.7,
//                     padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).size.height * 0.05),
//                     child: _buildAllDoctors(context)),
//                 SizedBox(height: 50.v),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildAllDoctors(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 4.h),
//       child: ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         physics: BouncingScrollPhysics(),
//         shrinkWrap: true,

//         separatorBuilder: (
//           context,
//           index,
//         ) {
//           return SizedBox(
//             height: 22.v,
//           );
//         },
//         itemCount: 6,
//         itemBuilder: (context, index) {
//           return Alldoctors1ItemWidget();
//         },
//       ),
//     );
//   }
// }

import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/all_doctors_page/widgets/rating_stars_widget.dart';
import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllDoctorsScreen extends StatefulWidget {
  AllDoctorsScreen({Key? key}) : super(key: key);

  @override
  _AllDoctorsScreenState createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> doctors; // List to store fetched doctors
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    doctors = []; // Initialize doctors list
    _fetchDoctors(); // Fetch doctors when the screen initializes
  }

  int _selectedIndex = 0;

  late List<Widget> tabs = [
    _buildAllDoctors(),
    _buildGeneralMedicineDoctors(),
    _buildPediatrAaDoctors(),
    _buildNeurologAaDoctors(),
    _buildGINECOLOGAADoctors(),
    _DERMATOLOGADoctors(),
    _PSIQUIATRADoctors(),
    _PSICOLOGaaDoctors(),
    _LABORALDoctors(),
    _TestDoctors()

    // _buildWatchLive(context as BuildContext),
    // _buildPopular(context as BuildContext),
    // _buildStanding(context as BuildContext),
    // _buildNews(context as BuildContext)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: BackButton(
        //   color: Colors.white,
        // ),
        title: Text(
          "${AppLocalizations.of(context)!.allDocAllDoctorsPageSC}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      //     appBar: AppBar(
      //       // leading: IconButton(
      //       //     onPressed: () async {
      //       //       await PatientApiService().createAppointment();
      //       //     },
      //       //     icon: Icon(Icons.person)),
      //       automaticallyImplyLeading: false,
      // title: AppbarSubtitleSeven(
      //   text: "${AppLocalizations.of(context)!.allDocAllDoctorsPageSC}",
      //   style: TextStyle(color: Colors.white), // Apply the text style
      // ),
      //       titleTextStyle: TextStyle(color: Colors.white),
      //       centerTitle: true,
      //       backgroundColor: theme.colorScheme.primary,
      //     ),
      body: doctors.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.grey.shade100,
                // height: SizeUtils.height,
                width: SizeUtils.width,
                child: Column(
                  children: [
                    SizedBox(height: 20.v),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: CustomTextFormField(
                    //       // width: 197.h,
                    //       controller: _searchController,
                    //       prefix: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.search,
                    //           color: Colors.grey,
                    //           size: 20,
                    //         ),
                    //       ),
                    //       hintText: "Search",
                    //       hintStyle: CustomTextStyles.bodyLargeInterGray50001,
                    //       contentPadding: EdgeInsets.symmetric(
                    //         horizontal: 16.h,
                    //         vertical: 13.v,
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       borderDecoration: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               color: Colors.grey.shade300, width: 1))),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    _buildView(context),

                    SizedBox(
                      height: 20,
                    ),

                    tabs[_selectedIndex],
                    // _buildAllDoctors(),
                    SizedBox(height: 30.v),
                  ],
                ),
              ),
            ),
    );
  }

  // build tabs
  Widget _buildView(BuildContext context) {
    return Container(
      height: 50.v,
      padding: EdgeInsets.only(left: 16, top: 9, bottom: 9),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTab("${AppLocalizations.of(context)!.allAllDoctorsPageSC}",
              index: 0),
          _buildTab("${AppLocalizations.of(context)!.generalAllDoctorsPageSC}",
              index: 1),
          _buildTab("${AppLocalizations.of(context)!.pediatrAllDoctorsPageSC}",
              index: 2),
          _buildTab("${AppLocalizations.of(context)!.noroloAllDoctorsPageSC}",
              index: 3),
          _buildTab("${AppLocalizations.of(context)!.ginecolAllDoctorsPageSC}",
              index: 4),
          _buildTab(
              "${AppLocalizations.of(context)!.dermatoloAAllDoctorsPageSC}",
              index: 5),
          _buildTab("${AppLocalizations.of(context)!.psiquiaAllDoctorsPageSC}",
              index: 6),
          _buildTab("${AppLocalizations.of(context)!.psicoloAllDoctorsPageSC}",
              index: 7),
          _buildTab(
              "${AppLocalizations.of(context)!.madicoLaboralAllDoctorsPageSC}",
              index: 8),
          _buildTab("${AppLocalizations.of(context)!.testAllDoctorsPageSC}",
              index: 9),
          // _buildTab("All", index: 0),
          // _buildTab("General", index: 1),
          // _buildTab("PediatrÃ­a", index: 2),
          // _buildTab("NeurologÃ­a", index: 3),
          // _buildTab("GINECOLOGÃA", index: 4),
          // _buildTab("DERMATOLOGÃA", index: 5),
          // _buildTab("PSIQUIATRÃA", index: 6),
          // _buildTab("PSICOLOGÃA", index: 7),
          // _buildTab("MÃDICO LABORAL", index: 8),
          // _buildTab("Test", index: 9),

          // Add more tabs here as needed
        ],
      ),
    );
  }

  Widget _buildTab(String title, {required int index}) {
    return GestureDetector(
      onTap: () {
        _selectedIndex = index;
        print(_selectedIndex);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(title,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.blue,
              )),
        ),
      ),
    );
  }

  // section one.....
  Widget _buildAllDoctors() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "${doctors.length} ${AppLocalizations.of(context)!.foundAllDoctorsPageSC}",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            var doctor = doctors[index];
            print("doctor:");
            // print(doctor['fullName'] ?? 'Unknown');
            // print(doctor['specialization'] ?? 'Unknown');
            print(doctor['score']);
            // print("last name is: ${doctor['lastName']}");
            // print(doctor['city']);
            // print("profile image url is: ${doctor['profileImageURL']}");

            return doctors.isEmpty
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}")
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        // RichText(
                                        //   text: TextSpan(
                                        //     children: [
                                        //       TextSpan(
                                        //         text: "\$",
                                        //         style: CustomTextStyles
                                        //             .titleMediumff0ebe7f,
                                        //       ),
                                        //       TextSpan(
                                        //         text: " ",
                                        //       ),
                                        //       TextSpan(
                                        //         text: "28.00/hr",
                                        //         style: CustomTextStyles
                                        //             .bodyLargee5677294,
                                        //       ),
                                        //     ],
                                        //   ),
                                        //   textAlign: TextAlign.left,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 2
  Widget _buildGeneralMedicineDoctors() {
    List<Map<String, dynamic>> generalMedicineDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.medicinaGeneralAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${generalMedicineDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: generalMedicineDoctors.length,
          itemBuilder: (context, index) {
            var doctor = generalMedicineDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return doctors.isEmpty
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}")
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 3....
  Widget _buildPediatrAaDoctors() {
    List<Map<String, dynamic>> pediatrAaDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.pediatrAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${pediatrAaDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pediatrAaDoctors.length,
          itemBuilder: (context, index) {
            var doctor = pediatrAaDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return doctors.isEmpty
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 4....
  Widget _buildNeurologAaDoctors() {
    List<Map<String, dynamic>> NeurologAaDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.noroloAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${NeurologAaDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: NeurologAaDoctors.length,
          itemBuilder: (context, index) {
            var doctor = NeurologAaDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return NeurologAaDoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 5....
  Widget _buildGINECOLOGAADoctors() {
    List<Map<String, dynamic>> GINECOLOGAADoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.ginecolAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${GINECOLOGAADoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: GINECOLOGAADoctors.length,
          itemBuilder: (context, index) {
            var doctor = GINECOLOGAADoctors[index];
            print("doctor:");
            print(doctor['score']);

            return GINECOLOGAADoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

// section 6....

  Widget _DERMATOLOGADoctors() {
    List<Map<String, dynamic>> DERMATOLOGADoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.dermatoloAAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${DERMATOLOGADoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: DERMATOLOGADoctors.length,
          itemBuilder: (context, index) {
            var doctor = DERMATOLOGADoctors[index];
            print("doctor:");
            print(doctor['score']);

            return DERMATOLOGADoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 7..................
  Widget _PSIQUIATRADoctors() {
    List<Map<String, dynamic>> PSIQUIATRADoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.psiquiaAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${PSIQUIATRADoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: PSIQUIATRADoctors.length,
          itemBuilder: (context, index) {
            var doctor = PSIQUIATRADoctors[index];
            print("doctor:");
            print(doctor['score']);

            return PSIQUIATRADoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // section 8 .......
  Widget _PSICOLOGaaDoctors() {
    List<Map<String, dynamic>> PSICOLOGaaDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.psicoloAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${PSICOLOGaaDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: PSICOLOGaaDoctors.length,
          itemBuilder: (context, index) {
            var doctor = PSICOLOGaaDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return PSICOLOGaaDoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

// section 9 .....
  Widget _LABORALDoctors() {
    List<Map<String, dynamic>> LABORALDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.madicoLaboralAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${LABORALDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: LABORALDoctors.length,
          itemBuilder: (context, index) {
            var doctor = LABORALDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return LABORALDoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

// section 10 ....
  Widget _TestDoctors() {
    List<Map<String, dynamic>> LABORALDoctors = doctors
        .where((doctor) =>
            doctor['specialization'] ==
            '${AppLocalizations.of(context)!.testAllDoctorsPageSC}')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${LABORALDoctors.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: LABORALDoctors.length,
          itemBuilder: (context, index) {
            var doctor = LABORALDoctors[index];
            print("doctor:");
            print(doctor['score']);

            return LABORALDoctors.length == 0
                ? Text(
                    "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
                    style: TextStyle(color: Colors.black),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(17.h),
                      decoration: AppDecoration.outlineBlack.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              right: 49.h,
                            ),
                            child: Row(
                              children: [
                                doctor['profileImageURL'] ==
                                        '${AppLocalizations.of(context)!.noImgAvaliableAllDoctorsPageSC}'
                                    ? Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/doc.jpg'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 87.v,
                                        width: 92.h,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                doctor['profileImageURL']),
                                          ),
                                        ),
                                      ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 13.h,
                                      top: 3.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                doctor['fullName'] ?? 'Unknown',
                                                overflow: TextOverflow.fade,
                                                style: CustomTextStyles
                                                    .titleMediumBluegray9000518,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          doctor['specialization'] ?? 'Unknown',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgSettings,
                                              height: 14.adaptSize,
                                              width: 14.adaptSize,
                                              color: Colors.grey,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.v),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.h),
                                              child: Text(
                                                doctor['city'] ?? "Unknow",
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.v),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$",
                                                style: CustomTextStyles
                                                    .titleMediumff0ebe7f,
                                              ),
                                              TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: "28.00/hr",
                                                style: CustomTextStyles
                                                    .bodyLargee5677294,
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 17.v,
                                    bottom: 1.v,
                                  ),
                                  child: CustomRatingStars(
                                    rating: doctor['score'] ?? 0.0,
                                    emptyColor: Colors.grey,
                                    fillColor: Colors.amber,
                                    maxStars: 5,
                                  ),
                                ),
                                _buildBookNow(context, doctor['id']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  // Function to fetch doctors from the API
  Future<void> _fetchDoctors() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Fetch doctors from the API
      var fetchedDoctors = await PatientApiService().fetchDoctors();
      setState(() {
        // Update the state with the fetched doctors
        doctors = fetchedDoctors;
      });
    } catch (error) {
      // Handle errors
      print("Error fetching doctors: $error");
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBookNow(BuildContext context, int doctorId) {
    return CustomElevatedButton(
      onPressed: () {
        print("doctor id is: $doctorId");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(
                docId: doctorId,
              ),
            ));
      },
      height: 34.v,
      width: 112.h,
      text: "${AppLocalizations.of(context)!.bookNowBooknow1ItemWidgetSC}",
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }
}
