import 'dart:io';

import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/doctorAPI/doctor_api_service.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_ten.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_floating_text_field.dart';
import 'package:doctari/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../doctor_profile_screen/widgets/dentist8_item_widget.dart';
import '../doctor_profile_screen/widgets/dentist10_item_widget.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class DoctorProfileScreen extends StatefulWidget {
  final int doctorId;
  final String doctorToken;
  DoctorProfileScreen(
      {required this.doctorId, required this.doctorToken, Key? key})
      : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  String gender = "";

  // List<String> radioList = ["lbl_male", "lbl_female", "lbl_others"];
  List<String> radioList = ["M", "F", "O"];

  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  // TextEditingController addressController = TextEditingController();

  TextEditingController nYGSGController = TextEditingController();

  TextEditingController yYYYController = TextEditingController();

  TextEditingController yYYYController1 = TextEditingController();

  TextEditingController selectSpecialtyController = TextEditingController();

  TextEditingController addOtherStudiesController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController priceController1 = TextEditingController();

  TextEditingController attachFileController = TextEditingController();

  String profileImage = "";

  bool isLoadingpr = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch patient data when the screen is initialized
    _fetchCountries();
    _fetchSpecialization();
    fetchDoctorData();
  }

// countries
  List<DropdownItem> dropdownItems = [];
  DropdownItem? country;
  String? selectedCountry;
  String? selectedCountryValue;
// speciality
  List<DoctorSpecializationDropdownItem> dropdownItemsForSpeciality = [];
  DoctorSpecializationDropdownItem? speciality;
  String? selectedSpeciality;
  String? selectedSpecialityValue;

// detch countires
  Future<void> _fetchCountries() async {
    List<DropdownItem> countries = await PatientApiService.fetchCountries();
    setState(() {
      dropdownItems = countries;
    });
  }
