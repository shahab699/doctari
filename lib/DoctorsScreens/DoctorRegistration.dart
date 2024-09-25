import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/core/app_export.dart';
import 'package:intl/intl.dart';
import 'DoctorRegistration2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_picker/country_picker.dart';

class DoctorRegistration extends StatefulWidget {
  DoctorRegistration({Key? key})
      : super(
          key: key,
        );

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController birthDateController = TextEditingController();

  String selectedGender = '';
  String selectedSpecilization = '';
  Country? selectedCountry;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch specializations when the widget initializes
    _fetchCountries();
    // Set default country as Afghanistan
    //phoneNumberController.text = '+${selectedCountry.phoneCode} ';
  }

  DoctorSpecializationDropdownItem? specializations;
  List<DoctorSpecializationDropdownItem> dropdownItems = [];
  Future<void> _fetchCountries() async {
    List<DoctorSpecializationDropdownItem> speciality =
        await DoctorApiService().fetchSpeciality();
    setState(() {
      dropdownItems = speciality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: 375.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 23.v,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 21.v),
                    Text(
                      "${AppLocalizations.of(context)!.registerDocDoctorRegistrationSC}",
                      style: CustomTextStyles.headlineSmallff000000,
                    ),
                    SizedBox(height: 45.v),
                    // _buildSpecialityList(context),
                    _buildSpecialityList(
                      context,
                    ),
                    SizedBox(height: 20.v),
                    _buildName(context),
                    SizedBox(height: 20.v),
                    _buildLastName(context),
                    SizedBox(height: 20.v),
                    _buildBirthdate(context),
                    SizedBox(height: 20.v),
                    _buildGender(context),
                    SizedBox(height: 20.v),
                    _buildPhoneNumber(context),
                    SizedBox(height: 20.v),
                    _buildEmail(context),
                    SizedBox(height: 22.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            height: 54.adaptSize,
                            width: 54.adaptSize,
                            padding: EdgeInsets.all(20.h),
                            decoration: IconButtonStyleHelper.outlineBlueGray,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgArrowLeftGray50002,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Validate input fields
                              if (nameController.text.isEmpty ||
                                  birthDateController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  lastNameController.text.isEmpty ||
                                  phoneNumberController.text.isEmpty ||
                                  specializations?.value == null ||
                                  selectedGender.isEmpty) {
                                // Show error message for any empty field
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${AppLocalizations.of(context)!.snackbarfillDoctorRegistrationSC}')),
                                );
                                return; // Exit function if validation fails
                              }

                              // You can add more validation for specific fields if needed

                              // If all validations pass, navigate to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorRegistration2(
                                    dob: birthDateController.text.toString(),
                                    email: emailController.text.toString(),
                                    firstName: nameController.text.toString(),
                                    gender: selectedGender,
                                    lastName:
                                        lastNameController.text.toString(),
                                    phoneNumber:
                                        phoneNumberController.text.toString(),
                                    specilization: specializations!.value,
                                  ),
                                ),
                              );
                            },

                            // onTap: () {
                            //   debugPrint(specializations!.value);
                            //   debugPrint(selectedGender);
                            //   debugPrint(nameController.text.toString());
                            //   debugPrint(birthDateController.text.toString());

                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DoctorRegistration2(
                            //               dob: birthDateController.text
                            //                   .toString(),
                            //               email:
                            //                   emailController.text.toString(),
                            //               firstName:
                            //                   nameController.text.toString(),
                            //               gender: selectedGender,
                            //               lastName: lastNameController.text
                            //                   .toString(),
                            //               phoneNumber: phoneNumberController
                            //                   .text
                            //                   .toString(),
                            //               specilization: specializations!.value,
                            //             )),
                            //   );
                            // },
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.h),
                              child: CustomIconButton(
                                // onTap: (){
                                //   Navigator.pop(context);
                                // },
                                height: 54.adaptSize,
                                width: 54.adaptSize,
                                padding: EdgeInsets.all(20.h),
                                decoration: IconButtonStyleHelper.fillPrimary,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowRight,
                                  color: Colors.white,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.v),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${AppLocalizations.of(context)!.haveAccountDoctorRegistrationSC}? ",
                              style: CustomTextStyles.bodyMediumff000000,
                            ),
                            TextSpan(
                              text:
                                  "${AppLocalizations.of(context)!.logInDoctorRegistrationSC}",
                              style: CustomTextStyles.bodyMediumff004687,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: nameController,
      hintText:
          "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.h,
        vertical: 16.v,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
    );
  }

  /// Section Widget
  Widget _buildLastName(BuildContext context) {
    return CustomTextFormField(
      controller: lastNameController,
      hintText: "${AppLocalizations.of(context)!.lastNameDoctorProfileScrenSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.h,
        vertical: 16.v,
      ),
      borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        birthDateController.text = formattedDate;
      });
    }
  }

  /// Section Widget
  Widget _buildBirthdate(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          controller: birthDateController,
          decoration: InputDecoration(
            suffix: Text("YYYY-MM-DD"),
            labelText:
                "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
            enabled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGender(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Radio(
                value: "M",
                activeColor: Colors.grey.shade300,
                groupValue: selectedGender,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              Text(
                "M",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 20),
              Radio(
                value: "F",
                groupValue: selectedGender,
                activeColor: Colors.grey.shade300,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              Text(
                "F",
                style: TextStyle(color: Colors.grey),
              ),
              // SizedBox(width: 20),
              // Radio(
              //   value: "Custom",
              //   activeColor: Colors.grey.shade300,
              //   fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
              //   groupValue: selectedGender,
              //   onChanged: (String? value) {
              //     setState(() {
              //       selectedGender = value!;
              //     });
              //   },
              // ),
              // Text(
              //   "Custom",
              //   style: TextStyle(color: Colors.grey),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialityList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: DropdownButtonFormField<DoctorSpecializationDropdownItem>(
        isExpanded: true,
        decoration: InputDecoration(
          hintText:
              '${AppLocalizations.of(context)!.selectSpecializationDoctorRegistrationSC}',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          // contentPadding: EdgeInsets.only(
          //   left: 16,
          //   right: 16,
          //   bottom: 12,
          //   top: 12,
          // )
          // contentPadding: EdgeInsets.symmetric(horizontal: 16, ),
        ),
        value: specializations,
        items: dropdownItems.map((item) {
          return DropdownMenuItem<DoctorSpecializationDropdownItem>(
            value: item,
            child: Center(
              // Center the content within the dropdown item
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  //overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center, // Center text horizontally
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            specializations = selectedItem;
          });
        },
        alignment:
            Alignment.center, // Centers the selected item text vertically
      ),
    );
  }

  // Widget _buildSpecialityList(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //     child: DropdownButtonFormField<DoctorSpecializationDropdownItem>(
  //       decoration: InputDecoration(
  //         hintText:
  //             '${AppLocalizations.of(context)!.selectSpecializationDoctorRegistrationSC}',
  //         hintStyle: TextStyle(
  //           fontSize: 15,
  //           color: Colors.grey.shade500,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //             color: Colors.grey.withOpacity(0.6),
  //             width: 1,
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       ),
  //       value: specializations,
  //       items: dropdownItems.map((item) {
  //         return DropdownMenuItem<DoctorSpecializationDropdownItem>(
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
  //           specializations = selectedItem;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildSpecialityList(BuildContext context) {
  //   return Container(
  //     // padding: EdgeInsets.symmetric(
  //     //     horizontal: 10,
  //     //     vertical: 10
  //     // ),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: Colors.grey.shade300, width: 1)),
  //     child: DropdownButtonFormField<String>(
  //       decoration: InputDecoration(
  //         hintText: "Select Specialty",
  //         hintStyle: TextStyle(
  //             fontWeight: FontWeight.w400, color: Colors.grey.shade500),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(8),
  //             borderSide: BorderSide.none),
  //       ),
  //       value: null,
  //       items: [
  //         "Cardiology",
  //         "Dentist",
  //         "Gynecologists",
  //         "Endocrinology",
  //         "Gynecology",
  //         "Neuroanesthesiology",
  //         "Anesthesiology"
  //       ].map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       onChanged: (String? newValue) {
  //         setState(() {
  //           selectedSpecilization = newValue!;
  //         });
  //       },
  //     ),
  //   );
  // }

  /// Section Widget

  // Widget _buildPhoneNumber(BuildContext context) {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextFormField(
  //             controller: phoneNumberController,
  //             decoration: InputDecoration(
  //               hintText: "Phone Number",
  //               hintStyle: TextStyle(
  //                 fontSize: 15,
  //                 color: Colors.grey.shade500,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //               ),
  //               errorBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: BorderSide(color: Colors.red, width: 1),
  //               ),
  //               disabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //               ),
  //               contentPadding:
  //                   EdgeInsets.symmetric(horizontal: 25, vertical: 16),
  //               prefixIcon: GestureDetector(
  //                 onTap: () {
  //                   showCountryPicker(
  //                     context: context,
  //                     onSelect: (country) {
  //                       setState(() {
  //                         selectedCountry = country;
  //                         phoneNumberController.text = '+${country.phoneCode} ';
  //                       });
  //                     },
  //                   );
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: selectedCountry != null
  //                       ? Image.asset(
  //                           'packages/country_icons/icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
  //                           package: 'country_icons',
  //                           width: 32,
  //                           errorBuilder: (context, error, stackTrace) {
  //                             // Fallback icon when the image is not found
  //                             return Icon(Icons.flag);
  //                           },
  //                         )
  //                       : Icon(Icons.flag),
  //                 ),
  //               ),
  //             ),
  //             keyboardType: TextInputType.phone,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
Widget _buildPhoneNumber(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                prefixIcon: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (country) {
                        setState(() {
                          selectedCountry = country;
                          phoneNumberController.text = '+${country.phoneCode} ';
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: selectedCountry != null
                        ? Image.asset(
                            'packages/country_icons/icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
                            package: 'country_icons',
                            width: 32,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback icon when the image is not found
                              return Icon(
                                Icons.flag,
                                //color: Colors.grey,
                              );
                            },
                          )
                        : Icon(
                            Icons.flag,
                            //color: Colors.grey,
                          ),
                  ),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPhoneNumber(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: TextFormField(
  //           controller: phoneNumberController,
  //           decoration: InputDecoration(
  //             hintText: "Phone Number",
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             errorBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(
  //                   color: Colors.red,
  //                   width: 1), // Optional: Customize error border color
  //             ),
  //             disabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 25, vertical: 16),
  //             prefixIcon: GestureDetector(
  //               onTap: () {
  //                 showCountryPicker(
  //                   context: context,
  //                   onSelect: (country) {
  //                     setState(() {
  //                       selectedCountry = country;
  //                       phoneNumberController.text = '+${country.phoneCode} ';
  //                     });
  //                   },
  //                 );
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: selectedCountry != null
  //                     ? Image.asset(
  //                         'icons/flags/png/${selectedCountry!.countryCode.toLowerCase()}.png',
  //                         package: 'country_icons',
  //                         width: 32,
  //                       )
  //                     : Icon(Icons.flag),
  //               ),
  //             ),
  //           ),
  //           keyboardType: TextInputType.phone,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPhoneNumber(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: phoneNumberController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.phoneNumberDoctorRegistrationSC}",
  //     textInputType: TextInputType.phone,
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 25.h,
  //       vertical: 16.v,
  //     ),
  //     borderDecoration: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
  //   );
  // }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
      hintStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
      ),
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 25.h,
        vertical: 16.v,
      ),
      borderDecoration: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
    );
  }
}
