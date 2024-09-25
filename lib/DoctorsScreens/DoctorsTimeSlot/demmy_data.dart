



// import 'package:flutter/material.dart';
// import 'dart:convert';

// class StartTimeList extends StatefulWidget {
//   @override
//   _StartTimeListState createState() => _StartTimeListState();
// }

// class _StartTimeListState extends State<StartTimeList> {
//   List<String> startTimes = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchStartTimes();
//   }

//   void fetchStartTimes() {
//     String jsonData = '''
//     {
//       "2021-09-10T14:00:00-03:00": [
//         {
//           "id": 57704,
//           "doctor": {
//             "id": 340,
//             "next_available_hour": null,
//             "email": "nofyda@citmo.net",
//             "first_name": "Irfan",
//             "last_name": "Arshad",
//             "license_number": null,
//             "graduation_year": null,
//             "date_of_birth": "1996-04-15",
//             "bio": null,
//             "address": [],
//             "specialty_graduation_year": null,
//             "identity_document": "1234567890",
//             "city": "Okara",
//             "gender": "M",
//             "telephone": "1234567",
//             "country": {
//               "id": 9,
//               "name": "Antigua And Barbuda"
//             },
//             "specialty": {
//               "id": 5,
//               "duration": {
//                 "id": 1,
//                 "minutes": 60,
//                 "name": "Default"
//               },
//               "name": "DERMATOLOGÍA"
//             },
//             "score": null,
//             "full_name": "Irfan Arshad",
//             "profile_picture": {
//               "filename": "profile_pic.jpg",
//               "url": "https://files-doctari.s3.amazonaws.com/dev/users/340/profile_pictures/profile_pic.jpg"
//             },
//             "signature_picture": null,
//             "is_active": true,
//             "slot": 60
//           },
//           "start": "2021-09-10T14:00:00-03:00",
//           "duration": 60,
//           "taken": false,
//           "address": null,
//           "schedule_group": {
//             "date_start": null,
//             "date_finish": null,
//             "date_finish_repeat": null
//           },
//           "types": [1, 2]
//         }
//       ],
//       "2024-07-04T06:00:00-03:00": [
//         {
//           "id": 57835,
//           "doctor": {
//             "id": 340,
//             "next_available_hour": null,
//             "email": "nofyda@citmo.net",
//             "first_name": "Irfan",
//             "last_name": "Arshad",
//             "license_number": null,
//             "graduation_year": null,
//             "date_of_birth": "1996-04-15",
//             "bio": null,
//             "address": [],
//             "specialty_graduation_year": null,
//             "identity_document": "1234567890",
//             "city": "Okara",
//             "gender": "M",
//             "telephone": "1234567",
//             "country": {
//               "id": 9,
//               "name": "Antigua And Barbuda"
//             },
//             "specialty": {
//               "id": 5,
//               "duration": {
//                 "id": 1,
//                 "minutes": 60,
//                 "name": "Default"
//               },
//               "name": "DERMATOLOGÍA"
//             },
//             "score": null,
//             "full_name": "Irfan Arshad",
//             "profile_picture": {
//               "filename": "profile_pic.jpg",
//               "url": "https://files-doctari.s3.amazonaws.com/dev/users/340/profile_pictures/profile_pic.jpg"
//             },
//             "signature_picture": null,
//             "is_active": true,
//             "slot": 60
//           },
//           "start": "2024-07-04T06:00:00-03:00",
//           "duration": 60,
//           "taken": false,
//           "address": null,
//           "schedule_group": {
//             "date_start": null,
//             "date_finish": null,
//             "date_finish_repeat": null
//           },
//           "types": [1, 2]
//         }
//       ],
//       "2024-07-08T05:00:00-03:00": [
//         {
//           "id": 57715,
//           "doctor": {
//             "id": 340,
//             "next_available_hour": null,
//             "email": "nofyda@citmo.net",
//             "first_name": "Irfan",
//             "last_name": "Arshad",
//             "license_number": null,
//             "graduation_year": null,
//             "date_of_birth": "1996-04-15",
//             "bio": null,
//             "address": [],
//             "specialty_graduation_year": null,
//             "identity_document": "1234567890",
//             "city": "Okara",
//             "gender": "M",
//             "telephone": "1234567",
//             "country": {
//               "id": 9,
//               "name": "Antigua And Barbuda"
//             },
//             "specialty": {
//               "id": 5,
//               "duration": {
//                 "id": 1,
//                 "minutes": 60,
//                 "name": "Default"
//               },
//               "name": "DERMATOLOGÍA"
//             },
//             "score": null,
//             "full_name": "Irfan Arshad",
//             "profile_picture": {
//               "filename": "profile_pic.jpg",
//               "url": "https://files-doctari.s3.amazonaws.com/dev/users/340/profile_pictures/profile_pic.jpg"
//             },
//             "signature_picture": null,
//             "is_active": true,
//             "slot": 60
//           },
//           "start": "2024-07-08T05:00:00-03:00",
//           "duration": 60,
//           "taken": false,
//           "address": null,
//           "schedule_group": {
//             "date_start": null,
//             "date_finish": null,
//             "date_finish_repeat": null
//           },
//           "types": [1, 2]
//         }
//       ]
//     }''';

