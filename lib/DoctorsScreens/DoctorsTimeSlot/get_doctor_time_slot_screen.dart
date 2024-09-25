import 'dart:convert';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/web%20view/payment_methode.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetShedual extends StatefulWidget {
  const GetShedual({Key? key}) : super(key: key);

  @override
  State<GetShedual> createState() => _GetShedualState();
}

class _GetShedualState extends State<GetShedual> {
  DateTime _currentDates = DateTime.now();
  bool _isWeekView = true;
  List<String> startTimes = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedTime;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();

    _currentDates = _getStartOfWeek(DateTime.now());
    calculateDates();
  }

  Future<void> fetchSchedules(
      int doctorId, String startGt, String startLt, String token) async {
    try {
      final Uri uri = Uri.parse(
          'https://api-b2c-refactor.doctari.com/schedule/?start__gt=${Uri.encodeComponent(startGt)}&start__lt=${Uri.encodeComponent(startLt)}&doctor=$doctorId');

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<String> extractedStartTimes = [];

        final DateFormat inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
        final DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm");

        data.forEach((key, value) {
          if (value is List) {
            for (var entry in value) {
              if (entry is Map && entry.containsKey('start')) {
                String startTime = entry['start'];
                DateTime parsedDateTime = inputFormat.parse(startTime);
                String formattedDateTime = outputFormat.format(parsedDateTime);
                extractedStartTimes.add(formattedDateTime);
              }
            }
          }
        });

        setState(() {
          startTimes = extractedStartTimes;
          isLoading = false;
          print('startTimes $startTimes');
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load schedules. Status Code: ${response.statusCode}';
          isLoading = false;
        });
        print('Failed to load schedules. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void calculateDates() {
    DateTime currentDate = DateTime.now();
    DateTime nextMonthDate = DateTime(
      currentDate.year,
      currentDate.month + 1,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
    );

    String formattedCurrentDate =
        DateFormat('yyyy-MM-dd HH:mm').format(currentDate);
    String formattedNextMonthDate =
        DateFormat('yyyy-MM-dd HH:mm').format(nextMonthDate);

    String startGt = formattedCurrentDate;
    String startLt = formattedNextMonthDate;

    print('Current Date and Time: $formattedCurrentDate');
    print('Next Month Date and Time: $formattedNextMonthDate');

    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();

    if (userId != null) {
      int usersId = int.parse(userId);
      fetchSchedules(usersId, startGt, startLt, userToken!);
    } else {
      setState(() {
        errorMessage = 'User ID is null.';
        isLoading = false;
      });
    }
  }

  DateTime _getStartOfWeek(DateTime date) {
    int weekday = date.weekday;
    return date.subtract(Duration(days: weekday - DateTime.monday));
  }

  String getPeriodLabel() {
    DateTime endDate = _currentDates.add(Duration(days: 6));
    return '${DateFormat('MMM dd, yyyy').format(_currentDates)} - ${DateFormat('MMM dd, yyyy').format(endDate)}';
  }

  void _nextPeriod() {
    setState(() {
      _currentDates = _currentDates.add(Duration(days: 7));
    });
  }

  void _previousPeriod() {
    setState(() {
      _currentDates = _currentDates.subtract(Duration(days: 7));
    });
  }

  bool _isPastTime(DateTime day, String hour) {
    DateTime now = DateTime.now();
    DateTime buttonDateTime = DateFormat('yyyy-MM-dd HH:mm')
        .parse('${DateFormat('yyyy-MM-dd').format(day)} $hour');
    return buttonDateTime.isBefore(now);
  }

  List<DateTime> getWeekDays(DateTime startDate) {
    return List.generate(7, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  List<DateTime> getMonthDays(DateTime startDate) {
    DateTime firstDayOfMonth = DateTime(startDate.year, startDate.month, 1);
    DateTime lastDayOfMonth = DateTime(startDate.year, startDate.month + 1, 0);
    return List.generate(lastDayOfMonth.day, (index) {
      return firstDayOfMonth.add(Duration(days: index));
    });
  }

  List<String> getHours() {
    return List.generate(24, (index) {
      return DateFormat('HH:00').format(DateTime(2021, 1, 1, index));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> days =
        _isWeekView ? getWeekDays(_currentDates) : getMonthDays(_currentDates);
    List<String> hours = getHours();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Doctor Created Time Slot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _previousPeriod,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getPeriodLabel(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _nextPeriod,
                ),
              ],
            ),
          ),
          Expanded(
            // Ensure this takes up the remaining space
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: days.map((day) {
                bool isToday = DateFormat('yyyy-MM-dd').format(day) ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now());

                return Container(
                  width: MediaQuery.of(context).size.width /
                      4, // 1/4th of the screen width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${DateFormat('EEE').format(day)}. ', // Abbreviated day name
                                style: TextStyle(
                                  color: isToday ? Colors.blue : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: DateFormat('dd').format(day), // Date
                                style: TextStyle(
                                  color: isToday ? Colors.blue : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: hours.length,
                          itemBuilder: (context, index) {
                            String formattedActualDateTime =
                                DateFormat('yyyy-MM-dd HH:mm').format(
                              DateTime(
                                day.year,
                                day.month,
                                day.day,
                                int.parse(hours[index].split(':')[0]),
                                0,
                              ),
                            );

                            bool isPastTime = _isPastTime(day, hours[index]);

                            bool isAvailable =
                                startTimes.contains(formattedActualDateTime);
                            bool isDisabled = isPastTime || !isAvailable;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 4),
                              child: ElevatedButton(
                                onPressed: isDisabled
                                    ? null
                                    : () {
                                        setState(() {
                                          _selectedTime =
                                              formattedActualDateTime;
                                        });
                                        print("Selected Time: $_selectedTime");
                                        // Optionally, handle further actions here
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isDisabled ? Colors.grey : Colors.blue,
                                ),
                                child: Text(
                                  '${hours[index]}', // Only show actual time
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}



//first copy of data here 
//import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:intl/intl.dart';

// class GetShedual extends StatefulWidget {
//   const GetShedual({Key? key}) : super(key: key);

//   @override
//   State<GetShedual> createState() => _GetShedualState();
// }

// class _GetShedualState extends State<GetShedual> {
//   List<String> startTimes = [];
//   bool isLoading = true;
//   String? errorMessage;

//   Future<void> fetchSchedules(
//       int doctorId, String startGt, String startLt) async {
//     try {
//       final Uri uri = Uri.parse(
//           'https://api-b2c-refactor.doctari.com/schedule/?start__gt=${Uri.encodeComponent(startGt)}&start__lt=${Uri.encodeComponent(startLt)}&doctor=$doctorId');

//       final response = await http.get(uri, headers: {
//         'Authorization':
//             'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI1NTI5MDcyLCJpYXQiOjE3MjUyNjk4NzIsImp0aSI6IjZhNDgxOTcwN2FmMjQ0MWRhYTFmNzQ1ZWRhYWUwNmJiIiwidXNlcl9pZCI6Mzc5fQ.5sGSw9yw2FhoDd_KcATd4h5ULSQBBUf5BkXPqoL4WRc',
//         'Content-Type': 'application/json',
//       });

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);

//         List<String> extractedStartTimes = [];

//         // Iterate over the parsed JSON data to extract the "start" fields
//         data.forEach((key, value) {
//           if (value is List) {
//             for (var entry in value) {
//               if (entry is Map && entry.containsKey('start')) {
//                 extractedStartTimes.add(entry['start']);
//                 //extractedStartTimes.add(entry['date_start']);
//               }
//             }
//           }
//         });

//         setState(() {
//           startTimes = extractedStartTimes;
//           isLoading = false;
//           print('fetch time $startTimes');
//         });
//       } else {
//         // Log status code and response body for debugging
//         setState(() {
//           errorMessage =
//               'Failed to load schedules. Status Code: ${response.statusCode}';
//           isLoading = false;
//         });
//         print('Failed to load schedules. Status Code: ${response.statusCode}');
//         print('Response Body: ${response.body}');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//       print('Error: $e');
//     }
//   }

//   void calculateDates() {
//     // Get the current date and time
//     DateTime currentDate = DateTime.now();

//     // Calculate the date and time one month from now
//     DateTime nextMonthDate = DateTime(
//       currentDate.year,
//       currentDate.month + 1,
//       currentDate.day,
//       currentDate.hour,
//       currentDate.minute,
//       currentDate.second,
//     );

//     // Format the dates as needed (optional)
//     // String formattedCurrentDate =
//     //     DateFormat('yyyy-MM-ddTHH:mm:ss').format(currentDate);
//     // String formattedNextMonthDate =
//     //     DateFormat('yyyy-MM-ddTHH:mm:ss').format(nextMonthDate);
//     String formattedCurrentDate =
//         DateFormat('yyyy-MM-dd HH:mm').format(currentDate);
//     String formattedNextMonthDate =
//         DateFormat('yyyy-MM-dd HH:mm').format(nextMonthDate);

//     // Store the dates in variables
//     String startGt = formattedCurrentDate;
//     String startLt = formattedNextMonthDate;
// //here print date and time
//     print('Current Date and Time: $formattedCurrentDate');
//     print('Next Month Date and Time: $formattedNextMonthDate');

//     // Call the fetchSchedules function with these parameters
//     String? userId = SessionManager.getUserId();
//     if (userId != null) {
//       int usersId = int.parse(userId); // Convert user id into integer
//       fetchSchedules(usersId, startGt, startLt);
//     } else {
//       setState(() {
//         errorMessage = 'User ID is null.';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     calculateDates();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Schedule"),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : ListView.builder(
//                   itemCount: startTimes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(startTimes[index]),
//                       //subtitle: Text(dateStart[index]),
//                     );
//                   },
//                 ),
//     );
//   }
// }