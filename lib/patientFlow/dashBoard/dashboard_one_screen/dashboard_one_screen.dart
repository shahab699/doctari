import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/all_doctors_page/widgets/rating_stars_widget.dart';
import 'package:doctari/patientFlow/appointment_booking_flow/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctari/patientFlow/patientMenu/PatientDrawer/MainDrawerScreen.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_eight.dart';
import 'package:doctari/widgets/app_bar/appbar_title.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:doctari/widgets/custom_search_view.dart';
import 'package:doctari/widgets/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'widgets/dashboardone_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientDashboardOneScreen extends StatefulWidget {
  final int currentUserId;
  final String token;
  PatientDashboardOneScreen(
      {required this.currentUserId, required this.token, Key? key})
      : super(key: key);

  @override
  State<PatientDashboardOneScreen> createState() =>
      _PatientDashboardOneScreenState();
}

class _PatientDashboardOneScreenState extends State<PatientDashboardOneScreen> {
  TextEditingController searchController = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  DropdownItem? category;
  List<DropdownItem> dropdownItems = [];
  late List<Map<String, dynamic>> doctors;
  String? cat;
  bool isLoading = false;
  bool isLoadingSp = false;

  String? firstName;
  String? lastName;
  String? profilePicture;
  bool isLoadingpr = false;
  @override
  void initState() {
    super.initState();
    doctors = [];
    _fetchDoctors();
    _fetchCategory();
    fetchPatientData();
    debugPrint("patient id: ${widget.currentUserId}");
    debugPrint("patient token: ${widget.token}");
    debugPrint("First Name: $firstName");
    debugPrint("Last Name: $lastName");
  }

  Future<void> fetchPatientData() async {
    setState(() {
      isLoadingpr = true;
    });
    try {
      debugPrint("patient id: ${widget.currentUserId}");
      debugPrint("First Name: $firstName");
      debugPrint("Last Name: $lastName");
      Patient patient = await PatientApiService()
          .fetchPatient(widget.currentUserId, widget.token);
      // Update text field controllers with fetched data
      setState(() {
        firstName = patient.firstName;
        lastName = patient.lastName;
        profilePicture = patient.profileImage;
      });

      // Update other text field controllers with respective fields from the patient object
    } catch (e) {
      // Handle errors
      print('Error fetching patient data: $e');
    }
    setState(() {
      isLoadingpr = false;
    });
  }

// fetch doctors....
  // Function to fetch doctors from the API
  // Future<void> _fetchDoctors() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //       isLoadingSp = true;
  //     });
  //     // Fetch doctors from the API
  //     var fetchedDoctors = await PatientApiService().fetchDoctors();
  //     setState(() {
  //       // Update the state with the fetched doctors
  //       doctors = fetchedDoctors;
  //       isLoading = false;
  //       isLoadingSp = false;
  //     });
  //   } catch (error) {
  //     // Handle errors
  //     print("Error fetching doctors: $error");
  //   }
  // }

  Future<void> _fetchDoctors() async {
    try {
      setState(() {
        isLoading = true;
        isLoadingSp = true;
      });
      // Fetch doctors from the API
      var fetchedDoctors = await PatientApiService().fetchDoctors();
      setState(() {
        // Update the state with the fetched doctors
        doctors = fetchedDoctors;
        isLoading = false;
        isLoadingSp = false;
      });
    } catch (error) {
      // Handle errors
      print("Error fetching doctors: $error");
      setState(() {
        isLoading = false;
        isLoadingSp = false;
      });
    }
  }

  Future<void> _fetchCategory() async {
    List<DropdownItem> categories =
        await PatientApiService.fetchCategoriesForPatientHomeScreen();
    setState(() {
      dropdownItems = categories;
    });
  }

  // switch

  Widget _buildSpecialtyDoctors(String category) {
    switch (category) {
      case "Pediatría":
        return _buildPediatrAaDoctors();
      case "Neurología":
        return _buildNeurologAaDoctors();
      case "GINECOLOGÍA":
        return _buildGINECOLOGAADoctors();
      case "DERMATOLOGÍA":
        return _DERMATOLOGADoctors();
      case "PSIQUIATRÍA":
        return _PSIQUIATRADoctors();
      case "PSICOLOGÍA":
        return _PSICOLOGaaDoctors();
      case "MÉDICO LABORAL":
        return _LABORALDoctors();
      case "Test":
        return _TestDoctors();
      case "Medicina General":
        return _buildGeneralMedicineDoctors();
      default:
        return _buildAllDoctors();
    }
  }

