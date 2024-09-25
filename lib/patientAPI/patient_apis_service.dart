import 'dart:developer';

import 'package:doctari/Provider/access_token.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientFlow/MainPatientNavigationScreen/PatientMainBottomNavigation.dart';
import 'package:doctari/patientFlow/registration_screens/sign_up_screen_two_for_patient_screen/sign_up_screen_two_for_patient_screen.dart';
import 'package:doctari/presentation/patient_login_screen/patient_login_screen.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/zegoCloud/zego_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientApiService {
  Future<void> registerPatient(
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
  ) async {
    String apiUrl =
        "https://api-b2c-refactor.doctari.com/patient/account/signup/";

    var headers = {
      'Content-Type': 'application/json',
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
    };

    try {
      var response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${AppLocalizations.of(context)!.regSuccesDoctorApiServiceSC}!"),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Handle error responses
        Map<String, dynamic> responseBody = json.decode(response.body);
        String errorMessage = "";
        responseBody.forEach((key, value) {
          if (value is List) {
            errorMessage += "${value.join('. ')} ";
          } else {
            errorMessage += "$value ";
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.errorregPatientPatientApiServceSC}: $error'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Future<void> registerPatient(
  //   BuildContext context,
  //   String email,
  //   String password,
  //   String firstName,
  //   String lastName,
  //   String identityDoc,
  //   String Dob,
  //   String gender,
  //   String telephone,
  //   DropdownItem? country,
  //   String city,
  //   String license,
  // ) async {
  //   String apiUrl =
  //       "https://api-b2c-refactor.doctari.com/patient/account/signup/";

  //   var headers = {
  //     'Content-Type': 'application/json',
  //     // Add any additional headers if required, such as an API key
  //   };

  //   var body = {
  //     "email": email,
  //     "password": password,
  //     "first_name": firstName,
  //     "last_name": lastName,
  //     "identity_document": identityDoc,
  //     "date_of_birth": Dob,
  //     "gender": gender,
  //     "telephone": telephone,
  //     "country": country!.value,
  //     "city": city,
  //     "license_number": license,
  //   };

  //   try {
  //     print("Sending registration request to: $apiUrl");
  //     print("Request body: $body");

  //     var response = await http.post(Uri.parse(apiUrl),
  //         headers: headers, body: json.encode(body));

  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Map<String, dynamic> responseBody = json.decode(response.body);
  //       // int id = responseBody['user']['id'];
  //       // print("User ID: $id");
  //       // Provider.of<UserIdProvider>(context, listen: false).setPatientId(id);
  //       // Registration successful
  //       print("Patient registered successfully!");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               "${AppLocalizations.of(context)!.regSuccesDoctorApiServiceSC}!"),
  //           duration: Duration(seconds: 3), // Adjust duration as needed
  //         ),
  //       );
  //       // Navigate to the home screen
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //       builder: (context) => PatientBottomNavigation(),
  //       //     ));
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //       builder: (context) => PatientLoginScreen(),
  //       //     ));
  //     } else {
  //       // Registration failed
  //       // Parse response body for error messages
  //       Map<String, dynamic> responseBody = json.decode(response.body);
  //       String errorMessage = "";
  //       responseBody.forEach((key, value) {
  //         if (value is List) {
  //           errorMessage += "${value.join('. ')} ";
  //         } else {
  //           errorMessage += "$value ";
  //         }
  //       });
  //       // Show Snackbar message with error message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(errorMessage),
  //           duration: Duration(seconds: 3), // Adjust duration as needed
  //         ),
  //       );
  //     }
  //   } catch (error) {
  //     // Error registering patient
  //     // Show Snackbar message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //             '${AppLocalizations.of(context)!.errorregPatientPatientApiServceSC}: $error'),
  //         duration: Duration(seconds: 3), // Adjust duration as needed
  //       ),
  //     );
  //   }
  // }

  Future<void> PatientLogin(
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
        debugPrint("User type is: $userTypes");
        if (userTypes.contains('patient')) {
          print("User ID: $id");
          print("Access Token: $accessToken");
          print("users types: $userTypes");
          print("users type is: ${userTypes.join(',')}");

          await onUserLogin(id, name);

          Provider.of<ProviderForStoringValues>(context, listen: false)
              .setAccessToken(accessToken);

          Provider.of<ProviderForStoringValues>(context, listen: false)
              .setPatientId(id);

          await SessionManager.saveUserSession(
              id.toString(), userTypes.join(','), accessToken);
          // var box = Hive.box('sessionBox');
          // box.put('userId', id.toString());
          // box.put('userType', userTypes.join(','));

          // Successful login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${AppLocalizations.of(context)!.loggedinSuccPatientApiServceSC}!"),
              duration: Duration(seconds: 3), // Adjust duration as needed
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => PatientBottomNavigation())),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${AppLocalizations.of(context)!.userNotPatientPatientApiServceSC}!'),
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
                '${AppLocalizations.of(context)!.failedLoginPatientApiServceSC}: $errorMessage'),
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
              '${AppLocalizations.of(context)!.failedLoginPatientApiServceSC}: $e'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }
  // Future<void> PatientLogin(
  //   BuildContext context,
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     final String apiUrl = "https://api-b2c-refactor.doctari.com/login/";
  //     final Map<String, String> requestBody = {
  //       'email': email,
  //       'password': password,
  //     };

  //     final Uri uri = Uri.parse(apiUrl);

  //     print('Sending request to: $uri');

  //     final http.Response response = await http.post(
  //       uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseBody = json.decode(response.body);
  //       int id = responseBody['user']['id'];
  //       String name = responseBody['user']['first_name'];

  //       String accessToken = responseBody['access'];

  //       List<String> userTypes =
  //           List<String>.from(responseBody['user']['user_types']);
  //       debugPrint("user type is: $userTypes");
  //       if (userTypes.contains('patient')) {
  //         print("User ID: $id");
  //         print("Access Token: $accessToken");
  //         await onUserLogin(id, name);

  //         Provider.of<ProviderForStoringValues>(context, listen: false)
  //             .setAccessToken(accessToken);

  //         Provider.of<ProviderForStoringValues>(context, listen: false)
  //             .setPatientId(id);

  //              await SessionManager().saveUserSession(id, userTypes);

  //         // Successful login
  //         // Navigate to another screen
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("LoggedIn Successfully!"),
  //             duration: Duration(seconds: 3), // Adjust duration as needed
  //           ),
  //         );
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: ((context) => PatientBottomNavigation())),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('User is not a patient!'),
  //             duration: Duration(seconds: 3), // Adjust duration as needed
  //           ),
  //         );
  //       }
  //     } else {
  //       // Login failed
  //       // Parse response body for error messages
  //       Map<String, dynamic> responseBody = json.decode(response.body);
  //       String errorMessage = responseBody['detail'] ?? response.reasonPhrase;
  //       // Show Snackbar message with error message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to login: $errorMessage'),
  //           duration: Duration(seconds: 3), // Adjust duration as needed
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     // Error occurred during login
  //     // Show Snackbar message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to login: $e'),
  //         duration: Duration(seconds: 3), // Adjust duration as needed
  //       ),
  //     );
  //   }
  // }

  Future<void> patientResetPassword(BuildContext context, String email) async {
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
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text(
        //         '${AppLocalizations.of(context)!.passwordResetDoctorApiServiceSC}',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(color: Colors.black),
        //       ),
        //       content: Text(
        //           '${AppLocalizations.of(context)!.passwordReseEmailtDoctorApiServiceSC} $email',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //             color: Colors.black,
        //           )),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: Text(
        //             '${AppLocalizations.of(context)!.okButtonDoctorApiServiceSC}',
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        // );
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
                ),
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
              '${AppLocalizations.of(context)!.checkInternetPatientApiServceSC}.',
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

  // Future<Patient> fetchPatient(
  //   int patientId,
  //   String patientAccessToken,
  // ) async {
  //   try {
  //     final String apiUrl =
  //         "https://api-b2c-refactor.doctari.com/patient/$patientId/";

  //     final http.Response response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $patientAccessToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> patientData = json.decode(response.body);

  //       Map<String, dynamic> countryData = patientData['country'];
  //       DropdownItem country = DropdownItem(
  //         value: countryData['id'].toString(),
  //         label: countryData['name'].toString(),
  //       );

  //       String? identityDoc = patientData['identity_document'];
  //       String? city = patientData['city'];
  //       String? dob = patientData['date_of_birth'];
  //       String? telephone = patientData['telephone'];
  //       String? email = patientData['email'];
  //       String? gender = patientData['gender'];
  //       String? firstName = patientData['first_name'];
  //       String? lastName = patientData['last_name'];
  //       String? profileImage = patientData['profile_picture']['url'];

  //       return Patient(
  //           id: patientData['id'],
  //           firstName: firstName ?? '',
  //           lastName: lastName ?? '',
  //           documentNo: identityDoc ?? '',
  //           city: city ?? '',
  //           country: country,
  //           countryValue: country,
  //           dob: dob ?? '',
  //           contactNo: telephone ?? '',
  //           email: email ?? '',
  //           gender: gender ?? '',
  //           profileImage: profileImage ?? "");
  //     } else {
  //       throw Exception(
  //           "Failed to fetch patient data. Status code: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Error fetching patient data: $e");
  //   }
  // }

  Future<Patient> fetchPatient(int patientId, String patientAccessToken) async {
    try {
      final String apiUrl =
          "https://api-b2c-refactor.doctari.com/patient/$patientId/";

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $patientAccessToken',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> patientData = json.decode(response.body);

        Map<String, dynamic> countryData = patientData['country'];
        DropdownItem country = DropdownItem(
          value: countryData['id'].toString(),
          label: countryData['name'].toString(),
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

        return Patient(
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
          profileImage: profileImage ?? "",
        );
      } else {
        throw Exception(
            "Failed to fetch patient data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching patient data: $e");
    }
  }

  // Future<List<Map<String, dynamic>>> fetchDoctors() async {
  //   // Define the API endpoint
  //   String apiUrl = "https://api-b2c-refactor.doctari.com/doctor/";

  //   // Define the headers including the Authorization token
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization':
  //         'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE2NjI0NDY5LCJpYXQiOjE3MTYzNjUyNjksImp0aSI6ImJkOWRmNWEzOTM1ODQ3YWI5ZTY1MTkxN2UzNDE5ZjdhIiwidXNlcl9pZCI6MjU4fQ.u4JBoL70unso1KkLW4ryJF3KWkzE9saanYsIyvUNKmY',
  //   };

  //   try {
  //     // Print the request URL
  //     print("Request URL: $apiUrl");

  //     // Send a GET request to the API endpoint with the headers
  //     var response = await http.get(Uri.parse(apiUrl), headers: headers);

  //     // Print the response status code and body
  //     // print("Response status code: ${response.statusCode}");
  //     // print("Response body: ${response.body}");

  //     // Check if the response status code is successful
  //     if (response.statusCode == 200) {
  //       // Parse the response body
  //       var responseBody = json.decode(response.body);
  //       int? doctorsCount = responseBody['count'];
  //       print("total number of doctors are: $doctorsCount");

  //       // Extract and return required fields for each doctor
  //       List<dynamic> doctors = responseBody['results'];
  //       List<Map<String, dynamic>> fetchedData = [];
  //       for (var doctor in doctors) {
  //         fetchedData.add({
  //           'fullName': doctor['full_name'],
  //           'firstName': doctor['first_name'],
  //           'lastName': doctor['last_name'],
  //           'specialization': doctor['specialty']['name'],
  //           'city': doctor['city'],
  //           'score': doctor['score'],
  //           'id': doctor['id'],
  //           'profileImageURL': doctor['profile_picture'] != null
  //               ? doctor['profile_picture']['url']
  //               : 'No image available'
  //         });
  //       }
  //       return fetchedData;
  //     } else {
  //       // Handle other status codes
  //       print("Failed to fetch doctors. Status code: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (error) {
  //     // Handle errors
  //     print("Error fetching doctors: $error");
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    // Define the API endpoint
    String apiUrl = "https://api-b2c-refactor.doctari.com/doctor/";

    // Define the headers including the Authorization token
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE2NjI0NDY5LCJpYXQiOjE3MTYzNjUyNjksImp0aSI6ImJkOWRmNWEzOTM1ODQ3YWI5ZTY1MTkxN2UzNDE5ZjdhIiwidXNlcl9pZCI6MjU4fQ.u4JBoL70unso1KkLW4ryJF3KWkzE9saanYsIyvUNKmY',
    };

    List<Map<String, dynamic>> fetchedData = [];

    try {
      int currentPage = 1;
      bool hasNextPage = true;

      while (hasNextPage) {
        // Add pagination parameters to the URL
        var url = Uri.parse(apiUrl + "?page=$currentPage");

        // Send a GET request to the API endpoint with the headers
        var response = await http.get(url, headers: headers);

        // Check if the response status code is successful
        if (response.statusCode == 200) {
          // Parse the response body
          var responseBody = json.decode(response.body);
          int? doctorsCount = responseBody['count'];
          print("Total number of doctors: $doctorsCount");

          // Extract and return required fields for each doctor
          List<dynamic> doctors = responseBody['results'];
          for (var doctor in doctors) {
            fetchedData.add({
              'fullName': doctor['full_name'],
              'firstName': doctor['first_name'],
              'lastName': doctor['last_name'],
              'specialization': doctor['specialty']['name'],
              'city': doctor['city'],
              'score': doctor['score'],
              'id': doctor['id'],
              'profileImageURL': doctor['profile_picture'] != null
                  ? doctor['profile_picture']['url']
                  : 'No image available'
            });
          }

          // Check if there are more pages to fetch
          if (currentPage < (doctorsCount! / 10).ceil()) {
            currentPage++;
          } else {
            hasNextPage = false;
          }
        } else {
          // Handle other status codes
          print("Failed to fetch doctors. Status code: ${response.statusCode}");
          return [];
        }
      }

      return fetchedData;
    } catch (error) {
      // Handle errors
      print("Error fetching doctors: $error");
      return [];
    }
  }

  // fetched countries
  static Future<List<DropdownItem>> fetchCountries() async {
    String apiUrl = "https://api-b2c-refactor.doctari.com/country/";
    Map<String, String> headers = {
      'Authorization':
          'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE1MjYwNDgzLCJpYXQiOjE3MTUwMDEyODMsImp0aSI6ImQwNGFmMWM2NGMzOTRkZDRhZjI0MzAwNGFjNTg5ZTM5IiwidXNlcl9pZCI6MjU4fQ.CrrgA-rUDXs7YjJVF4APOualogQq_-W_amW0NVqVuig',
      'Content-Type': 'application/json',
      'Authorization': 'Basic Og==',
    };

    try {
      http.Response response =
          await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> countries = json.decode(response.body);
        List<DropdownItem> dropdownItemList = [];
        for (var country in countries) {
          dropdownItemList.add(
            DropdownItem(
              value: country['id'].toString(),
              label: country['name'],
            ),
          );
        }
        return dropdownItemList;
      } else {
        print("Failed to fetch countries. Status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching countries: $error");
      return [];
    }
  }

  // fetch categories
//here add UTF code for decode special character
  static Future<List<DropdownItem>>
      fetchCategoriesForPatientHomeScreen() async {
    String apiUrl = "https://api-b2c-refactor.doctari.com/specility/";
    Map<String, String> headers = {
      'Authorization':
          'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response =
          await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        // Ensure the response is handled as UTF-8
        String responseBody = utf8.decode(response.bodyBytes);

        // Parse the response body
        List<dynamic> categoriesData = json.decode(responseBody);
        print("category response: $responseBody");
        List<DropdownItem> dropdownItemList = [];

        for (var categoryData in categoriesData) {
          dropdownItemList.add(
            DropdownItem(
              value: categoryData['id'].toString(),
              label: categoryData['name'] ??
                  'Unknown', // Handle potential null values
            ),
          );
        }

        // Print the response data for debugging
        print("Categories Data:");
        for (var category in dropdownItemList) {
          print("Category ID: ${category.value}, Name: ${category.label}");
        }

        return dropdownItemList;
      } else {
        print(
            "Failed to fetch categories. Status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching categories: $error");
      return [];
    }
  }

  // static Future<List<DropdownItem>>
  //     fetchCategoriesForPatientHomeScreen() async {
  //   String apiUrl = "https://api-b2c-refactor.doctari.com/specility/";
  //   Map<String, String> headers = {
  //     'Authorization':
  //         'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo',
  //     'Content-Type': 'application/json',
  //   };

  //   try {
  //     //debugger();
  //     http.Response response =
  //         await http.get(Uri.parse(apiUrl), headers: headers);
  //     if (response.statusCode == 200) {
  //       List<dynamic> categoriesData = json.decode(response.body);
  //       List<DropdownItem> dropdownItemList = [];
  //       for (var categoryData in categoriesData) {
  //         dropdownItemList.add(
  //           DropdownItem(
  //             value: categoryData['id'].toString(),
  //             label: categoryData['name'],
  //           ),
  //         );
  //       }
  //       // Print the response data for debugging
  //       print("Categories Data:");
  //       for (var category in dropdownItemList) {
  //         print("Category ID: ${category.value}, Name: ${category.label}");
  //       }
  //       return dropdownItemList;
  //     } else {
  //       print(
  //           "Failed to fetch categories. Status code: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (error) {
  //     print("Error fetching categories: $error");
  //     return [];
  //   }
  // }

// create appointments

  Future<void> createAppointment(
    context,
    String dateTime,
    int doctorId,
    int patientId,
    String appointmentReason,
    List<String> diseases,
    List<String> medications,
    List<String> allergies,
    String token,
  ) async {
    // Define the endpoint URL
    String apiUrl = "https://api-b2c-refactor.doctari.com/appointment/full/";

    // Define the request body
    Map<String, dynamic> requestBody = {
      "date": dateTime,
      "end_date": null,
      "doctor": doctorId,
      "patient": patientId,
      "medical_notes": "",
      "medical_diagnostic": "",
      "medical_treatment": "",
      "patient_appointment_reason": appointmentReason,
      "diseases": diseases,
      "medications": medications,
      "allergies": allergies
    };

    // Define headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer $token', // Add the authentication token to the header
    };

    try {
      // Send POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Check if the request was successful (status code 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Appointment created successfully.");
        print("on success the Response body: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.appointCreatedSuccePatientApiServceSC}.'),
            duration: Duration(seconds: 4), // Adjust duration as needed
          ),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientBottomNavigation()));
      } else {
        print(
            "Failed to create appointment. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error creating appointment: $error");
    }
  }

