import 'dart:io';

import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_ten.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:doctari/widgets/custom_floating_text_field.dart';
import 'package:doctari/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class PatientProfileScreen extends StatefulWidget {
  final int patientId;
  final String patientAccessToken;
  PatientProfileScreen(
      {required this.patientId, required this.patientAccessToken, Key? key})
      : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  String gender = "";
  String profileImage = "";
  bool isLoadingpr = true;

  DropdownItem? country;

  List<DropdownItem> dropdownItems = [];
  List<String> radioList = ["M", "F"];

  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController nYGSGController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoadingButton = false;

  @override
  void initState() {
    super.initState();
    // Fetch patient data when the screen is initialized
    _fetchCountries();
    fetchPatientData();
  }

  Future<void> _fetchCountries() async {
    List<DropdownItem> countries = await PatientApiService.fetchCountries();
    setState(() {
      dropdownItems = countries;
    });
  }

  String? selectedCountry;
  String? selectedCountryValue;
  Future<void> fetchPatientData() async {
    setState(() {
      isLoadingpr = true;
    });
    try {
      // int? patientId = await Provider.of<UserIdProvider>(context).patientId;
      // debugPrint("id of the patient: $patientId");
      // PatientApiService().fetchPatient(patientId!);
      // Fetch patient data using the patientId
      debugPrint("patient id: ${widget.patientId}");
      Patient patient = await PatientApiService()
          .fetchPatient(widget.patientId, widget.patientAccessToken);
      // Update text field controllers with fetched data
      setState(() {
        nameController.text = patient.firstName;
        lastNameController.text = patient.lastName;
        mobileNoController.text = patient.contactNo;
        dateOfBirthController.text = patient.dob;
        emailController.text = patient.email;
        selectedCountry = patient.country.label;
        selectedCountryValue = patient.country.value;

        cityController.text = patient.city;
        nYGSGController.text = patient.documentNo;
        gender = patient.gender;
        profileImage = patient.profileImage;
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

// upload image. .   .... ........
  // File? _image;

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // Future<String?> _uploadImage() async {
  //   if (_image == null) {
  //     print("No image selected for upload");
  //     return null;
  //   }
  //   print("Uploading image to API: $_image");

  //   // Ensure the file path is properly formatted
  //   String filePath = _image!.path;
  //   Uri fileUri = Uri.file(filePath);

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
  //   request.headers['Authorization'] = 'Bearer ${widget.patientAccessToken}';

  //   request.files
  //       .add(await http.MultipartFile.fromPath('file', fileUri.toFilePath()));

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseBody = await http.Response.fromStream(response);
  //     var responseData = json.decode(responseBody.body);
  //     print("Response data of image upload: $responseData");
  //     var imageUrl =
  //         responseData['url']; // Assuming the response contains a 'url' field

  //     print('Image uploaded successfully: $imageUrl');
  //     return imageUrl;
  //   } else {
  //     print('Image upload failed with status: ${response.statusCode}');
  //     print('Response body: ${await response.stream.bytesToString()}');
  //     return null;
  //   }
  // }

  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     // Validate form fields
  //     // Extract updated data from text field controllers
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

  //     // Show a loading indicator
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image..."); // Debug statement
  //       // Upload the image and get the URL
  //       String? imageUrl = await _uploadImage();
  //       print("image url inside the function which is being stored: $imageUrl");

  //       // Construct the update request body
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
  //         if (imageUrl != null)
  //           "profile_picture": {
  //             "url": imageUrl,
  //           }, // Add image URL if available
  //       };

  //       print("Request body: ${json.encode(requestBody)}"); // Debug statement
  //       print("Sending update request..."); // Debug statement
  //       // Send the PATCH request to update the profile
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/patient/${widget.patientId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.patientAccessToken}',
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

  //       // Hide the loading indicator
  //       // Navigator.of(context).pop();
  // Navigator.pushReplacement(context,
  //     MaterialPageRoute(builder: (context) => PatientBottomNavigation()));
  //       if (response.statusCode == 200) {
  //         // Profile update successful
  //         setState(() {
  //           if (imageUrl != null) {
  //             profileImage = imageUrl;
  //           }
  //         });
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
  //             content: Text("Failed to update profile: ${response.body}"),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       // Error updating profile
  //       // Hide the loading indicator
  //       Navigator.of(context).pop();

  //       // Handle the error
  //       print("Error updating profile: $error"); // Debug statement
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Error updating profile: $error"),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
  // }
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
    request.headers['Authorization'] = 'Bearer ${widget.patientAccessToken}';

    request.files
        .add(await http.MultipartFile.fromPath('file', fileUri.toFilePath()));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      var responseData = json.decode(responseBody.body);
      print("Response data of image upload: $responseData");
      //here comment after pull
//<<<<<<< HEAD
      print("Response data of image upload: ${responseBody.body}");
      var imageUrl =
          responseData['url']; // Assuming the response contains a 'url' field
//here comment after pull
//=======
//here comment after pull
      // var imageUrl = responseData['url'];
      //here comment after pull
//>>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
      print('Image uploaded successfully: $imageUrl');
      return {'url': imageUrl, 'filename': fileName};
    } else {
      print('Image upload failed with status: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      return null;
    }
  }

  // void _updateUserProfile(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     // Validate form fields
  //     // Extract updated data from text field controllers
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

  //     // Show a loading indicator
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()),
  //     );

  //     try {
  //       print("Uploading image..."); // Debug statement
  //       // Upload the image and get the URL
  //       String? imageUrl = await _uploadImage();
  //       print("image url inside the function which is being stored: $imageUrl");

  //       // Construct the update request body
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
  //         if (imageUrl != null)
  //           "profile_picture": {"url": imageUrl}, // Add image URL if available
  //       };

  //       print("Request body: ${json.encode(requestBody)}"); // Debug statement
  //       print("Sending update request..."); // Debug statement
  //       // Send the PATCH request to update the profile
  //       String apiUrl =
  //           "https://api-b2c-refactor.doctari.com/patient/${widget.patientId}/";

  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${widget.patientAccessToken}',
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

  //       // Hide the loading indicator
  //       Navigator.of(context).pop();

  //       if (response.statusCode == 200) {
  //         // Profile update successful
  //         setState(() {
  //           if (imageUrl != null) {
  //             profileImage = imageUrl;
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
  //         // Profile update failed
  //         // Handle the error based on the response
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //                 "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}"),
  //             duration: Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       // Error updating profile
  //       // Hide the loading indicator
  //       Navigator.of(context).pop();

  //       // Handle the error
  //       print("Error updating profile: $error"); // Debug statement
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

//updateUserProfile function add here from SAAD file code Here
  void _updateUserProfile(BuildContext context) async {
    setState(() {
      isLoadingButton = true;
      print("True Here");
    });
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
          "country": countrySelection,
          "city": city,
          "identity_document": nYGSG,
          if (imageMap != null)
            "profile_picture": {
              "url": imageMap['url'],
              "filename": imageMap['filename'],
            },
        };

        print("Request body: ${json.encode(requestBody)}");
        print("Sending update request...");
        String apiUrl =
            "https://api-b2c-refactor.doctari.com/patient/${widget.patientId}/";

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.patientAccessToken}',
        };

        var response = await http.patch(
          Uri.parse(apiUrl),
          headers: headers,
          body: json.encode(requestBody),
        );

        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");

        // Navigator.of(context).pop();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientBottomNavigation()));
        if (response.statusCode == 200) {
          setState(() {
            if (imageMap != null) {
              profileImage = imageMap['url']!;
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
              // content: Text("Failed to update profile: ${response.body}"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (error) {
        Navigator.of(context).pop();
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
    setState(() {
      isLoadingButton = false;
      print("False Here");
    });
  }
//////////

//NEW CODE ADD FOR SOLVE ERROR WHEN UPDATE IMAGE
//Coment code due to create conflict after pull and push code
//   void _updateUserProfile(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       //here comment after pull
//       //<<<<<<< HEAD
//       // Validate form fields
//       //here comment after pull
//       //=======
//      //here comment after pull
//      //>>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
//       String firstName = nameController.text.trim();
//       String lastName = lastNameController.text.trim();
//       String mobileNo = mobileNoController.text.trim();
//       String dateOfBirth = dateOfBirthController.text.trim();
//       String email = emailController.text.trim();
//       String selectedGender = gender;
//       dynamic countrySelection =
//           country != null ? country!.value : selectedCountryValue;
//       String city = cityController.text.trim();
//       String nYGSG = nYGSGController.text.trim();

//       debugPrint("Country selection: $countrySelection");

//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(child: CircularProgressIndicator()),
//       );

//       try {
//         //here comment after pull
//       //<<<<<<< HEAD
//         // Upload the image and get the URL
//         String? imageUrl = await _uploadImage();
//         debugPrint("Uploaded image URL: $imageUrl");
//         //here comment after pull
//        //=======
//         print("Uploading image...");
//         var imageMap = await _uploadImage();
//         print("Image map inside the function which is being stored: $imageMap");
//         //here comment after pull
//         >>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668

//         var requestBody = {
//           "first_name": firstName,
//           "last_name": lastName,
//           "date_of_birth": dateOfBirth,
//           "telephone": mobileNo,
//           "gender": selectedGender,
//           "email": email,
//           "country": countrySelection,
//           "city": city,
//           "identity_document": nYGSG,
//           if (imageMap != null)
//             "profile_picture": {
//               "url": imageMap['url'],
//               "filename": imageMap['filename'],
//             },
//         };

//         <<<<<<< HEAD
//         debugPrint("Request body: ${json.encode(requestBody)}");

//         // Send the PATCH request to update the profile
//         =======
//         print("Request body: ${json.encode(requestBody)}");
//         print("Sending update request...");
//         >>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
//         String apiUrl =
//             "https://api-b2c-refactor.doctari.com/patient/${widget.patientId}/";
//         var headers = {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${widget.patientAccessToken}',
//         };

//         var response = await http.patch(
//           Uri.parse(apiUrl),
//           headers: headers,
//           body: json.encode(requestBody),
//         );

//         <<<<<<< HEAD
//         debugPrint("Response status code: ${response.statusCode}");
//         debugPrint("Response body: ${response.body}");
//         =======
//         print("Response status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         >>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668

//         // Navigator.of(context).pop();

//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => PatientBottomNavigation()));
//         if (response.statusCode == 200) {
//           setState(() {
//             if (imageMap != null) {
//               profileImage = imageMap['url']!;
//             }
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   "${AppLocalizations.of(context)!.profileUpdatedPatintProfileSC}"),
//               duration: Duration(seconds: 3),
//             ),
//           );
//         } else {
//         <<<<<<< HEAD
//           // Profile update failed
//           =======
//          >>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   "${AppLocalizations.of(context)!.failedProfileUpdatedPatintProfileSC}: ${response.body}"),
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       } catch (error) {
//        <<<<<<< HEAD
//         // Error updating profile
//         Navigator.of(context).pop();

//         debugPrint("Error updating profile: $error");
// =======
//         Navigator.of(context).pop();
//         print("Error updating profile: $error");
// >>>>>>> 4754751205701f0f8ee33255ca5f7955b7ba1668
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 "${AppLocalizations.of(context)!.errorProfileUpdatedPatintProfileSC}: $error"),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    // fetchPatientData();
    debugPrint("country: $selectedCountry");
    debugPrint("countryvalue: $selectedCountryValue");
    debugPrint("profileImage: $profileImage");

    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leadingWidth: 50,
          backgroundColor: theme.colorScheme.primary,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
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
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: SizedBox(
                  width: mediaQuery.size.width,
                  child: Column(children: [
                    doctorProfileContainer(context),

                    // _buildProfile(context),
                    SizedBox(height: 14.v),
                    Container(
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
                              SizedBox(height: 11.v),
                              _buildCity(context),
                              // SizedBox(height: 11.v),
                              // _buildAddress(context),
                              SizedBox(height: 11.v),
                              _buildNYGSG(context),
                              SizedBox(height: 10.v),
                            ]))
                  ]))),
        ),
        bottomNavigationBar: _buildContinue(context));
  }

  /// Section Widget
  Widget _buildProfile(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 9.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomAppBar(
              height: 30.v,
              leadingWidth: 50.h,
              leading: AppbarLeadingIconbutton(
                  imagePath: ImageConstant.imgArrowLeftBlueGray500,
                  margin: EdgeInsets.only(left: 20.h),
                  onTap: () {
                    onTapArrowLeft(context);
                  }),
              title: AppbarSubtitleTen(
                  text:
                      "${AppLocalizations.of(context)!.profileDocProfileScrenSC}",
                  margin: EdgeInsets.only(left: 19.h))),
          SizedBox(height: 34.v),
          Text("${AppLocalizations.of(context)!.setupProfilePatintProfileSC}",
              style: CustomTextStyles.titleMediumOnErrorContainer_1),
          SizedBox(height: 8.v),
          Container(
              width: 293.h,
              margin: EdgeInsets.only(left: 41.h, right: 39.h),
              child: Text(
                  "${AppLocalizations.of(context)!.profiletoConnectPatintProfileSC}.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumOnErrorContainer
                      .copyWith(height: 1.68))),
          SizedBox(height: 20.v),
          SizedBox(
              height: 130.v,
              width: 138.h,
              child: Stack(alignment: Alignment.bottomRight, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgEllipse164130x130,
                    height: 130.adaptSize,
                    width: 130.adaptSize,
                    radius: BorderRadius.circular(65.h),
                    alignment: Alignment.centerLeft),
                Padding(
                    padding: EdgeInsets.only(bottom: 13.v),
                    child: CustomIconButton(
                        height: 36.adaptSize,
                        width: 36.adaptSize,
                        padding: EdgeInsets.all(8.h),
                        decoration: IconButtonStyleHelper.fillBlueGray,
                        alignment: Alignment.bottomRight,
                        child: CustomImageView(
                            imagePath: ImageConstant.imgCamera)))
              ])),
          SizedBox(height: 20.v)
        ]));
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
        labelText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
        labelStyle: theme.textTheme.bodyLarge!,
        hintText: "${AppLocalizations.of(context)!.emailDoctorRegistrationSC}",
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
                activeColor: Colors.grey.shade300,
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
                activeColor: Colors.grey.shade300,
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

  /// Section Widget

  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField<DropdownItem>(
        decoration: InputDecoration(
          hintText: selectedCountry,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        value: country,
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
        onChanged: (selectedItem) {
          setState(() {
            country = selectedItem;
          });
        },
      ),
    );
  }

  // Widget _buildCountry(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0),
  //     child: DropdownButtonFormField<DropdownItem>(
  //       decoration: InputDecoration(
  //         hintText: selectedCountry,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //             color: Colors.grey.withOpacity(0.6),
  //             width: 1,
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       ),
  //       value: country, // Make sure country is of type DropdownItem
  //       items: dropdownItemList.map((item) {
  //         return DropdownMenuItem<DropdownItem>(
  //           value: item,
  //           child: Text(
  //             item.label,
  //             style: TextStyle(
  //               fontSize: 16,
  //               color: Colors.black,
  //             ),
  //           ),
  //         );
  //       }).toList(),
  //       onChanged: (selectedItem) {
  //         setState(() {
  //           country = selectedItem; // Assign the selected item directly
  //         });
  //       },
  //     ),
  //   );
  // }

  // CustomFloatingTextField(
  //     controller: countryController,
  //     labelText: "Country",
  //     labelStyle: theme.textTheme.bodyLarge!,
  //     hintText: "Country",
  //     suffix: Container(
  //         margin: EdgeInsets.symmetric(horizontal: 20.h),
  //         child: CustomImageView(
  //             imagePath: ImageConstant.imgEdit, height: 14.v, width: 15.h)),
  //     suffixConstraints: BoxConstraints(maxHeight: 60.v));

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
  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
      height: 54.v,
      text: "${AppLocalizations.of(context)!.updateDoctorProfileScrenSC}",
      onPressed: () {
        _updateUserProfile(context);
      },
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
      //     dynamic countrySelection =
      //         country != null ? country!.value : selectedCountryValue;
      //     String city = cityController.text.trim();
      //     String nYGSG = nYGSGController.text.trim();

      //     debugPrint("The selection of the country number: $countrySelection");

      //     // Show a loading indicator
      //     showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (context) => Center(child: CircularProgressIndicator()),
      //     );

      //     try {
      //       print("Uploading image..."); // Debug statement
      //       // Upload the image and get the URL
      //       String? imageUrl = await _uploadImage();

      //       // Construct the update request body
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
      //         if (imageUrl != null)
      //           "profile_picture": imageUrl, // Add image URL if available
      //       };

      //       print("Sending update request..."); // Debug statement
      //       // Send the PATCH request to update the profile
      //       String apiUrl =
      //           "https://api-b2c-refactor.doctari.com/patient/${widget.patientId}/";

      //       var headers = {
      //         'Content-Type': 'application/json',
      //         'Authorization': 'Bearer ${widget.patientAccessToken}',
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

      //       // Hide the loading indicator
      //       Navigator.of(context).pop();

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
      //             content: Text("Failed to update profile: ${response.body}"),
      //             duration: Duration(seconds: 3),
      //           ),
      //         );
      //       }
      //     } catch (error) {
      //       // Error updating profile
      //       // Hide the loading indicator
      //       Navigator.of(context).pop();

      //       // Handle the error
      //       print("Error updating profile: $error"); // Debug statement
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Error updating profile: $error"),
      //           duration: Duration(seconds: 3),
      //         ),
      //       );
      //     }
      //   }
      // },
      margin: EdgeInsets.only(left: 40.h, right: 40.h, bottom: 27.v),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumRubikOnErrorContainer,
    );
  }

  // Widget _buildContinue(
  //   BuildContext context,
  // ) {
  //   return CustomElevatedButton(
  //       height: 54.v,
  //       text: "Update",
  //       onPressed: () async {},
  //       margin: EdgeInsets.only(left: 40.h, right: 40.h, bottom: 27.v),
  //       buttonStyle: CustomButtonStyles.fillPrimary,
  //       buttonTextStyle: CustomTextStyles.titleMediumRubikOnErrorContainer);
  // }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget doctorProfileContainer(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.20,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${AppLocalizations.of(context)!.setupProfileDoctorProfileScrenSC}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          // Text(
          //   "Update your profile to connect with your patients with better impression.",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 16, color: Colors.white),
          // ),
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
                      backgroundImage: _image != null
                          ? FileImage(_image!) // Display the selected image
                          : NetworkImage(
                              profileImage ??
                                  'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                            ) as ImageProvider,
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
              )
            ],
          )
        ],
      ),
    );
  }
}