// fetch speciality

  Future<void> _fetchSpecialization() async {
    List<DoctorSpecializationDropdownItem> specialization =
        await DoctorApiService().fetchSpeciality();
    setState(() {
      dropdownItemsForSpeciality = specialization;
    });
  }
  // fetch doctor profile

  Future<void> fetchDoctorData() async {
    setState(() {
      isLoadingpr = true;
    });
    try {
      // int? patientId = await Provider.of<UserIdProvider>(context).patientId;
      // debugPrint("id of the patient: $patientId");
      // PatientApiService().fetchPatient(patientId!);
      // Fetch patient data using the patientId
      debugPrint("doctor id: ${widget.doctorId}");
      DoctorProfile doctor = await DoctorApiService()
          .fetchDoctor(widget.doctorId, widget.doctorToken);
      // Update text field controllers with fetched data
      debugPrint("specilization od the doctor: ${doctor.speciality.label}");

      setState(() {
        nameController.text = doctor.firstName;
        lastNameController.text = doctor.lastName;
        mobileNoController.text = doctor.contactNo;
        dateOfBirthController.text = doctor.dob;
        emailController.text = doctor.email;
        selectedCountry = doctor.country.label;
        selectedCountryValue = doctor.country.value;
        selectedSpeciality = doctor.speciality.label;
        selectedSpecialityValue = doctor.speciality.value;

        cityController.text = doctor.city;
        nYGSGController.text = doctor.documentNo;
        gender = doctor.gender;
        yYYYController.text = doctor.graduation_year.toString();
        yYYYController1.text = doctor.specialty_graduation_year.toString();
        profileImage = doctor.profile_image; //add by irfan
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

//add here doctor profile
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Map<String, String>?> _uploadImage() async {
    if (_image == null) {
      print("No image selected for upload");
      return null;
    }
    print("Uploading image to API: $_image");

    String filePath = _image!.path;
    Uri fileUri = Uri.file(filePath);
    String fileName = fileUri.pathSegments.last;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://api-b2c-refactor.doctari.com/user/upload_profile_picture/'),
    );
    request.headers['Accept'] = '*/*';
    request.headers['Accept-Language'] = 'es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3';
    request.headers['Connection'] = 'keep-alive';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Origin'] = 'https://api-b2c-refactor.doctari.com';
    request.headers['Referer'] = 'https://api-b2c-refactor.doctari.com';
    request.headers['User-Agent'] =
        'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0';
    request.headers['Authorization'] = 'Bearer ${widget.doctorToken}';
    // request.headers['Authorization'] =
    //     'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo';

    request.files
        .add(await http.MultipartFile.fromPath('file', fileUri.toFilePath()));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      var responseData = json.decode(responseBody.body);
      print("Response data of image upload: $responseData");

      var imageUrl = responseData['url'];
      print('Image uploaded successfully: $imageUrl');
      return {'url': imageUrl, 'filename': fileName};
    } else {
      print('Image upload failed with status: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      return null;
    }
  }

  void _updateUserProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String firstName = nameController.text.trim();
      String lastName = lastNameController.text.trim();
      String mobileNo = mobileNoController.text.trim();
      String dateOfBirth = dateOfBirthController.text.trim();
      String email = emailController.text.trim();
      String selectedGender = gender;
      dynamic countrySelection =
          country != null ? country!.value : selectedCountryValue;
      String city = cityController.text.trim();
      String nYGSG = nYGSGController.text.trim();

      debugPrint("The selection of the country number: $countrySelection");

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      try {
        print("Uploading image...");
        var imageMap = await _uploadImage();
        print("Image map inside the function which is being stored: $imageMap");

        var requestBody = {
          "first_name": firstName,
          "last_name": lastName,
          "date_of_birth": dateOfBirth,
          "telephone": mobileNo,
          "gender": selectedGender,
          "email": email,
          "country": countrySelection != null
              ? int.tryParse(countrySelection.toString())
              : 1, // Default to 1 if null
          "city": city,
          "identity_document": nYGSG,
          if (imageMap != null)
            "profile_image": {
              "filename": imageMap['filename'],
              "url": imageMap['url'],

            },
        };

        print("Request body: ${json.encode(requestBody)}");
        print("Doctor Token: ${widget.doctorToken}");
        print("Doctor Id: ${widget.doctorId}");
        print("Sending update request...");
        String apiUrl =
            "https://api-b2c-refactor.doctari.com/doctor/${widget.doctorId}/";

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.doctorToken}',
        };

        var response = await http.patch(
          Uri.parse(apiUrl),
          headers: headers,
          body: json.encode(requestBody),
        );

        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");

        Navigator.of(context).pop(); // Close the loading dialog

        if (response.statusCode == 200) {
          setState(() {
            if (imageMap != null) {
              // Append a unique query parameter to the URL to bust the cache
              profileImage =
                  '${imageMap['url']}?v=${DateTime.now().millisecondsSinceEpoch}';
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}"),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (error) {
        Navigator.of(context).pop(); // Close the loading dialog
        print("Error updating profile: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Future<Map<String, String>?> _uploadImage() async {
  //   if (_image == null) {
  //     print("No image selected for upload");
  //     return null;
  //   }
  //   print("Uploading image to API: $_image");

  //   String filePath = _image!.path;
  //   Uri fileUri = Uri.file(filePath);
  //   String fileName = fileUri.pathSegments.last;

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'https://api-b2c-refactor.doctari.com/user/upload_profile_picture/'),
  //   );
  //   request.headers['Accept'] = '*/*';
  //   request.headers['Accept-Language'] = 'es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3';
  //   request.headers['Connection'] = 'keep-alive';
  //   request.headers['Content-Type'] = 'multipart/form-data';
  //   request.headers['Origin'] = 'https://api-b2c-refactor.doctari.com';
  //   request.headers['Referer'] = 'https://api-b2c-refactor.doctari.com';
  //   request.headers['User-Agent'] =
  //       'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0';
  //   request.headers['Authorization'] = 'Bearer ${widget.doctorToken}';

  //   request.files
  //       .add(await http.MultipartFile.fromPath('file', fileUri.toFilePath()));

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseBody = await http.Response.fromStream(response);
  //     var responseData = json.decode(responseBody.body);
  //     print("Response data of image upload: $responseData");

  //     print("Response data of image upload: ${responseBody.body}");
  //     var imageUrl = responseData['url'];
  //     print('Image uploaded successfully: $imageUrl');
  //     return {'url': imageUrl, 'filename': fileName};
  //   } else {
  //     print('Image upload failed with status: ${response.statusCode}');
  //     print('Response body: ${await response.stream.bytesToString()}');
  //     return null;
  //   }
  // }

  // Future<Map<String, String>?> _uploadImage() async {
  //   if (_image == null) {
  //     print("No image selected for upload");
  //     return null;
  //   }
  //   print("Uploading image to API: $_image");

  //   String filePath = _image!.path;
  //   Uri fileUri = Uri.file(filePath);
  //   String fileName = fileUri.pathSegments.last;

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'https://api-b2c-refactor.doctari.com/user/upload_profile_picture/'),
  //   );
  //   request.headers['Authorization'] = 'Bearer ${widget.doctorToken}';

  //   request.files
  //       .add(await http.MultipartFile.fromPath('file', fileUri.toFilePath()));

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseBody = await http.Response.fromStream(response);
  //     var responseData = json.decode(responseBody.body);
  //     print("Response data of image upload: $responseData");

  //     var imageUrl = responseData['url'];
  //     print('Image uploaded successfully: $imageUrl');
  //     return {'url': imageUrl, 'filename': fileName};
  //   } else {
  //     print('Image upload failed with status: ${response.statusCode}');
  //     print('Response body: ${await response.stream.bytesToString()}');
  //     return null;
  //   }
  // }

  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     String firstName = nameController.text.trim();
  //     String lastName = lastNameController.text.trim();
  //     String mobileNo = mobileNoController.text.trim();
  //     String dateOfBirth = dateOfBirthController.text.trim();
  //     String email = emailController.text.trim();
  //     String selectedGender = gender;
  //     dynamic countrySelection =
  //         country != null ? country!.value : selectedCountryValue;
  //     String city = cityController.text.trim();
  //     String nYGSG = nYGSGController.text.trim();

  //     debugPrint("The selection of the country number: $countrySelection");

  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image...");
  //       var imageMap = await _uploadImage();
  //       print("Image map inside the function which is being stored: $imageMap");

  //       var requestBody = {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "date_of_birth": dateOfBirth,
  //         "telephone": mobileNo,
  //         "gender": selectedGender,
  //         "email": email,
  //         "country": int.tryParse(
  //             countrySelection.toString()), // Ensure country is an integer
  //         "city": city,
  //         "identity_document": nYGSG,
  //         if (imageMap != null)
  //           "profile_picture": {
  //             "url": imageMap['url'],
  //             "filename": imageMap['filename'],
  //           },
  //       };

  //       print("Request body: ${json.encode(requestBody)}");
  //       print("Doctor Token: ${widget.doctorToken}");
  //       print("Doctor Id: ${widget.doctorId}");
  //       print("Sending update request...");
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/doctor/${widget.doctorId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.doctorToken}',
  //       };

  //       var response = await http.patch(
  //         Uri.parse(apiUrl),
  //         headers: headers,
  //         body: json.encode(requestBody),
  //       );

  //       print("Response status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");

  //       Navigator.of(context).pop(); // Close the loading dialog

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           if (imageMap != null) {
  //             profileImage = imageMap['url']! +
  //                 "?v=${DateTime.now().millisecondsSinceEpoch}"; // Update profileImage state with unique query parameter
  //             print("Updated profile image URL: $profileImage");
  //           }
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       Navigator.of(context).pop(); // Close the loading dialog
  //       print("Error updating profile: $error");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error",
  //           ),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
  // }

  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     String firstName = nameController.text.trim();
  //     String lastName = lastNameController.text.trim();
  //     String mobileNo = mobileNoController.text.trim();
  //     String dateOfBirth = dateOfBirthController.text.trim();
  //     String email = emailController.text.trim();
  //     String selectedGender = gender;
  //     dynamic countrySelection =
  //         country != null ? country!.value : selectedCountryValue;
  //     String city = cityController.text.trim();
  //     String nYGSG = nYGSGController.text.trim();

  //     debugPrint("The selection of the country number: $countrySelection");

  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image...");
  //       var imageMap = await _uploadImage();
  //       print("Image map inside the function which is being stored: $imageMap");

  //       var requestBody = {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "date_of_birth": dateOfBirth,
  //         "telephone": mobileNo,
  //         "gender": selectedGender,
  //         "email": email,
  //         "country": int.tryParse(
  //             countrySelection.toString()), // Ensure country is an integer
  //         "city": city,
  //         "identity_document": nYGSG,
  //         if (imageMap != null)
  //           "profile_picture": {
  //             "url": imageMap['url'],
  //             "filename": imageMap['filename'],
  //           },
  //       };

  //       print("Request body: ${json.encode(requestBody)}");
  //       print("Doctor Token: ${widget.doctorToken}");
  //       print("Doctor Id: ${widget.doctorId}");
  //       print("Sending update request...");
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/doctor/${widget.doctorId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.doctorToken}',
  //       };

  //       var response = await http.patch(
  //         Uri.parse(apiUrl),
  //         headers: headers,
  //         body: json.encode(requestBody),
  //       );

  //       print("Response status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");

  //       Navigator.of(context).pop(); // Close the loading dialog

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           if (imageMap != null) {
  //             profileImage = imageMap['url']!; // Update profileImage state
  //           }
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       Navigator.of(context).pop(); // Close the loading dialog
  //       print("Error updating profile: $error");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error",
  //           ),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
  // }

//Code where show API error
  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     String firstName = nameController.text.trim();
  //     String lastName = lastNameController.text.trim();
  //     String mobileNo = mobileNoController.text.trim();
  //     String dateOfBirth = dateOfBirthController.text.trim();
  //     String email = emailController.text.trim();
  //     String selectedGender = gender;
  //     dynamic countrySelection =
  //         country != null ? country!.value : selectedCountryValue;
  //     String city = cityController.text.trim();
  //     String nYGSG = nYGSGController.text.trim();

  //     debugPrint("The selection of the country number: $countrySelection");

  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image...");
  //       var imageMap = await _uploadImage();
  //       print("Image map inside the function which is being stored: $imageMap");

  //       var requestBody = {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "date_of_birth": dateOfBirth,
  //         "telephone": mobileNo,
  //         "gender": selectedGender,
  //         "email": email,
  //         "country": int.tryParse(
  //             countrySelection.toString()), // Ensure country is an integer
  //         "city": city,
  //         "identity_document": nYGSG,
  //         if (imageMap != null)
  //           "profile_picture": {
  //             "url": imageMap['url'],
  //             "filename": imageMap['filename'],
  //           },
  //       };

  //       print("Request body: ${json.encode(requestBody)}");
  //       print("Doctor Token: ${widget.doctorToken}");
  //       print("Doctor Id: ${widget.doctorId}");
  //       print("Sending update request...");
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/doctor/${widget.doctorId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.doctorToken}',
  //       };

  //       var response = await http.patch(
  //         Uri.parse(apiUrl),
  //         headers: headers,
  //         body: json.encode(requestBody),
  //       );

  //       print("Response status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");

  //       Navigator.of(context).pop(); // Close the loading dialog

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           if (imageMap != null) {
  //             profileImage = imageMap['url']!;
  //           }
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}",
  //             ),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       Navigator.of(context).pop(); // Close the loading dialog
  //       print("Error updating profile: $error");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error",
  //           ),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
  // }

//last code
  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     String firstName = nameController.text.trim();
  //     String lastName = lastNameController.text.trim();
  //     String mobileNo = mobileNoController.text.trim();
  //     String dateOfBirth = dateOfBirthController.text.trim();
  //     String email = emailController.text.trim();
  //     String selectedGender = gender;
  //     dynamic countrySelection =
  //         country != null ? country!.value : selectedCountryValue;
  //     String city = cityController.text.trim();
  //     String nYGSG = nYGSGController.text.trim();

  //     debugPrint("The selection of the country number: $countrySelection");

  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image...");
  //       var imageMap = await _uploadImage();
  //       print("Image map inside the function which is being stored: $imageMap");

  //       var requestBody = {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "date_of_birth": dateOfBirth,
  //         "telephone": mobileNo,
  //         "gender": selectedGender,
  //         "email": email,
  //         "country": countrySelection,
  //         "city": city,
  //         "identity_document": nYGSG,
  //         if (imageMap != null)
  //           "profile_picture": {
  //             "url": imageMap['url'],
  //             "filename": imageMap['filename'],
  //           },
  //       };

  //       print("Request body: ${json.encode(requestBody)}");
  //       print("Sending update request...");
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/patient/${widget.doctorId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.doctorToken}',
  //       };

  //       var response = await http.patch(
  //         Uri.parse(apiUrl),
  //         headers: headers,
  //         body: json.encode(requestBody),
  //       );

  //       print("Response status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");

  //       // Navigator.of(context).pop();
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => DoctorBottomNavigation()));
  //       if (response.statusCode == 200) {
  //         setState(() {
  //           if (imageMap != null) {
  //             profileImage = imageMap['url']!;
  //           }
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //                 "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}"),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //                 "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}"),
  //             // content: Text("Failed to update profile: ${response.body}"),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       Navigator.of(context).pop();
  //       print("Error updating profile: $error");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error"),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 50,
          backgroundColor: theme.colorScheme.primary,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:
                // isLoadingpr
                //     ? Center(
                //         child: CircularProgressIndicator(
                //           color: Colors.white,
                //         ),
                //       )
                //     :
                Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
              height: 30.v,
              width: 30.v,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.grey.shade500,
              )),
            ),
          ),
          title: Text(
            "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        body: Form(
            key: _formKey,
            child: SizedBox(
                width: mediaQuery.size.width,
                child: Column(children: [
                  doctorProfileContainer(context),

                  // _buildProfile(context),
                  SizedBox(height: 14.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 5.v),
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.personalInformationDocProfileScrenSC}",
                                        style: CustomTextStyles
                                            .titleMediumBluegray90005),
                                    SizedBox(height: 8.v),
                                    _buildName(context),
                                    SizedBox(height: 11.v),
                                    _buildLastName(context),
                                    SizedBox(height: 11.v),
                                    _buildMobileNo(context),
                                    SizedBox(height: 11.v),
                                    _buildDateOfBirth(context),
                                    SizedBox(height: 11.v),
                                    _buildEmail(context),
                                    SizedBox(height: 11.v),
                                    _buildGenderOptions(context),
                                    SizedBox(height: 11.v),
                                    _buildCountry(context),
                                    SizedBox(height: 13.v),
                                    _buildCity(context),
                                    // SizedBox(height: 11.v),
                                    // _buildAddress(context),
                                    SizedBox(height: 11.v),
                                    _buildNYGSG(context),
                                    SizedBox(height: 19.v),
                                    // Text("Work Academic Information ",
                                    //     style: CustomTextStyles
                                    //         .titleMediumBluegray90005),
                                    // SizedBox(height: 8.v),
                                    // _buildYYYY(context),
                                    // SizedBox(height: 11.v),
                                    // _buildYYYY1(context),
                                    SizedBox(height: 11.v),
                                    _buildSelectSpecialty(context),
                                    // SizedBox(height: 11.v),
                                    // _buildDentist(context),
                                    // SizedBox(height: 11.v),
                                    // _buildAddOtherStudies(context),
                                    // SizedBox(height: 11.v),
                                    // _buildDentist1(context),
                                    // SizedBox(height: 20.v),
                                    // Text("Pricing",
                                    //     style: CustomTextStyles
                                    //         .titleMediumBluegray90005),
                                    // SizedBox(height: 7.v),
                                    // _buildPrice(context),
                                    // SizedBox(height: 10.v),
                                    // _buildPrice1(context),
                                    // SizedBox(height: 20.v),
                                    // Text("Signature",
                                    //     style: CustomTextStyles
                                    //         .titleMediumBluegray90005),
                                    // SizedBox(height: 7.v),
                                    // _buildAttachFile(context)
                                  ]))))
                ]))),
        bottomNavigationBar: _buildContinue(context)
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomFloatingTextField(
        controller: nameController,
        labelText:
            "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC}",
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildLastName(BuildContext context) {
    return CustomFloatingTextField(
        controller: lastNameController,
        labelText:
            "${AppLocalizations.of(context)!.lastNameDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.lastNameDoctorProfileScrenSC}",
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildMobileNo(BuildContext context) {
    return CustomFloatingTextField(
        controller: mobileNoController,
        labelText:
            "${AppLocalizations.of(context)!.contactNumberDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.contactNumberDoctorProfileScrenSC}",
        textInputType: TextInputType.number,
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildDateOfBirth(BuildContext context) {
    return CustomFloatingTextField(
        controller: dateOfBirthController,
        labelText:
            "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
        labelStyle: CustomTextStyles.bodyLargeRubik,
        hintText:
            "${AppLocalizations.of(context)!.dateofBirthDoctorProfileScrenSC}",
        hintStyle: CustomTextStyles.bodyLargeRubik,
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v),
        contentPadding: EdgeInsets.fromLTRB(20.h, 27.v, 20.h, 13.v));
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomFloatingTextField(
        controller: emailController,
        labelText: "Email",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildGenderOptions(BuildContext context) {
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
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Row(
            children: [
              Radio(
                value: "M",
                activeColor: Colors.blue,
                groupValue: gender,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    gender = value!;
                    debugPrint(gender);
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
                groupValue: gender,
                activeColor: Colors.blue,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    gender = value!;
                    debugPrint(gender);
                  });
                },
              ),
              Text(
                "F",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 20),
              Radio(
                value: "O",
                groupValue: gender,
                activeColor: Colors.blue,
                fillColor: MaterialStatePropertyAll(Colors.grey.shade300),
                onChanged: (String? value) {
                  setState(() {
                    gender = value!;
                    debugPrint(gender);
                  });
                },
              ),
              Text(
                "O",
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
    // Container(
    //     padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 7.v),
    //     decoration: AppDecoration.fillOnErrorContainer1
    //         .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
    //     child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text("Gender", style: theme.textTheme.labelMedium),
    //           SizedBox(height: 11.v),
    //           Padding(
    //             padding: EdgeInsets.only(right: 10.h),
    //             child: Row(
    //               children: [
    //                 Padding(
    //                     padding: EdgeInsets.only(top: 1.v),
    //                     child: CustomRadioButton(
    //                         text: "Male",
    //                         value: radioList[0].isEmpty ? gender : null,
    //                         groupValue: gender,
    //                         onChange: (value) {
    //                           gender = value;
    //                         })),
    //                 Padding(
    //                     padding: EdgeInsets.only(left: 27.h, bottom: 1.v),
    //                     child: CustomRadioButton(
    //                         text: "Female",
    //                         value: radioList[1].isEmpty ? gender : null,
    //                         groupValue: gender,
    //                         onChange: (value) {
    //                           gender = value;
    //                         })),
    //                 // Padding(
    //                 //     padding: EdgeInsets.only(left: 27.h, bottom: 1.v),
    //                 //     child: CustomRadioButton(
    //                 //         text: "Others",
    //                 //         value: radioList[2],
    //                 //         groupValue: gender,
    //                 //         onChange: (value) {
    //                 //           gender = value;
    //                 //         }))
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 3.v)
    //         ],
    //         ),
    //         );
  }
  // Widget _buildGenderOptions(BuildContext context) {
  //   return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 7.v),
  //       decoration: AppDecoration.fillOnErrorContainer1
  //           .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
  //       child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text("Gender", style: theme.textTheme.labelMedium),
  //             SizedBox(height: 11.v),
  //             Padding(
  //                 padding: EdgeInsets.only(right: 10.h),
  //                 child: Row(children: [
  //                   Padding(
  //                       padding: EdgeInsets.only(top: 1.v),
  //                       child: CustomRadioButton(
  //                           text: "Male",
  //                           value: radioList[0],
  //                           groupValue: gender,
  //                           onChange: (value) {
  //                             gender = value;
  //                           })),
  //                   Padding(
  //                       padding: EdgeInsets.only(left: 27.h, bottom: 1.v),
  //                       child: CustomRadioButton(
  //                           text: "Female",
  //                           value: radioList[1],
  //                           groupValue: gender,
  //                           onChange: (value) {
  //                             gender = value;
  //                           })),
  //                   Padding(
  //                       padding: EdgeInsets.only(left: 27.h, bottom: 1.v),
  //                       child: CustomRadioButton(
  //                           text: "Others",
  //                           value: radioList[2],
  //                           groupValue: gender,
  //                           onChange: (value) {
  //                             gender = value;
  //                           }))
  //                 ])),
  //             SizedBox(height: 3.v)
  //           ]));
  // }

  /// Section Widget
  ///
  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField<DropdownItem>(
        isExpanded: true,
        decoration: InputDecoration(
          hintText: selectedCountry,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          //contentPadding: EdgeInsets.only(left: 16, right: 16),
        ),
        value: country,
        items: dropdownItems.map((item) {
          return DropdownMenuItem<DropdownItem>(
            value: item,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            country = selectedItem;
          });
        },
      ),
    );
  }
  // Widget _buildCountry(BuildContext context) {
  //   return CustomFloatingTextField(
  //       controller: countryController,
  //       labelText: "Country",
  //       labelStyle: theme.textTheme.bodyLarge!,
  //       hintText: "Country",
  //       suffix: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 20.h),
  //           child: CustomImageView(
  //               imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
  //       suffixConstraints: BoxConstraints(maxHeight: 60.v));
  // }

  /// Section Widget
  Widget _buildCity(BuildContext context) {
    return CustomFloatingTextField(
        controller: cityController,
        labelText: "${AppLocalizations.of(context)!.cityDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText: "${AppLocalizations.of(context)!.cityDoctorProfileScrenSC}",
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  // Widget _buildAddress(BuildContext context) {
  //   return CustomFloatingTextField(
  //       controller: addressController,
  //       labelText: "Address",
  //       labelStyle: CustomTextStyles.bodyMediumBluegray500Light,
  //       hintText: "Address",
  //       hintStyle: CustomTextStyles.bodyMediumBluegray500Light);
  // }

  /// Section Widget
  Widget _buildNYGSG(BuildContext context) {
    return CustomFloatingTextField(
        controller: nYGSGController,
        labelText:
            "${AppLocalizations.of(context)!.documentNumberDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.documentNumberDoctorProfileScrenSC}",
        textInputType: TextInputType.number,
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildYYYY(BuildContext context) {
    return CustomFloatingTextField(
        controller: yYYYController,
        labelText:
            "${AppLocalizations.of(context)!.yearReceivedDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.yearReceivedDoctorProfileScrenSC}");
  }

  /// Section Widget
  Widget _buildYYYY1(BuildContext context) {
    return CustomFloatingTextField(
        controller: yYYYController1,
        labelText:
            "${AppLocalizations.of(context)!.yearCompletionDoctorProfileScrenSC} ",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.yearCompletionDoctorProfileScrenSC} ");
  }

  /// Section Widget
  // Widget _buildSelectSpecialty(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0),
  //     child: DropdownButtonFormField<DoctorSpecializationDropdownItem>(
  //       decoration: InputDecoration(
  //         hintText: selectedSpeciality,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //             color: Colors.grey.withOpacity(0.6),
  //             width: 1,
  //           ),
  //         ),
  //         isDense: true, // Reduces the vertical height of the input
  //         contentPadding: EdgeInsets.symmetric(
  //             vertical: 12, horizontal: 16), // Adjust vertical padding
  //       ),
  //       value: speciality,
  //       items: dropdownItemsForSpeciality.map((item) {
  //         return DropdownMenuItem<DoctorSpecializationDropdownItem>(
  //           value: item,
  //           child: Center(
  //             child: Text(
  //               item.label,
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 color: Colors.black,
  //               ),
  //               overflow: TextOverflow.ellipsis,
  //               textAlign: TextAlign.center, // Center text horizontally
  //             ),
  //           ),
  //         );
  //       }).toList(),
  //       onChanged: (selectedItem) {
  //         setState(() {
  //           speciality = selectedItem;
  //         });
  //       },
  //       alignment: Alignment.center, // Ensures text is centered in the dropdown
  //     ),
  //   );
  // }

  Widget _buildSelectSpecialty(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField<DoctorSpecializationDropdownItem>(
        //isExpanded: true,
        alignment: AlignmentDirectional.center,
        decoration: InputDecoration(
          hintText: selectedSpeciality,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: -20, bottom: 12),
        ),
        value: speciality,
        items: dropdownItemsForSpeciality.map((item) {
          return DropdownMenuItem<DoctorSpecializationDropdownItem>(
            value: item,
            child: Center(
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            speciality = selectedItem;
          });
        },
      ),
    );
  }

  // Widget _buildSelectSpecialty(BuildContext context) {
  //   return CustomFloatingTextField(
  //       controller: selectSpecialtyController,
  //       labelText: "Speciality",
  //       labelStyle: theme.textTheme.bodyLarge!,
  //       hintText: "Speciality",
  //       suffix: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 20.h),
  //           child: CustomImageView(
  //               imagePath: ImageConstant.imgArrowdown,
  //               height: 8.v,
  //               width: 15.h)),
  //       suffixConstraints: BoxConstraints(maxHeight: 60.v));
  // }

  /// Section Widget
  Widget _buildDentist(BuildContext context) {
    return Wrap(
        runSpacing: 10.v,
        spacing: 10.h,
        children: List<Widget>.generate(3, (index) => Dentist8ItemWidget()));
  }

  /// Section Widget
  Widget _buildAddOtherStudies(BuildContext context) {
    return CustomFloatingTextField(
        controller: addOtherStudiesController,
        labelText:
            "${AppLocalizations.of(context)!.otherStudiesDoctorProfileScrenSC}",
        labelStyle: CustomTextStyles.bodyLargeRubik,
        hintText:
            "${AppLocalizations.of(context)!.otherStudiesDoctorProfileScrenSC}",
        hintStyle: CustomTextStyles.bodyLargeRubik,
        contentPadding: EdgeInsets.fromLTRB(20.h, 27.v, 20.h, 13.v));
  }

  /// Section Widget
  Widget _buildDentist1(BuildContext context) {
    return Wrap(
        runSpacing: 10.v,
        spacing: 10.h,
        children: List<Widget>.generate(2, (index) => Dentist10ItemWidget()));
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return CustomFloatingTextField(
        controller: priceController,
        labelText:
            "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.personVisitCompletedAppionmentWidgetSC}");
  }

  /// Section Widget
  Widget _buildPrice1(BuildContext context) {
    return CustomFloatingTextField(
        controller: priceController1,
        labelText:
            "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.onlineConsultationAppiontmentDetailDocSecSC}");
  }

  /// Section Widget
  Widget _buildAttachFile(BuildContext context) {
    return CustomFloatingTextField(
        controller: attachFileController,
        labelText:
            "${AppLocalizations.of(context)!.signatureDoctorProfileScrenSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText:
            "${AppLocalizations.of(context)!.signatureDoctorProfileScrenSC}",
        textInputAction: TextInputAction.done,
        suffix: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgClock,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        suffixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
        height: 54.v,
        text: "${AppLocalizations.of(context)!.updateDoctorProfileScrenSC}",
        onPressed: () {
          _updateUserProfile(context); //this use for upload doctor profile
        },
        //this comment add by irfan
        // onPressed: () async {
        //   if (_formKey.currentState!.validate()) {
        //     // Validate form fields
        //     // Extract updated data from text field controllers
        //     String firstName = nameController.text.trim();
        //     String lastName = lastNameController.text.trim();
        //     String mobileNo = mobileNoController.text.trim();
        //     String dateOfBirth = dateOfBirthController.text.trim();
        //     String email = emailController.text.trim();
        //     String selectedGender = gender;
        //     // int graduation_year = int.parse(yYYYController.text.trim());
        //     // int specialization_graduation_year =
        //     //     int.parse(yYYYController1.text.trim());

        //     dynamic countrySelection =
        //         country != null ? country!.value : selectedCountryValue;
        //     dynamic specializationSelection = speciality != null
        //         ? speciality!.value
        //         : selectedSpecialityValue;

        //     String city = cityController.text.trim();
        //     String nYGSG = nYGSGController.text.trim();

        //     debugPrint(
        //         "the selection of the country number: $countrySelection");
        //     debugPrint(
        //         "the selection of the specilization number: $specializationSelection");

        //     // Construct the update request body
        //     var requestBody = {
        //       "first_name": firstName,
        //       "last_name": lastName,
        //       "date_of_birth": dateOfBirth,
        //       "telephone": mobileNo,
        //       "gender": selectedGender,
        //       "email": email,
        //       "country": countrySelection,
        //       "city": city,
        //       "identity_document": nYGSG,
        //       // 'graduation_year': graduation_year,
        //       // 'specialty_graduation_year': specialization_graduation_year,
        //       'specialty': specializationSelection,
        //     };

        //     try {
        //       print("Sending update request..."); // Debug statement
        //       // Send the PATCH request to update the profile
        //       String apiUrl =
        //           "https://api-b2c-refactor.doctari.com/doctor/${widget.doctorId}/";

        //       var headers = {
        //         'Content-Type': 'application/json',
        //         'Authorization': 'Bearer ${widget.doctorToken}',
        //         // Add any additional headers if required
        //       };

        //       var response = await http.patch(
        //         Uri.parse(apiUrl),
        //         headers: headers,
        //         body: json.encode(requestBody),
        //       );

        //       print(
        //           "Response status code: ${response.statusCode}"); // Debug statement
        //       print("Response body: ${response.body}"); // Debug statement

        //       if (response.statusCode == 200) {
        //         // Profile update successful
        //         // Optionally, you can fetch updated patient data here
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             content: Text("Profile updated successfully"),
        //             duration: Duration(seconds: 3),
        //           ),
        //         );
        //       } else {
        //         // Profile update failed
        //         // Handle the error based on the response
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             content: Text("Failed to update profile"),
        //             duration: Duration(seconds: 3),
        //           ),
        //         );
        //       }
        //     } catch (error) {
        //       // Error updating profile
        //       // Handle the error
        //       print("Error updating profile: $error"); // Debug statement
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text(
        //               "${AppLocalizations.of(context)!.errorUpdateprofileDoctorProfileScrenSC}: $error"),
        //           duration: Duration(seconds: 3),
        //         ),
        //       );
        //     }
        //   }
        // },
        margin: EdgeInsets.only(left: 40.h, right: 40.h, bottom: 27.v),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleMediumRubikOnErrorContainer);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget doctorProfileContainer(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    // Provide a default value if profileImage is null
    String profileImageUrl = profileImage ??
        'https://as1.ftcdn.net/v2/jpg/01/72/18/66/1000_F_172186647_e93OQdc8KSoBzIPqfKG0UoJSJhR15HLa.jpg';

    return Container(
      height: mediaQuery.size.height * 0.28,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${AppLocalizations.of(context)!.setupProfileDoctorProfileScrenSC}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            "${AppLocalizations.of(context)!.updateYourProfileDoctorProfileScrenSC}.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Stack(
            children: [
              isLoadingpr
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    radius: 18,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//   Widget doctorProfileContainer(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context);

//     return Container(
//       height: mediaQuery.size.height * 0.28,
//       width: mediaQuery.size.width,
//       decoration: BoxDecoration(
//         color: theme.colorScheme.primary,
//         borderRadius: BorderRadius.only(
//           bottomRight: Radius.circular(25),
//           bottomLeft: Radius.circular(25),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "${AppLocalizations.of(context)!.setupProfileDoctorProfileScrenSC}",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//           Text(
//             "${AppLocalizations.of(context)!.updateYourProfileDoctorProfileScrenSC}.",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//           Stack(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.black,
//                 radius: 50,
//                 backgroundImage: NetworkImage(profileImage!),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey.withOpacity(0.6),
//                     radius: 18,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//code widget that added by irfan
//   Widget doctorProfileContainer(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context);

//     return Container(
//       height: mediaQuery.size.height * 0.28,
//       width: mediaQuery.size.width,
//       decoration: BoxDecoration(
//           color: theme.colorScheme.primary,
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25))),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "${AppLocalizations.of(context)!.setupProfileDoctorProfileScrenSC}",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
//           ),
//           Text(
//             "${AppLocalizations.of(context)!.updateYourProfileDoctorProfileScrenSC}.",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//           Stack(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.black,
//                 radius: 50,
//                 backgroundImage: NetworkImage(
//                     "https://as1.ftcdn.net/v2/jpg/01/72/18/66/1000_F_172186647_e93OQdc8KSoBzIPqfKG0UoJSJhR15HLa.jpg"),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: GestureDetector(
//                   // onTap: () {},
//                   onTap: _pickImage, //add by irfan
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey.withOpacity(0.6),
//                     radius: 18,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