// fetching doctor profile...
  Future<Doctor> fetchDoctorProfile(
    int doctorId,
  ) async {
    try {
      final String apiUrl =
          "https://api-b2c-refactor.doctari.com/doctor/$doctorId";

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'stJWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6InBhdGllbnRAZG9jdGFyaS5jb20iLCJleHAiOjE2MjkyODk2NzIsImVtYWlsIjoicGF0aWVudEBkb2N0YXJpLmNvbSIsIm9yaWdfaWF0IjoxNjI5MTE2ODcyfQ.WTziiMD_F21SLdfLhswTUy8eYC_gqzI6joIBA6qoGOo',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> doctorData = json.decode(response.body);

        return Doctor(
            id: doctorData['id'] ?? "",
            Firstname: doctorData['first_name'] ?? "unknown",
            Lastname: doctorData['last_name'] ?? "unknown",
            full_name: doctorData['full_name'] ?? "unknown",
            email: doctorData['email'] ?? "unknown",
            license_no: doctorData['license_number'] ?? "unknown",
            city: doctorData['city'] ?? "unknown",
            specialty: doctorData['specialty']['name'] ?? "unknown",
            score: doctorData['score'] ?? 0,
            profile_image: doctorData['profile_picture'] != null
                ? doctorData['profile_picture']['url']
                : 'No image available'

            // Add more fields as needed
            );
      } else {
        throw Exception(
            "Failed to fetch doctor data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching doctor data: $e");
    }
  }