//     Map<String, dynamic> parsedJson = json.decode(jsonData);

//     List<String> extractedStartTimes = [];

//     // Iterate over the parsed JSON data to extract the "start" fields
//     parsedJson.forEach((key, value) {
//       for (var entry in value) {
//         extractedStartTimes.add(entry['start']);
//       }
//     });

//     setState(() {
//       startTimes = extractedStartTimes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Start Times List'),
//       ),
//       body: ListView.builder(
//         itemCount: startTimes.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(startTimes[index]),
//           );
//         },
//       ),
//     );
//   }
// }

//response of data
// "2024-07-11T06:00:00-03:00": [
//         {
//             "id": 57695,
//             "doctor": {
//                 "id": 340,
//                 "next_available_hour": null,
//                 "email": "nofyda@citmo.net",
//                 "first_name": "Irfan",
//                 "last_name": "Arshad",
//                 "license_number": null,
//                 "graduation_year": null,
//                 "date_of_birth": "1996-04-15",
//                 "bio": null,
//                 "address": [],
//                 "specialty_graduation_year": null,
//                 "identity_document": "1234567890",
//                 "city": "Okara",
//                 "gender": "M",
//                 "telephone": "1234567",
//                 "country": {
//                     "id": 9,
//                     "name": "Antigua And Barbuda"
//                 },
//                 "specialty": {
//                     "id": 5,
//                     "duration": {
//                         "id": 1,
//                         "minutes": 60,
//                         "name": "Default"
//                     },
//                     "name": "DERMATOLOGÍA"
//                 },
//                 "score": null,
//                 "full_name": "Irfan Arshad",
//                 "profile_picture": {
//                     "filename": "profile_pic.jpg",
//                     "url": "https://files-doctari.s3.amazonaws.com/dev/users/340/profile_pictures/profile_pic.jpg"
//                 },
//                 "signature_picture": null,
//                 "is_active": true,
//                 "slot": 60
//             },
//             "start": "2024-07-11T06:00:00-03:00",
//             "duration": 60,
//             "taken": false,
//             "address": null,
//             "schedule_group": {
//                 "id": 165,
//                 "days": [
//                     3,
//                     5
//                 ],
//                 "date_start": "2024-07-11T06:00:00-03:00",
//                 "date_finish": "2024-07-11T06:00:00-03:00",
//                 "date_finish_repeat": "2024-07-16T04:31:00-03:00"
//             },
//             "types": [
//                 1,
//                 2,
//                 3
//             ]
//         }
//     ],



// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:doctari/sessionManager/session_manager.dart';

// class GetShedual extends StatefulWidget {
//   const GetShedual({Key? key}) : super(key: key);

//   @override
//   State<GetShedual> createState() => _GetShedualState();
// }

// class _GetShedualState extends State<GetShedual> {
//   List<Map<String, dynamic>> schedulesList = [];

//   Future<void> fetchSchedules(int doctorId) async {
//     try {
//       final Uri uri =
//           Uri.parse('https://api-b2c-refactor.doctari.com/schedule/$doctorId');

//       final response = await http.get(uri, headers: {
//         'Authorization':
//             'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI0MzMxNjU4LCJpYXQiOjE3MjQwNzI0NTgsImp0aSI6Ijk0M2M4OGYyZGNkMTRmODE5NDMyZjBhODI2ZWFiMTJmIiwidXNlcl9pZCI6MTl9.KC6UHMxEASmZsJSBw5BKMfn8f0HcIyRVR659UBUddZE', // Replace with your authentication method
//       });

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data is Map<String, dynamic>) {
//           final List<Map<String, dynamic>> tempSchedules = [];

//           data.forEach((key, value) {
//             if (value is List) {
//               value.forEach((schedule) {
//                 if (schedule is Map<String, dynamic>) {
//                   tempSchedules.add(schedule);
//                 }
//               });
//             }
//           });

//           setState(() {
//             schedulesList = tempSchedules;
//           });
//         } else {
//           print('Unexpected data format');
//         }
//       } else {
//         print('Failed to load schedules. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? userId = SessionManager.getUserId();
//     int usersId = int.parse(userId!); // Convert user id into integer

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Schedule"),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<void>(
//         future: fetchSchedules(usersId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (schedulesList.isEmpty) {
//             return Center(
//               child: Text('No schedules available.'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: schedulesList.length,
//               itemBuilder: (context, index) {
//                 final schedule = schedulesList[index];
//                 final doctor = schedule['doctor'] as Map<String, dynamic>;
//                 final doctorName = doctor['full_name'] ?? 'Unknown Doctor';

//                 return ListTile(
//                   title: Text('Schedule ID: ${schedule['id']}'),
//                   subtitle: Text(
//                     'Start: ${schedule['start']}\n'
//                     'Duration: ${schedule['duration']} minutes\n'
//                     'Doctor: $doctorName',
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
