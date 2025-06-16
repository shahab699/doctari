import 'package:doctari/DoctorsScreens/DoctorBottomNavigationManager/DoctorBottomNavigation.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientFlow/registration_screens/login_screen/login_screen.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/zegoCloud/zego_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorApiService {
  Future<void> registerDoctor(
      BuildContext context,
      String email,
      String password,
      String firstName,
      String lastName,
      String identityDoc,
      String Dob,
      String gender,
      String telephone,
      DropdownItem? country,
      String city,
      String license,
      String specialization) async {
    String apiUrl =
        "https://api-b2c-refactor.doctari.com/doctor/account/signup/";

    var headers = {
      'Content-Type': 'application/json',
      // Add any additional headers if required, such as an API key
    };

    var body = {
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "identity_document": identityDoc,
      "date_of_birth": Dob,
      "gender": gender,
      "telephone": telephone,
      "country": country?.value,
      "city": city,
      "license_number": license,
      'specialty': specialization
    };

    try {
      print("Sending registration request to: $apiUrl");
      print("Request body: $body");

      var response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: json.encode(body));

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map<String, dynamic> responseBody = json.decode(response.body);
        // int id = responseBody['user']['id'];
        // print("doctor ID: $id");
        // Provider.of<UserIdProvider>(context, listen: false).setDoctorId(id);
        // Registration successful
        print("Doctor registered successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${AppLocalizations.of(context)!.regSuccesDoctorApiServiceSC}!"),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
        // Navigate to the home screen
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DoctorBottomNavigation(),
        //     ));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LoginScreen(),
        //     ));
      } else {
        // Registration failed
        // Parse response body for error messages
        Map<String, dynamic> responseBody = json.decode(response.body);
        String errorMessage = "";
        responseBody.forEach((key, value) {
          if (value is List) {
            errorMessage += "${value.join('. ')} ";
          } else {
            errorMessage += "$value ";
          }
        });
        // Show Snackbar message with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      }
    } catch (error) {
      // Error registering patient
      // Show Snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.errorDocRegDoctorApiServiceSC}: $error'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }

  Future<void> DoctorLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final String apiUrl = "https://api-b2c-refactor.doctari.com/login/";
      final Map<String, String> requestBody = {
        'email': email,
        'password': password,
      };

      final Uri uri = Uri.parse(apiUrl);

      print('Sending request to: $uri');

      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        int id = responseBody['user']['id'];
        String name = responseBody['user']['first_name'];

        String accessToken = responseBody['access'];
        List<String> userTypes =
            List<String>.from(responseBody['user']['user_types']);
        debugPrint("user type is: $userTypes");
        if (userTypes.contains('doctor')) {
          await onUserLogin(id, name);
          print("doctor ID: $id");
          print("doctor name: $name");
          Provider.of<ProviderForStoringValues>(context, listen: false)
              .setDoctorId(id);
          Provider.of<ProviderForStoringValues>(context, listen: false)
              .setAccessToken(accessToken);
          // Successful login
          await SessionManager.saveUserSession(
              id.toString(), userTypes.join(','), accessToken);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${AppLocalizations.of(context)!.loginSuccDoctorApiServiceSC}!"),
              duration: Duration(seconds: 3), // Adjust duration as needed
            ),
          );
          // Navigate to another screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: ((context) => DoctorBottomNavigation())),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${AppLocalizations.of(context)!.usernotDocDoctorApiServiceSC}!'),
              duration: Duration(seconds: 3), // Adjust duration as needed
            ),
          );
        }
      } else {
        // Login failed
        // Parse response body for error messages
        Map<String, dynamic> responseBody = json.decode(response.body);
        String errorMessage = responseBody['detail'] ?? response.reasonPhrase;
        // Show Snackbar message with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.failedLoginDoctorApiServiceSC}: $errorMessage'),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      }
    } catch (e) {
      // Error occurred during login
      // Show Snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.failedLoginDoctorApiServiceSC}: $e'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }

  Future<void> doctorResetPassword(BuildContext context, String email) async {
    final String apiUrl =
        "https://api-b2c-refactor.doctari.com/password-reset/";

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Password reset request successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '${AppLocalizations.of(context)!.passwordResetDoctorApiServiceSC}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              content: Text(
                  '${AppLocalizations.of(context)!.passwordReseEmailtDoctorApiServiceSC} $email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context)!.okButtonDoctorApiServiceSC}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      } else if (response.statusCode == 404) {
        // Email not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('${AppLocalizations.of(context)!.errorSC}'),
              content: Text(
                '${AppLocalizations.of(context)!.emailnotFoundDoctorApiServiceSC}.',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context)!.okButtonDoctorApiServiceSC}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Other errors
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '${AppLocalizations.of(context)!.errorSC}',
                style: TextStyle(color: Colors.black),
              ),
              content: Text(
                '${AppLocalizations.of(context)!.enterCorrectEmailDoctorApiServiceSC}.',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context)!.okButtonDoctorApiServiceSC}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Network error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '${AppLocalizations.of(context)!.errorSC}',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              '${AppLocalizations.of(context)!.enterCorrectEmailDoctorApiServiceSC}.',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '${AppLocalizations.of(context)!.okButtonDoctorApiServiceSC}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  String decodeData(String encodedData) {
    return utf8.decode(encodedData.runes.toList());
  }