  @override
  Widget build(BuildContext context) {
    // int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
    // String? patientAccessToken =
    //     Provider.of<ProviderForStoringValues>(context).accessToken;
    return SafeArea(
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            _buildHiAbdul(context),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(
                      //       color: Colors.grey.shade300,
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Center(
                      //     child: DropdownButtonFormField<DropdownItem>(
                      //       decoration: InputDecoration(
                      //         hintText:
                      //             '${AppLocalizations.of(context)!.selectSpecialtyDashboardOneScreenSC}',
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //           borderSide: BorderSide(
                      //             color: Colors.grey.withOpacity(0.6),
                      //             width: 1,
                      //           ),
                      //         ),
                      //       ),
                      //       value: category,
                      //       items: dropdownItems.map((item) {
                      //         return DropdownMenuItem<DropdownItem>(
                      //           value: item,
                      //           child: Center(
                      //             child: Text(
                      //               item.label,
                      //               style: TextStyle(
                      //                 fontSize: 14,
                      //                 color: Colors.black,
                      //               ),
                      //               overflow: TextOverflow.ellipsis,
                      //             ),
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (selectedItem) {
                      //         setState(() {
                      //           cat = selectedItem!.label;
                      //           debugPrint("selected category: $cat");
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),

                      Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(8),
                        //   border:
                        //       Border.all(color: Colors.grey.shade300, width: 1),
                        // ),
                        child: Center(
                          child: DropdownButtonFormField<DropdownItem>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.6),
                                  width: 1,
                                ),
                              ),
                              // Remove the default content padding
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 16),
                              // Add an empty hintText to ensure it doesn't get misplaced
                              hintText:
                                  '${AppLocalizations.of(context)!.selectSpecialtyDashboardOneScreenSC}',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            value: category,
                            items: dropdownItems.map((item) {
                              return DropdownMenuItem<DropdownItem>(
                                value: item,
                                child: Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            hint: Align(
                              alignment: Alignment
                                  .centerLeft, // Align the hint text to the center
                              child: Text(
                                AppLocalizations.of(context)!
                                    .selectSpecialtyDashboardOneScreenSC,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onChanged: (selectedItem) {
                              setState(() {
                                cat = selectedItem!.label;
                                debugPrint("selected category: $cat");
                              });
                            },
                          ),
                        ),
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       border: Border.all(
                      //           color: Colors.grey.shade300, width: 1)),
                      //   child: Center(
                      //     child: DropdownButtonFormField<DropdownItem>(
                      //       decoration: InputDecoration(
                      //         hintText:
                      //             '${AppLocalizations.of(context)!.selectSpecialtyDashboardOneScreenSC}',
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //           borderSide: BorderSide(
                      //             color: Colors.grey.withOpacity(0.6),
                      //             width: 1,
                      //           ),
                      //         ),

                      //         contentPadding: EdgeInsets.zero,
                      //         // contentPadding: EdgeInsets.only(
                      //         //     right: 16, left: 16, bottom: 30),
                      //       ),
                      //       value: category,
                      //       items: dropdownItems.map((item) {
                      //         return DropdownMenuItem<DropdownItem>(
                      //           value: item,
                      //           child: Text(
                      //             item.label,
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               color: Colors.black,
                      //             ),
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (selectedItem) {
                      //         setState(() {
                      //           cat = selectedItem!.label;
                      //           debugPrint("selected category: $cat");
                      //         });
                      //       },
                      //     ),
                      //   ),
                      //   // CustomDropDown(
                      //   //   hintText: "Select Specialty",
                      //   //   hintStyle: TextStyle(
                      //   //       fontSize: 13,
                      //   //       fontWeight: FontWeight.w500,
                      //   //       color: Colors.grey),
                      //   //   items: dropdownItemList,
                      //   //   borderDecoration: DropDownStyleHelper.outlineBlack,
                      //   //   onChanged: (value) {},
                      //   // ),
                      // ),

                      SizedBox(height: 19.v),
                      _buildBanner(context),
                      SizedBox(height: 19.v),
                      // _buildDashboardOne(context),

                      cat == null
                          ? _buildAllDoctors()
                          : _buildSpecialtyDoctors(cat!),

                      SizedBox(height: 20.v),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 30,
                      //       width: 30,
                      //       margin: EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.grey.shade300, width: 1),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.arrow_back_ios_new,
                      //           size: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       height: 30,
                      //       width: 30,
                      //       margin: EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           color: Color(0xff0066FF),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Center(
                      //         child: Text(
                      //           "1",
                      //           style: TextStyle(
                      //               fontSize: 15,
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Container(
                      //         height: 30,
                      //         width: 30,
                      //         margin: EdgeInsets.all(5),
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             border: Border.all(
                      //                 color: Colors.grey.shade300, width: 1),
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: Center(
                      //           child: Text(
                      //             "2",
                      //             style: TextStyle(
                      //                 fontSize: 15,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       height: 30,
                      //       width: 30,
                      //       margin: EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.grey.shade300, width: 1),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Center(
                      //         child: Text(
                      //           "...",
                      //           style: TextStyle(
                      //               fontSize: 15,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       height: 30,
                      //       width: 30,
                      //       margin: EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.grey.shade300, width: 1),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.arrow_forward_ios,
                      //           size: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10.v),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHiAbdul(
    BuildContext context,
  ) {
    return Container(
      color: Colors.transparent,
      // height: MediaQuery.of(context).size.height * 0.17,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(colors: [
                  Color(0xff33CEFF),
                  Color(0xff0066FF),
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hi $firstName $lastName',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        AppbarTitle(
                          text:
                              "${AppLocalizations.of(context)!.findDoctorDashboardAfterBookingScrnSC}",
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    // await PatientApiService().fetchAppointments();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientMainDrawer(
                            name: '$firstName $lastName',
                            profileImage: profilePicture != null
                                ? profilePicture!
                                : 'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                          ),
                        ));
                  },
                  child: isLoadingpr
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          // backgroundImage: AssetImage(
                          //   ImageConstant.imgEllipse2660x60,
                          // ),
                          backgroundImage: profilePicture != null
                              // Display the selected image
                              ? NetworkImage(profilePicture!)
                              : NetworkImage(
                                  'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                                ),
                        ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: 20.h,
          //       right: 20.h,
          //       top: MediaQuery.of(context).size.height * 0.11),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       // CustomSearchView(
          //       //   borderDecoration: OutlineInputBorder(
          //       //       borderRadius: BorderRadius.circular(8),
          //       //       borderSide: BorderSide(
          //       //           color: Colors.grey.shade300,
          //       //           width: 1,
          //       //           style: BorderStyle.solid)),
          //       //   filled: true,
          //       //   fillColor: Colors.white,
          //       //   controller: searchController,
          //       //   hintText: "Name",
          //       //   prefix: IconButton(
          //       //     onPressed: () {},
          //       //     icon: Icon(
          //       //       Icons.search,
          //       //       color: Colors.grey,
          //       //       size: 20,
          //       //     ),
          //       //   ),
          //       //   suffix: IconButton(
          //       //     onPressed: () {},
          //       //     icon: Icon(
          //       //       Icons.filter_list,
          //       //       color: Colors.grey,
          //       //       size: 20,
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),

          // CustomAppBar(
          //   height: 127.v,
          //   title: Padding(
          //     padding: EdgeInsets.only(
          //       left: 19.h,
          //       top: 16.v,
          //       bottom: 48.v,
          //     ),
          //     child: Column(
          //       children: [
          //         AppbarSubtitleEight(
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
          //     GestureDetector(
          //       onTap: (){
          //
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.only(
          //           bottom: 30,
          //           right: 10
          //         ),
          //         child: CircleAvatar(
          //           backgroundColor: Colors.black,
          //           radius: 30,
          //           backgroundImage: AssetImage(
          //             ImageConstant.imgEllipse2660x60,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          //   styleType: Style.bgGradientnamelightblueA200nameprimary,
          // ),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return SizedBox(
      height: 163.v,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage163x334,
            height: 163.v,
            width: 334.h,
            radius: BorderRadius.circular(12.h),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(right: 163.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 105.v,
                    width: 171.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgBackground99x114,
                        //   height: 99.v,
                        //   width: 114.h,
                        //   alignment: Alignment.topLeft,
                        // ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 11.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160.h,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.lookingforDashboardOneScreenSC}\n${AppLocalizations.of(context)!.specialistDoctorsDashboardOneScreenSC}?",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleMediumTeal300
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.v),
                                Container(
                                  width: 138.h,
                                  margin: EdgeInsets.only(right: 21.h),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.topDoctorsDashboardOneScreenSC}.",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .bodySmallSecondaryContainer
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 12.v,
                      width: 83.h,
                      margin: EdgeInsets.only(right: 20.h),
                      decoration: BoxDecoration(
                        color: appTheme.blueGray10033,
                        borderRadius: BorderRadius.circular(41.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // section one.....

  Widget _buildAllDoctors() {
    if (isLoading) {
      // Show circular progress indicator when loading
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "${doctors.length} found",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            var doctor = doctors[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailsScreen(
                        docId: doctor[
                            'id'], // Pass the doctor ID to the next screen
                      ),
                    ),
                  );
                  print("new id: ${doctor['id']}");
                },
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
                        padding: EdgeInsets.only(left: 4.h, right: 49.h),
                        child: Row(
                          children: [
                            doctor['profileImageURL'] == 'No image available'
                                ? Container(
                                    height: 87.v,
                                    width: 92.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('assets/images/doc.jpg'),
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
                                        image: NetworkImage(
                                            doctor['profileImageURL']),
                                      ),
                                    ),
                                  ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 13.h, top: 3.v),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: 5.v),
                                    Text(
                                      doctor['specialization'] ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(height: 5.v),
                                    Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgSettings,
                                          height: 14.adaptSize,
                                          width: 14.adaptSize,
                                          color: Colors.grey,
                                          margin: EdgeInsets.only(bottom: 2.v),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text(
                                            doctor['city'] ?? "Unknown",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.v),
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
                              padding: EdgeInsets.only(top: 17.v, bottom: 1.v),
                              child: doctor['score'] != null &&
                                      doctor['score'] > 0.0
                                  ? CustomRatingStars(
                                      rating: doctor['score'] ?? 0.0,
                                      emptyColor: Colors.grey,
                                      fillColor: Colors.amber,
                                      maxStars: 5,
                                    )
                                  : SizedBox
                                      .shrink(), // Use SizedBox.shrink() to occupy no space if no rating
                            ),

                            // Padding(
                            //   padding: EdgeInsets.only(top: 17.v, bottom: 1.v),
                            //   child: CustomRatingStars(
                            //     rating: doctor['score'] ?? 0.0,
                            //     emptyColor: Colors.grey,
                            //     fillColor: Colors.amber,
                            //     maxStars: 5,
                            //   ),
                            // ),
                            _buildBookNow(context, doctor['id']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget _buildAllDoctors() {

  //   if (isLoading) {
  //     // Show circular progress indicator when loading
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }

  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => DoctorDetailsScreen(
  //                 //docId: ,
  //                 ),
  //           ));
  //     },
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Row(
  //             children: [
  //               Text(
  //                 "${doctors.length} found",
  //                 style: Theme.of(context).textTheme.titleMedium,
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         ListView.builder(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           physics: NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           itemCount: doctors.length,
  //           itemBuilder: (context, index) {
  //             var doctor = doctors[index];

  //             return Padding(
  //               padding: const EdgeInsets.only(bottom: 10),
  //               child: Container(
  //                 padding: EdgeInsets.all(17.h),
  //                 decoration: AppDecoration.outlineBlack.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder6,
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 4.h, right: 49.h),
  //                       child: Row(
  //                         children: [
  //                           doctor['profileImageURL'] == 'No image available'
  //                               ? Container(
  //                                   height: 87.v,
  //                                   width: 92.h,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.grey,
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     image: DecorationImage(
  //                                       fit: BoxFit.cover,
  //                                       image:
  //                                           AssetImage('assets/images/doc.jpg'),
  //                                     ),
  //                                   ),
  //                                 )
  //                               : Container(
  //                                   height: 87.v,
  //                                   width: 92.h,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.amber,
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     image: DecorationImage(
  //                                       fit: BoxFit.cover,
  //                                       image: NetworkImage(
  //                                           doctor['profileImageURL']),
  //                                     ),
  //                                   ),
  //                                 ),
  //                           Expanded(
  //                             flex: 2,
  //                             child: Padding(
  //                               padding: EdgeInsets.only(left: 13.h, top: 3.v),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Row(
  //                                     children: [
  //                                       Flexible(
  //                                         child: Text(
  //                                           doctor['fullName'] ?? 'Unknown',
  //                                           overflow: TextOverflow.fade,
  //                                           style: CustomTextStyles
  //                                               .titleMediumBluegray9000518,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(height: 5.v),
  //                                   //Text(doctor['id'].toString()),
  //                                   Text(
  //                                     doctor['specialization'] ?? 'Unknown',
  //                                     style: Theme.of(context)
  //                                         .textTheme
  //                                         .bodyMedium,
  //                                   ),
  //                                   SizedBox(height: 5.v),
  //                                   Row(
  //                                     children: [
  //                                       CustomImageView(
  //                                         imagePath: ImageConstant.imgSettings,
  //                                         height: 14.adaptSize,
  //                                         width: 14.adaptSize,
  //                                         color: Colors.grey,
  //                                         margin: EdgeInsets.only(bottom: 2.v),
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(left: 4.h),
  //                                         child: Text(
  //                                           doctor['city'] ?? "Unknown",
  //                                           style: Theme.of(context)
  //                                               .textTheme
  //                                               .bodySmall,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(height: 20.v),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(height: 14.v),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 4.h),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.only(top: 17.v, bottom: 1.v),
  //                             child: CustomRatingStars(
  //                               rating: doctor['score'] ?? 0.0,
  //                               emptyColor: Colors.grey,
  //                               fillColor: Colors.amber,
  //                               maxStars: 5,
  //                             ),
  //                           ),
  //                           _buildBookNow(context, doctor['id']),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildAllDoctors() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         child: Row(
  //           children: [
  //             Text(
  //               "${doctors.length} found",
  //               style: theme.textTheme.titleMedium,
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       ListView.builder(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: doctors.length,
  //         itemBuilder: (context, index) {
  //           var doctor = doctors[index];
  //           print("doctor:");
  //           // print(doctor['fullName'] ?? 'Unknown');
  //           // print(doctor['specialization'] ?? 'Unknown');
  //           print(doctor['score']);
  //           // print("last name is: ${doctor['lastName']}");
  //           // print(doctor['city']);
  //           // print("profile image url is: ${doctor['profileImageURL']}");

  //           return doctors.isEmpty
  //               ? Text(
  //                   "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}")
  //               : Padding(
  //                   padding: const EdgeInsets.only(bottom: 10),
  //                   child: Container(
  //                     padding: EdgeInsets.all(17.h),
  //                     decoration: AppDecoration.outlineBlack.copyWith(
  //                       borderRadius: BorderRadiusStyle.roundedBorder6,
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             left: 4.h,
  //                             right: 49.h,
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               doctor['profileImageURL'] ==
  //                                       'No image available'
  //                                   ? Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.grey,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: AssetImage(
  //                                               'assets/images/doc.jpg'),
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.amber,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: NetworkImage(
  //                                               doctor['profileImageURL']),
  //                                         ),
  //                                       ),
  //                                     ),
  //                               Expanded(
  //                                 flex: 2,
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 13.h,
  //                                     top: 3.v,
  //                                   ),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Flexible(
  //                                             child: Text(
  //                                               doctor['fullName'] ?? 'Unknown',
  //                                               overflow: TextOverflow.fade,
  //                                               style: CustomTextStyles
  //                                                   .titleMediumBluegray9000518,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(
  //                                         height: 5.v,
  //                                       ),
  //                                       Text(
  //                                         doctor['specialization'] ?? 'Unknown',
  //                                         style: theme.textTheme.bodyMedium,
  //                                       ),
  //                                       SizedBox(
  //                                         height: 5.v,
  //                                       ),
  //                                       Row(
  //                                         children: [
  //                                           CustomImageView(
  //                                             imagePath:
  //                                                 ImageConstant.imgSettings,
  //                                             height: 14.adaptSize,
  //                                             width: 14.adaptSize,
  //                                             color: Colors.grey,
  //                                             margin:
  //                                                 EdgeInsets.only(bottom: 2.v),
  //                                           ),
  //                                           Padding(
  //                                             padding:
  //                                                 EdgeInsets.only(left: 4.h),
  //                                             child: Text(
  //                                               doctor['city'] ?? "Unknow",
  //                                               style:
  //                                                   theme.textTheme.bodySmall,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 20.v),
  //                                       // RichText(
  //                                       //   text: TextSpan(
  //                                       //     children: [
  //                                       //       TextSpan(
  //                                       //         text: "\$",
  //                                       //         style: CustomTextStyles
  //                                       //             .titleMediumff0ebe7f,
  //                                       //       ),
  //                                       //       TextSpan(
  //                                       //         text: " ",
  //                                       //       ),
  //                                       //       TextSpan(
  //                                       //         text: "28.00/hr",
  //                                       //         style: CustomTextStyles
  //                                       //             .bodyLargee5677294,
  //                                       //       ),
  //                                       //     ],
  //                                       //   ),
  //                                       //   textAlign: TextAlign.left,
  //                                       // ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 14.v),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 4.h),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.only(
  //                                   top: 17.v,
  //                                   bottom: 1.v,
  //                                 ),
  //                                 child: CustomRatingStars(
  //                                   rating: doctor['score'] ?? 0.0,
  //                                   emptyColor: Colors.grey,
  //                                   fillColor: Colors.amber,
  //                                   maxStars: 5,
  //                                 ),
  //                               ),
  //                               _buildBookNow(context, doctor['id']),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //         },
  //       ),
  //     ],
  //   );
  // }

  // section 2
  Widget _buildGeneralMedicineDoctors() {
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> generalMedicineDoctors = doctors
        .where((doctor) => doctor['specialization'] == 'Medicina General')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> pediatrAaDoctors = doctors
        .where((doctor) => doctor['specialization'] == 'Pediatría')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> NeurologAaDoctors = doctors
        .where((doctor) => doctor['specialization'] == 'Neurología')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> GINECOLOGAADoctors = doctors
        .where((doctor) => doctor['specialization'] == 'GINECOLOGÍA')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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

//here add UTF code for regular expression

  // Widget _DERMATOLOGADoctors() {
  //   // Filter doctors with specialization 'DERMATOLOGIA'
  //   List<Map<String, dynamic>> dermatologists = doctors
  //       .where((doctor) => doctor['specialization'] == 'DERMATOLOGÃA')
  //       .toList();
  //   print('dermatology $dermatologists');
  //   print("response $doctors['specialization']");
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         child: Row(
  //           children: [
  //             Text(
  //               '${dermatologists.length} found',
  //               style: theme.textTheme.titleMedium,
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       ListView.builder(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: dermatologists.length,
  //         itemBuilder: (context, index) {
  //           var doctor = dermatologists[index];

  //           return dermatologists.isEmpty
  //               ? Text(
  //                   "${AppLocalizations.of(context)!..noDocAvaliableAllDoctorsPageSC}",
  //                   style: TextStyle(color: Colors.black),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.only(bottom: 10),
  //                   child: Container(
  //                     padding: EdgeInsets.all(17.h),
  //                     decoration: AppDecoration.outlineBlack.copyWith(
  //                       borderRadius: BorderRadiusStyle.roundedBorder6,
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             left: 4.h,
  //                             right: 49.h,
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               // Display profile image or placeholder
  //                               doctor['profileImageURL'] ==
  //                                       'No image available'
  //                                   ? Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.grey,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: AssetImage(
  //                                               'assets/images/doc.jpg'),
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         //here to change color that display first
  //                                         //color: Colors.amber,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: NetworkImage(
  //                                               doctor['profileImageURL']),
  //                                         ),
  //                                       ),
  //                                     ),
  //                               Expanded(
  //                                 flex: 2,
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 13.h,
  //                                     top: 3.v,
  //                                   ),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Flexible(
  //                                             child: Text(
  //                                               doctor['fullName'] ?? 'Unknown',
  //                                               overflow: TextOverflow.fade,
  //                                               style: CustomTextStyles
  //                                                   .titleMediumBluegray9000518,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Text(
  //                                         doctor['specialization'] ?? 'Unknown',
  //                                         style: theme.textTheme.bodyMedium,
  //                                       ),
  //                                       Row(
  //                                         children: [
  //                                           CustomImageView(
  //                                             imagePath:
  //                                                 ImageConstant.imgSettings,
  //                                             height: 14.adaptSize,
  //                                             width: 14.adaptSize,
  //                                             color: Colors.grey,
  //                                             margin:
  //                                                 EdgeInsets.only(bottom: 2.v),
  //                                           ),
  //                                           Padding(
  //                                             padding:
  //                                                 EdgeInsets.only(left: 4.h),
  //                                             child: Text(
  //                                               doctor['city'] ?? "Unknown",
  //                                               style:
  //                                                   theme.textTheme.bodySmall,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 5.v),
  //                                       RichText(
  //                                         text: TextSpan(
  //                                           children: [
  //                                             TextSpan(
  //                                               text: "\$",
  //                                               style: CustomTextStyles
  //                                                   .titleMediumff0ebe7f,
  //                                             ),
  //                                             TextSpan(
  //                                               text: " ",
  //                                             ),
  //                                             TextSpan(
  //                                               text: "28.00/hr",
  //                                               style: CustomTextStyles
  //                                                   .bodyLargee5677294,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         textAlign: TextAlign.left,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 14.v),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 4.h),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.only(
  //                                   top: 17.v,
  //                                   bottom: 1.v,
  //                                 ),
  //                                 child: CustomRatingStars(
  //                                   rating: doctor['score'] ?? 0.0,
  //                                   emptyColor: Colors.grey,
  //                                   fillColor: Colors.amber,
  //                                   maxStars: 5,
  //                                 ),
  //                               ),
  //                               _buildBookNow(context, doctor['id']),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _DERMATOLOGADoctors() {
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }

    // Filter doctors with specialization 'DERMATOLOGIA'
    List<Map<String, dynamic>> dermatologists = doctors
        .where((doctor) => doctor['specialization'] == 'DERMATOLOGIA')
        .toList();

    if (dermatologists.isEmpty) {
      return Center(
        child: Text(
          "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                '${dermatologists.length} found',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dermatologists.length,
          itemBuilder: (context, index) {
            var doctor = dermatologists[index];

            return Padding(
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
                      padding: EdgeInsets.only(left: 4.h, right: 49.h),
                      child: Row(
                        children: [
                          // Display profile image or placeholder
                          doctor['profileImageURL'] == 'No image available'
                              ? Container(
                                  height: 87.v,
                                  width: 92.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage('assets/images/doc.jpg'),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 87.v,
                                  width: 92.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
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
                              padding: EdgeInsets.only(left: 13.h, top: 3.v),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        imagePath: ImageConstant.imgSettings,
                                        height: 14.adaptSize,
                                        width: 14.adaptSize,
                                        color: Colors.grey,
                                        margin: EdgeInsets.only(bottom: 2.v),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.h),
                                        child: Text(
                                          doctor['city'] ?? "Unknown",
                                          style: theme.textTheme.bodySmall,
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
                            padding: EdgeInsets.only(top: 17.v, bottom: 1.v),
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

  // Widget _DERMATOLOGADoctors() {
  //   List<Map<String, dynamic>> DERMATOLOGADoctors = doctors
  //       .where((doctor) => doctor['specialization'] == 'DERMATOLOGIA')
  //       .toList();

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         child: Row(
  //           children: [
  //             Text(
  //               '${DERMATOLOGADoctors.length} found',
  //               style: theme.textTheme.titleMedium,
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       ListView.builder(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: DERMATOLOGADoctors.length,
  //         itemBuilder: (context, index) {
  //           var doctor = DERMATOLOGADoctors[index];
  //           print("doctor:");
  //           print(doctor['score']);

  //           return DERMATOLOGADoctors.length == 0
  //               ? Text(
  //                   "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
  //                   style: TextStyle(color: Colors.black),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.only(bottom: 10),
  //                   child: Container(
  //                     padding: EdgeInsets.all(17.h),
  //                     decoration: AppDecoration.outlineBlack.copyWith(
  //                       borderRadius: BorderRadiusStyle.roundedBorder6,
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             left: 4.h,
  //                             right: 49.h,
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               doctor['profileImageURL'] ==
  //                                       'No image available'
  //                                   ? Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.grey,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: AssetImage(
  //                                               'assets/images/doc.jpg'),
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.amber,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: NetworkImage(
  //                                               doctor['profileImageURL']),
  //                                         ),
  //                                       ),
  //                                     ),
  //                               Expanded(
  //                                 flex: 2,
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 13.h,
  //                                     top: 3.v,
  //                                   ),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Flexible(
  //                                             child: Text(
  //                                               doctor['fullName'] ?? 'Unknown',
  //                                               overflow: TextOverflow.fade,
  //                                               style: CustomTextStyles
  //                                                   .titleMediumBluegray9000518,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Text(
  //                                         doctor['specialization'] ?? 'Unknown',
  //                                         style: theme.textTheme.bodyMedium,
  //                                       ),
  //                                       Row(
  //                                         children: [
  //                                           CustomImageView(
  //                                             imagePath:
  //                                                 ImageConstant.imgSettings,
  //                                             height: 14.adaptSize,
  //                                             width: 14.adaptSize,
  //                                             color: Colors.grey,
  //                                             margin:
  //                                                 EdgeInsets.only(bottom: 2.v),
  //                                           ),
  //                                           Padding(
  //                                             padding:
  //                                                 EdgeInsets.only(left: 4.h),
  //                                             child: Text(
  //                                               doctor['city'] ?? "Unknown",
  //                                               style:
  //                                                   theme.textTheme.bodySmall,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 5.v),
  //                                       RichText(
  //                                         text: TextSpan(
  //                                           children: [
  //                                             TextSpan(
  //                                               text: "\$",
  //                                               style: CustomTextStyles
  //                                                   .titleMediumff0ebe7f,
  //                                             ),
  //                                             TextSpan(
  //                                               text: " ",
  //                                             ),
  //                                             TextSpan(
  //                                               text: "28.00/hr",
  //                                               style: CustomTextStyles
  //                                                   .bodyLargee5677294,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         textAlign: TextAlign.left,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 14.v),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 4.h),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.only(
  //                                   top: 17.v,
  //                                   bottom: 1.v,
  //                                 ),
  //                                 child: CustomRatingStars(
  //                                   rating: doctor['score'] ?? 0.0,
  //                                   emptyColor: Colors.grey,
  //                                   fillColor: Colors.amber,
  //                                   maxStars: 5,
  //                                 ),
  //                               ),
  //                               _buildBookNow(context, doctor['id']),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _DERMATOLOGADoctors() {
  //   List<Map<String, dynamic>> DERMATOLOGADoctors = doctors
  //       .where((doctor) => doctor['specialization'] == 'DERMATOLOGÃA')
  //       .toList();
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         child: Row(
  //           children: [
  //             Text(
  //               '${DERMATOLOGADoctors.length} found',
  //               style: theme.textTheme.titleMedium,
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       ListView.builder(
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: DERMATOLOGADoctors.length,
  //         itemBuilder: (context, index) {
  //           var doctor = DERMATOLOGADoctors[index];
  //           print("doctor:");
  //           print(doctor['score']);

  //           return DERMATOLOGADoctors.length == 0
  //               ? Text(
  //                   "${AppLocalizations.of(context)!.noDocAvaliableAllDoctorsPageSC}",
  //                   style: TextStyle(color: Colors.black),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.only(bottom: 10),
  //                   child: Container(
  //                     padding: EdgeInsets.all(17.h),
  //                     decoration: AppDecoration.outlineBlack.copyWith(
  //                       borderRadius: BorderRadiusStyle.roundedBorder6,
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             left: 4.h,
  //                             right: 49.h,
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               doctor['profileImageURL'] ==
  //                                       'No image available'
  //                                   ? Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.grey,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: AssetImage(
  //                                               'assets/images/doc.jpg'),
  //                                         ),
  //                                       ),
  //                                     )
  //                                   : Container(
  //                                       height: 87.v,
  //                                       width: 92.h,
  //                                       decoration: BoxDecoration(
  //                                         color: Colors.amber,
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                         image: DecorationImage(
  //                                           fit: BoxFit.cover,
  //                                           image: NetworkImage(
  //                                               doctor['profileImageURL']),
  //                                         ),
  //                                       ),
  //                                     ),
  //                               Expanded(
  //                                 flex: 2,
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 13.h,
  //                                     top: 3.v,
  //                                   ),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Flexible(
  //                                             child: Text(
  //                                               doctor['fullName'] ?? 'Unknown',
  //                                               overflow: TextOverflow.fade,
  //                                               style: CustomTextStyles
  //                                                   .titleMediumBluegray9000518,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Text(
  //                                         doctor['specialization'] ?? 'Unknown',
  //                                         style: theme.textTheme.bodyMedium,
  //                                       ),
  //                                       Row(
  //                                         children: [
  //                                           CustomImageView(
  //                                             imagePath:
  //                                                 ImageConstant.imgSettings,
  //                                             height: 14.adaptSize,
  //                                             width: 14.adaptSize,
  //                                             color: Colors.grey,
  //                                             margin:
  //                                                 EdgeInsets.only(bottom: 2.v),
  //                                           ),
  //                                           Padding(
  //                                             padding:
  //                                                 EdgeInsets.only(left: 4.h),
  //                                             child: Text(
  //                                               doctor['city'] ?? "Unknow",
  //                                               style:
  //                                                   theme.textTheme.bodySmall,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 5.v),
  //                                       RichText(
  //                                         text: TextSpan(
  //                                           children: [
  //                                             TextSpan(
  //                                               text: "\$",
  //                                               style: CustomTextStyles
  //                                                   .titleMediumff0ebe7f,
  //                                             ),
  //                                             TextSpan(
  //                                               text: " ",
  //                                             ),
  //                                             TextSpan(
  //                                               text: "28.00/hr",
  //                                               style: CustomTextStyles
  //                                                   .bodyLargee5677294,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         textAlign: TextAlign.left,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 14.v),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 4.h),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.only(
  //                                   top: 17.v,
  //                                   bottom: 1.v,
  //                                 ),
  //                                 child: CustomRatingStars(
  //                                   rating: doctor['score'] ?? 0.0,
  //                                   emptyColor: Colors.grey,
  //                                   fillColor: Colors.amber,
  //                                   maxStars: 5,
  //                                 ),
  //                               ),
  //                               _buildBookNow(context, doctor['id']),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //         },
  //       ),
  //     ],
  //   );
  // }

  // section 7..................
  Widget _PSIQUIATRADoctors() {
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> PSIQUIATRADoctors = doctors
        .where((doctor) => doctor['specialization'] == 'PSIQUIATRÍA')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> PSICOLOGaaDoctors = doctors
        .where((doctor) => doctor['specialization'] == 'PSICOLOGÍA')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> LABORALDoctors = doctors
        .where((doctor) => doctor['specialization'] == 'MÉDICO LABORAL')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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
    if (isLoadingSp) {
      // Display a progress indicator while loading
      return Center(
        child: CircularProgressIndicator(), // Use a circular progress indicator
      );
    }
    List<Map<String, dynamic>> LABORALDoctors =
        doctors.where((doctor) => doctor['specialization'] == 'Test').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        'No image available'
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

  // build button
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

  // Widget _buildDashboardOne(BuildContext context) {
  //   return ListView.separated(
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     separatorBuilder: (
  //       context,
  //       index,
  //     ) {
  //       return SizedBox(height: 22.v);
  //     },
  //     itemCount: 8,
  //     itemBuilder: (context, index) {
  //       return DashboardoneItemWidget();
  //     },
  //   );
  // }
}