// get patient apointments
  static Future<List<Map<String, dynamic>>> fetchPatientAppointments(
      int patientId, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-b2c-refactor.doctari.com/appointment/full/?patient=$patientId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> results = jsonData['results'];
        return List<Map<String, dynamic>>.from(results);
      } else {
        throw Exception(
            'Failed to load patient appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load patient appointments: $e');
    }
  }

  // fetch completed appointments

  static Future<List<Map<String, dynamic>>> fetchCompletedAppointments(
      int patientId, bool isDone, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-b2c-refactor.doctari.com/appointment/full/?patient=$patientId&is_done=$isDone'),
        headers: {
          'Authorization': 'Bearer $accessToken',
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

// change password.............
  Future<void> changePassword(BuildContext context, String oldPassword,
      String newPassword, String token) async {
    final url =
        Uri.parse('https://api-b2c-refactor.doctari.com/change_password/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'old_password': oldPassword,
      'new_password': newPassword,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '${AppLocalizations.of(context)!.passwordChangePatientApiServceSC}')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '${AppLocalizations.of(context)!.failedPasswordChangePatientApiServceSC}: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.errorOccurredChangePatientApiServceSC}: $e')),
      );
    }
  }
}

class Patient {
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
  final String profileImage;

  // Add more fields as needed

  Patient({
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
    required this.profileImage,
    // Add more fields as needed
  });
}
//   full_name

class Doctor {
  final int id;
  final String Firstname;
  final String Lastname;
  final String full_name;
  final String email;
  final String license_no;
  final String city;
  final String specialty;
  final double score;

  final String profile_image;

  // Add more fields as needed

  Doctor({
    required this.id,
    required this.Firstname,
    required this.Lastname,
    required this.full_name,
    required this.email,
    required this.license_no,
    required this.city,
    required this.specialty,
    required this.score,
    required this.profile_image,
  });
  // Add constructor parameters for additional fields if necessary
}