// fetch specilization:

Future<List<DoctorSpecializationDropdownItem>> fetchSpeciality() async {
  String apiUrl = "https://api-b2c-refactor.doctari.com/specility/";
  Map<String, String> headers = {
    'Authorization':
        'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo',
    'Content-Type': 'application/json',
  };

  try {
    http.Response response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> specializations = json.decode(utf8.decode(response.bodyBytes));
      List<DoctorSpecializationDropdownItem> dropdownItemList = [];
      for (var speciality in specializations) {
        dropdownItemList.add(
          DoctorSpecializationDropdownItem(
            value: speciality['id'].toString(),
            label: speciality['name'],
          ),
        );
        print("name ${speciality['name']}");
      }
      return dropdownItemList;
    } else {
      print("Failed to fetch specialities. Status code: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    print("Error fetching specialities: $error");
    return [];
  }
}

  // Future<List<DoctorSpecializationDropdownItem>> fetchSpeciality() async {
  //   String apiUrl = "https://api-b2c-refactor.doctari.com/specility/";
  //   Map<String, String> headers = {
  //     'Authorization':
  //         'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Basic Og==',
  //   };

  //   try {
  //     http.Response response =
  //         await http.get(Uri.parse(apiUrl), headers: headers);
  //     if (response.statusCode == 200) {
  //       List<dynamic> specializations = json.decode(response.body);
  //       var decodedData = decodeData(response.body);
  //       List<DoctorSpecializationDropdownItem> dropdownItemList = [];
  //       for (var speciality in specializations) {
  //         dropdownItemList.add(
  //           DoctorSpecializationDropdownItem(
  //             value: speciality['id'].toString(),
  //             label: speciality['name'],
  //           ),
  //         );
  //         print("name ${speciality['name']}");
  //         print('Decode Data: ${decodedData}');
  //         print('Response data: ${response.body}');
  //         debugPrint("Decode Data: $decodedData");
  //       }
  //       debugPrint("Decode Data: $decodedData");
  //       return dropdownItemList;
  //     } else {
  //       print("Failed to fetch countries. Status code: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (error) {
  //     print("Error fetching countries: $error");
  //     return [];
  //   }
  // }

// fetch  doctor:

  Future<DoctorProfile> fetchDoctor(int patientId, String doctorToken) async {
    try {
      final String apiUrl =
          "https://api-b2c-refactor.doctari.com/doctor/$patientId/";

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $doctorToken',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> patientData = json.decode(response.body);
        // country data
        Map<String, dynamic> countryData = patientData['country'];
        DropdownItem country = DropdownItem(
          value: countryData['id'].toString(),
          label: countryData['name'].toString(),
        );
        // speciality data
        Map<String, dynamic> specialityData = patientData['specialty'];
        DoctorSpecializationDropdownItem speciality =
            DoctorSpecializationDropdownItem(
          value: specialityData['id'].toString(),
          label: specialityData['name'].toString(),
        );

        String? identityDoc = patientData['identity_document'];
        String? city = patientData['city'];
        String? dob = patientData['date_of_birth'];
        String? telephone = patientData['telephone'];
        String? email = patientData['email'];
        String? gender = patientData['gender'];
        String? firstName = patientData['first_name'];
        String? lastName = patientData['last_name'];
        String? profileImage = patientData['profile_picture']?['url'];

        // int graduation_year = patientData['graduation_year'];
        // int speciality_graduation_year =
        //     patientData['specialty_graduation_year'];
        // int graduation_year =
        //     int.parse(patientData['graduation_year'].toString());
        // int speciality_graduation_year =
        //     int.parse(patientData['specialty_graduation_year'].toString());

        return DoctorProfile(
          id: patientData['id'],
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          documentNo: identityDoc ?? '',
          city: city ?? '',
          country: country,
          countryValue: country,
          dob: dob ?? '',
          contactNo: telephone ?? '',
          email: email ?? '',
          gender: gender ?? '',
          // graduation_year: graduation_year,
          // specialty_graduation_year: speciality_graduation_year,
          speciality: speciality,
          specialityValue: speciality,
          profile_image: profileImage ?? "",
        );
      } else {
        throw Exception(
            "Failed to fetch doctor data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching patient data: $e");
    }
  }

// fetch appointments by doctors
  // static Future<List<Map<String, dynamic>>> fetchDoctorAppointments(
  //     int doctorId, String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$doctorId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = json.decode(response.body);
  //       final List<dynamic> results = jsonData['results'];
  //       return List<Map<String, dynamic>>.from(results);
  //     } else {
  //       throw Exception(
  //           'Failed to load doctor appointments: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load doctor appointments: $e');
  //   }
  // }

  static Future<List<Map<String, dynamic>>> fetchDoctorAppointments(
      int doctorId, String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$doctorId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(
            "newResponse here: ${response.body}"); // Print the raw JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> results = jsonData[
            'results']; // Assuming 'results' is the field storing the appointments
        print("appiontment field: $results"); //check field appiontment
        return List<Map<String, dynamic>>.from(results);
      } else {
        throw Exception(
            'Failed to load doctor appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load doctor appointments: $e');
    }
  }

// get patient count

  Future<int> fetchPatientCount(String token) async {
    // Define the API endpoint URL
    String apiUrl =
        'https://api-b2c-refactor.doctari.com/doctor/patients_treated/';

    try {
      // Make the GET request with the provided authToken in the headers
      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'application/json', // Optional, depending on API requirements
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        List<dynamic> patientsList = jsonDecode(response.body);
        // Get the count of patients
        int patientCount = patientsList.length;
        // Return the patient count
        return patientCount;
      } else {
        // If the request was not successful, throw an error
        throw Exception(
            'Failed to fetch patient count: ${response.statusCode}');
      }
    } catch (error) {
      // Catch any errors that occur during the request
      throw Exception('Failed to fetch patient count: $error');
    }
  }

// fetch completed appointment for doctor
  static Future<List<Map<String, dynamic>>> fetchCompletedAppointmentsForDoc(
      int docId, bool isDone, token) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-b2c-refactor.doctari.com/appointment/full/?doctor=$docId&is_done=$isDone'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> results = jsonData['results'];

        print('Count of appointments: ${jsonData['count']}');
        print('Appointments:');
        results.forEach((appointment) {
          print(appointment);
        });

        return List<Map<String, dynamic>>.from(results);
      } else {
        print('Failed to fetch appointments: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Failed to fetch appointments: $e');
      return [];
    }
  }
}

class DoctorSpecializationDropdownItem {
  final String value;
  final String label;

  DoctorSpecializationDropdownItem({
    required this.value,
    required this.label,
  });
}

// For fetching doctor profile  graduation_year  specialty_graduation_year

class DoctorProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String contactNo;
  final String dob;
  final String email;
  final DropdownItem country;
  final DropdownItem countryValue;
  final String city;
  final String documentNo;
  final String gender;
  final DoctorSpecializationDropdownItem speciality;
  final DoctorSpecializationDropdownItem specialityValue;

  final int? graduation_year;
  final int? specialty_graduation_year;
  final String profile_image;
  // Add more fields as needed

  DoctorProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.contactNo,
    required this.dob,
    required this.email,
    required this.country,
    required this.countryValue,
    required this.city,
    required this.documentNo,
    required this.gender,
    this.graduation_year,
    this.specialty_graduation_year,
    required this.speciality,
    required this.specialityValue,
    required this.profile_image,
    // Add more fields as needed
  });
}
