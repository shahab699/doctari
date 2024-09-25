//New update start here
import 'dart:convert';
import 'package:doctari/local_storage_services/local_storage_methods.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:intl/intl.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DoctorTimeSlot extends StatefulWidget {
  final String token;
  DoctorTimeSlot({required this.token, Key? key}) : super(key: key);

  @override
  _DoctorTimeSlotState createState() => _DoctorTimeSlotState();
}

class _DoctorTimeSlotState extends State<DoctorTimeSlot>
    with WidgetsBindingObserver {
  DateTime _currentDate = DateTime(2024, 7, 8); // Starting date
  DateTime _currentDates = DateTime.now();
  bool _isWeekView = true;
  List disabledButtons = [];
  bool isButtontDisabled = false;
  List<String>? storedTimeSlots;
  Set<String> clickedButtons = {};
  //List<DateTime> buttonValues = ;
  //List<String> disabledButtons =
  // LocalStorageMethods.instance.getSelectedTimeSlotsList() ?? [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _loadDisabledButtons();
    _currentDates = _getStartOfWeek(DateTime.now());
    print("When load data: $disabledButtons");
    WidgetsBinding.instance.addPostFrameCallback((x) async {
      selectedTime =
          await LocalStorageMethods.instance.getSelectedTimeSlotsList();
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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

  Future<void> _saveDisabledButtons() async {
    var box = Hive.box('settingsBox');
    await box.put('disabledButtons', disabledButtons.toList());
    setState(() {}); // Trigger a rebuild
    print("When saving data: $disabledButtons");
  }

  Future<void> _loadDisabledButtons() async {
    var box = Hive.box('settingsBox');
    List<String>? disabledButtonsList =
        box.get('disabledButtons')?.cast<String>();
    if (disabledButtonsList != null) {
      setState(() {
        disabledButtons = disabledButtonsList.toSet().toList();
      });
    }
    print("When loading data: $disabledButtons");
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

  //HERE START API FUNCTION..........................
  Future<void> _createAvailability(BuildContext context, String start,
      List<int> types, int doctor, String token) async {
    await createSingleAvailability(context, start, types, doctor, token);
  }

  Future<void> _createMultipleAvailabilities(
      BuildContext context,
      String start,
      String finish,
      String finishRepeat,
      List<int> types,
      bool repeat,
      int doctor,
      List<int> weekDays,
      String token) async {
    await createMultipleAvailabilities(context, start, finish, finishRepeat,
        types, repeat, doctor, weekDays, token);
  }

  Future<void> createSingleAvailability(BuildContext context, String start,
      List<int> types, int doctor, String token) async {
    final url = Uri.parse('https://api-b2c-refactor.doctari.com/schedule/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'start': start,
      'types': types,
      'doctor': doctor,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      print('Availability created successfully');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Single availability created successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      _showSuccessDialogsingle(
          context, 'Single availability created successfully');
    } else {
      print('Failed to create availability');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create availability',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      _showFailureDialogsingle(context, 'Failed to create single availability');
    }
  }

  Future<void> createMultipleAvailabilities(
      BuildContext context,
      String start,
      String finish,
      String finishRepeat,
      List<int> types,
      bool repeat,
      int doctor,
      List<int> weekDays,
      String token) async {
    final url = Uri.parse(
        'https://api-b2c-refactor.doctari.com/schedule/create_multiple_schedules/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'date_start': start,
      'date_finish': finish,
      'date_finish_repeat': finishRepeat,
      'types': types,
      'repeat': repeat,
      'doctor': doctor,
      'days': weekDays,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      print('Multiple availabilities created successfully');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Multiple availabilities created successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      _showSuccessDialog(
          context, 'Multiple availabilities created successfully');
    } else {
      print('Failed to create multiple availabilities');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create multiple availabilities Date start should be bigger than today',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      _showFailureDialog(context, 'Failed to create multiple availabilities');
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Multiple availabilities created successfully',
            style: TextStyle(color: Colors.black),
          ),
          // content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // Navigator.of(context).pop(); // Close the success dialog
                Navigator.of(context, rootNavigator: true)
                    .pop(); // Close the original dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Doctor Schedual Create',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialogsingle(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Single availabilty created successfully',
            style: TextStyle(color: Colors.black),
          ),
          // content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
                Navigator.of(context, rootNavigator: true)
                    .pop(); // Close the original dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showFailureDialogsingle(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Single Availability',
            style: TextStyle(color: Colors.black),
          ),
          // content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
//HERE END API FUNCTION

//first popup start here

  _showPopup(
      BuildContext context, DateTime day, String time, String delayedTime) {
    bool isConsultationWeb = false;
    bool isInPersonConsultation = false;
    bool isInterconsultation = false;

    Map<String, bool> weekDays = {
      'Mon': false,
      'Tue': false,
      'Wed': false,
      'Thu': false,
      'Fri': false,
      'Sat': false,
      'Sun': false,
    };

    String selectedDay = DateFormat('EEE').format(day);
    weekDays[selectedDay] = true;

    List<int> selectedOptions = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isAnyCheckboxSelected() {
              return isConsultationWeb ||
                  isInPersonConsultation ||
                  isInterconsultation;
            }

            void updateSelectedOptions(bool? value, int option) {
              if (value == true) {
                if (!selectedOptions.contains(option)) {
                  selectedOptions.add(option);
                }
              } else {
                selectedOptions.remove(option);
              }
            }

            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.all(20),
              title: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Mark hours as available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Schedule consultation for ${DateFormat('yyyy-MM-dd').format(day)} $time and $delayedTime',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Query type:',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors
                                .blue; // Color when checkbox is selected
                          }
                          return Colors
                              .white; // Color when checkbox is not selected
                        }),
                        checkColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Color of the check mark
                      ),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text("Consultation via web"),
                          value: isConsultationWeb,
                          onChanged: (bool? value) {
                            setState(() {
                              isConsultationWeb = value ?? false;
                              updateSelectedOptions(value, 1);
                            });
                          },
                        ),
                        // CheckboxListTile(
                        //   title: Text("In-person consultation"),
                        //   value: isInPersonConsultation,
                        //   onChanged: (bool? value) {
                        //     setState(() {
                        //       isInPersonConsultation = value ?? false;
                        //       updateSelectedOptions(value, 2);
                        //     });
                        //   },
                        // ),
                        CheckboxListTile(
                          title: Text("Interconsultation"),
                          value: isInterconsultation,
                          onChanged: (bool? value) {
                            setState(() {
                              isInterconsultation = value ?? false;
                              updateSelectedOptions(value, 2);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: isAnyCheckboxSelected()
                        ? () {
                            Navigator.of(context).pop();
                            _showSecondPopup(
                              context,
                              day,
                              time,
                              delayedTime,
                              selectedOptions,
                              weekDays,
                            );
                          }
                        : null,
                    child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                        color:
                            isAnyCheckboxSelected() ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSecondPopup(
    BuildContext context,
    DateTime day,
    String time,
    String delayedTime,
    List<int> selectedOptions,
    Map<String, bool> initialWeekDays,
  ) {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;
    String? _formattedSelectedDay;
    int _selectedOption = 0;
    bool isRepeatSelected = false;
    Map<String, bool> weekDays = Map.from(initialWeekDays);

    List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    List<String> getNext7Days(String selectedDay) {
      int startIndex = allDays.indexOf(selectedDay);
      List<String> next7Days = [];
      for (int i = 0; i < 7; i++) {
        next7Days.add(allDays[(startIndex + i) % 7]);
      }
      return next7Days;
    }

    List<int> selectedDaysIndices = [];
    String currentSelectedTime =
        '${DateFormat('yyyy-MM-dd').format(day)} $time';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.all(20),
              title: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Confirm Appointment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Scheduled time: $currentSelectedTime',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'End time $delayedTime',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Selected options: ${selectedOptions.join(', ')}',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    RadioListTile<int>(
                      title: Text('Available only this day'),
                      value: 1,
                      groupValue: _selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption = value ?? 1;
                          isRepeatSelected = _selectedOption == 2;
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: Text('Repeat'),
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption = value ?? 2;
                          isRepeatSelected = _selectedOption == 2;
                        });
                      },
                    ),
                    if (_selectedOption == 2) ...[
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select days:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            FutureBuilder<List<String>>(
                              future: LocalStorageMethods.instance
                                  .getSelectedTimeSlotsList(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Error loading time slots');
                                }

                                List<String> storedTimeSlots =
                                    snapshot.data ?? [];

                                return Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  children: getNext7Days(
                                    weekDays.keys.firstWhere(
                                      (day) => weekDays[day]!,
                                      orElse: () => 'Mon',
                                    ),
                                  ).map((String day) {
                                    int dayIndex = allDays.indexOf(day) + 1;
                                    bool isDisabled =
                                        storedTimeSlots.contains('$day-$time');
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          checkboxTheme: CheckboxThemeData(
                                            fillColor: MaterialStateProperty
                                                .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return Colors.blue;
                                                }
                                                return Colors.white;
                                              },
                                            ),
                                            checkColor: MaterialStateProperty
                                                .all<Color>(Colors.white),
                                          ),
                                        ),
                                        child: CheckboxListTile(
                                          title: Text(day),
                                          value: weekDays[day],
                                          onChanged: isDisabled
                                              ? null
                                              : (bool? value) {
                                                  setState(() {
                                                    weekDays[day] =
                                                        value ?? false;
                                                    if (value == true) {
                                                      if (!selectedDaysIndices
                                                          .contains(dayIndex)) {
                                                        selectedDaysIndices
                                                            .add(dayIndex);
                                                      }
                                                    } else {
                                                      selectedDaysIndices
                                                          .remove(dayIndex);
                                                    }
                                                  });
                                                },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                            Column(
                              children: [
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: _focusedDay,
                                  calendarFormat: _calendarFormat,
                                  availableCalendarFormats: const {
                                    CalendarFormat.month: 'Month',
                                    CalendarFormat.week: 'Week',
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(_selectedDay, day);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    if (!isSameDay(_selectedDay, selectedDay)) {
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                        _formattedSelectedDay =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(selectedDay);
                                      });
                                    }
                                  },
                                  onFormatChanged: (format) {
                                    if (_calendarFormat != format) {
                                      setState(() {
                                        _calendarFormat = format;
                                      });
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    _focusedDay = focusedDay;
                                  },
                                ),
                                if (_formattedSelectedDay != null)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Selected Date: $_formattedSelectedDay'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {
                      print('Accept button pressed');
                      String? userId = SessionManager.getUserId();
                      String? userToken = SessionManager.getUserToken();

                      // Ensure userId and userToken are not null
                      if (userId == null || userToken == null) {
                        // Handle null case (e.g., show an error message)
                        print("User ID or token is null");
                        return;
                      }

                      int userIdInt = int.parse(userId);

                      try {
                        String formattedStart = DateFormat(
                                "yyyy-MM-ddTHH:mm:ss")
                            .format(DateTime.parse(
                                "${DateFormat('yyyy-MM-dd').format(day)} $time"));

                        if (_selectedOption == 1) {
                          await _createAvailability(
                            context,
                            formattedStart,
                            selectedOptions,
                            userIdInt,
                            userToken,
                          );
                        } else if (_selectedOption == 2) {
                          await _createMultipleAvailabilities(
                            context,
                            formattedStart,
                            delayedTime,
                            _formattedSelectedDay!,
                            selectedOptions,
                            isRepeatSelected,
                            userIdInt,
                            selectedDaysIndices,
                            userToken,
                          );
                        }
                        
                        setState(() {
                          disabledButtons.add(currentSelectedTime);
                          // isButtontDisabled = true;
                          isButtontDisabled =
                              storedTimeSlots!.contains(storedTimeSlots);
                        });
                        await _saveDisabledButtons();
                        Navigator.of(context).pop();
                        // Ensure the dialog closes after all operations
                        //print('About to close dialog');
                        Navigator.of(context).pop();
                        //print('Dialog closed');
                      } catch (e) {
                        // Handle any errors
                        print("Error: $e");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Accept',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<String> selectedTime = [];

  @override
  Widget build(BuildContext context) {
    //print("when build methode: $disabledButtons");
    List<DateTime> days =
        _isWeekView ? getWeekDays(_currentDates) : getMonthDays(_currentDates);
    List<String> hours = getHours();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: theme.primaryColor,
        title: Text(
          'Doctor Time Slot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           _isWeekView = true;
              //         });
              //       },
              //       child: Container(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text(
              //           'Week',
              //           style: TextStyle(
              //             color: _isWeekView ? Colors.black : Colors.grey,
              //             fontSize: 18,
              //             fontWeight:
              //                 _isWeekView ? FontWeight.bold : FontWeight.normal,
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 16),
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           _isWeekView = false;
              //         });
              //       },
              //       child: Container(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text(
              //           'Month',
              //           style: TextStyle(
              //             color: !_isWeekView ? Colors.black : Colors.grey,
              //             fontSize: 18,
              //             fontWeight: !_isWeekView
              //                 ? FontWeight.bold
              //                 : FontWeight.normal,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              Row(
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
              Expanded(
                  child: _isWeekView
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: days.map((day) {
                              bool isToday =
                                  DateFormat('yyyy-MM-dd').format(day) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now());

                              return Container(
                                width: MediaQuery.of(context).size.width /
                                    4, // 1/4th of the screen width
                                child: Column(
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
                                                color: isToday
                                                    ? Colors.blue
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: DateFormat('dd')
                                                  .format(day), // Date
                                              style: TextStyle(
                                                color: isToday
                                                    ? Colors.blue
                                                    : Colors.black,
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
                                          DateTime actualDateTime =
                                              DateFormat('HH:00')
                                                  .parse(hours[index]);
                                          DateTime delayedDateTime =
                                              actualDateTime
                                                  .add(Duration(hours: 1));
                                          String delayedTime =
                                              DateFormat('HH:00')
                                                  .format(delayedDateTime);

                                          DateTime combinedDelayedDateTime =
                                              DateTime(
                                            day.year,
                                            day.month,
                                            day.day,
                                            delayedDateTime.hour,
                                            delayedDateTime.minute,
                                          );

                                          String formattedDelayedDateTime =
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(
                                                      combinedDelayedDateTime);
                                          String buttonKey =
                                              '$day-${hours[index]}';

                                          bool isPastTime =
                                              _isPastTime(day, hours[index]);
                                          //bool isInDisabledList = disabledButtons
                                          //.contains('$day-${hours[index]}');
                                          bool isDisabled = isPastTime ||
                                              isButtontDisabled ||
                                              selectedTime.contains(
                                                  "$day ${hours[index]}");

                                          return
                                              // InkWell(
                                              //   onTap: () async {
                                              //     if (selectedTime.contains(
                                              //         hours[index].toString())) {
                                              //       print("already selected");
                                              //     } else {
                                              //       LocalStorageMethods.instance
                                              //           .writeSelectedTimeSlot(
                                              //               hours[index]
                                              //                   .toString());
                                              //       selectedTime =
                                              //           await LocalStorageMethods
                                              //               .instance
                                              //               .getSelectedTimeSlotsList();
                                              //       setState(() {});
                                              //     }
                                              //   },
                                              //   child: Container(
                                              //     height: 30,
                                              //     width: 30,
                                              //     margin: EdgeInsets.all(4),
                                              //     color: selectedTime.contains(
                                              //             hours[index].toString())
                                              //         ? Colors.red
                                              //         : Colors.green,
                                              //     child:
                                              //         Text(hours[index].toString()),
                                              //   ),
                                              // );

                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 4),
                                            child: ElevatedButton(
                                              onPressed: isDisabled
                                                  ? null
                                                  : () async {
                                                      print(
                                                          "$day:${hours[index]}:$formattedDelayedDateTime");
                                                      await _showPopup(
                                                          context,
                                                          day,
                                                          hours[index],
                                                          formattedDelayedDateTime);

                                                      // Update the clickedButtons set to change the color
                                                      setState(() {
                                                        clickedButtons
                                                            .add(buttonKey);
                                                      });

                                                      //Optionally, update disabledButtons list and save it
                                                      if (!disabledButtons
                                                          .contains(
                                                              buttonKey)) {
                                                        setState(() {
                                                          disabledButtons
                                                              .add(buttonKey);
                                                        });
                                                        await _saveDisabledButtons();
                                                      }
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                backgroundColor: clickedButtons
                                                        .contains(buttonKey)
                                                    ? Colors
                                                        .blue // Change to blue if clicked
                                                    : (isDisabled
                                                        ? Color(0xffd4d6fd
                                                            //0xffFFFF00
                                                            ) // Grey background if disabled
                                                        : Color(0xffeff1f2
                                                            //0xffFFFF00
                                                            )), // Transparent if enabled
                                                foregroundColor: Colors
                                                    .black, // Text color remains the same
                                                shadowColor: Colors
                                                    .transparent, // Remove shadow
                                                elevation:
                                                    0, // Remove elevation
                                              ),
                                              child: ElevatedButton(
                                                onPressed: isDisabled
                                                    ? null
                                                    : () async {
                                                        print(
                                                            "$day:${hours[index]}:$formattedDelayedDateTime");
                                                        await _showPopup(
                                                            context,
                                                            day,
                                                            hours[index],
                                                            formattedDelayedDateTime);

                                                        // Update the disabledButtons list and save it
                                                        // String buttonKey =
                                                        //     '$day-${hours[index]}';
                                                        // if (!disabledButtons
                                                        //     .contains(buttonKey)) {
                                                        //   setState(() {
                                                        //     disabledButtons
                                                        //         .add(buttonKey);
                                                        //   });
                                                        //   await _saveDisabledButtons();
                                                        // }
                                                      },
                                                child: Text(
                                                  hours[index],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                                  backgroundColor: isDisabled
                                                      ? Color(0xffd4d6fd
                                                          //0xffFFFF00
                                                          ) // Grey background if disabled
                                                      : Color(0xffeff1f2
                                                          //0xffFFFF00
                                                          ), // Transparent if enabled
                                                  foregroundColor: isDisabled
                                                      ? Colors
                                                          .black // Grey text if disabled
                                                      : Colors
                                                          .black, // Black text if enabled
                                                  shadowColor: Colors
                                                      .transparent, // Remove shadow
                                                  elevation:
                                                      0, // Remove elevation
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row containing day headers
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var weekDay in [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ])
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        weekDay,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            // Expanded GridView
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: days.length,
                                itemBuilder: (context, index) {
                                  DateTime day = days[index];
                                  bool isToday =
                                      DateFormat('yyyy-MM-dd').format(day) ==
                                          DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now());

                                  return GestureDetector(
                                    onTap: () {
                                      // Handle the select property here
                                      print(
                                          'Selected: ${day.toIso8601String()}');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4.0),
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  DateFormat('dd').format(day),
                                              style: TextStyle(
                                                color: isToday
                                                    ? Colors.blue
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }

}

//here some error so add new code
// import 'dart:convert';
// import 'package:doctari/local_storage_services/local_storage_methods.dart';
// import 'package:doctari/theme/theme_helper.dart';
// import 'package:intl/intl.dart';
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class DoctorTimeSlot extends StatefulWidget {
//   final String token;
//   DoctorTimeSlot({required this.token, Key? key}) : super(key: key);

//   @override
//   _DoctorTimeSlotState createState() => _DoctorTimeSlotState();
// }

// class _DoctorTimeSlotState extends State<DoctorTimeSlot>
//     with WidgetsBindingObserver {
//   DateTime _currentDate = DateTime(2024, 7, 8); // Starting date
//   DateTime _currentDates = DateTime.now();
//   bool _isWeekView = true;
//   List disabledButtons = [];
//   bool isButtontDisabled = false;
//   List<String>? storedTimeSlots;
//   Set<String> clickedButtons = {};
//   //List<DateTime> buttonValues = ;
//   //List<String> disabledButtons =
//   // LocalStorageMethods.instance.getSelectedTimeSlotsList() ?? [];

//   @override
//   void initState() {
//     super.initState();
//     // WidgetsBinding.instance.addObserver(this);
//     _loadDisabledButtons();
//     _currentDates = _getStartOfWeek(DateTime.now());
//     print("When load data: $disabledButtons");
//     WidgetsBinding.instance.addPostFrameCallback((x) async {
//       selectedTime =
//           await LocalStorageMethods.instance.getSelectedTimeSlotsList();
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   DateTime _getStartOfWeek(DateTime date) {
//     int weekday = date.weekday;
//     return date.subtract(Duration(days: weekday - DateTime.monday));
//   }

//   String getPeriodLabel() {
//     DateTime endDate = _currentDates.add(Duration(days: 6));
//     return '${DateFormat('MMM dd, yyyy').format(_currentDates)} - ${DateFormat('MMM dd, yyyy').format(endDate)}';
//   }

//   void _nextPeriod() {
//     setState(() {
//       _currentDates = _currentDates.add(Duration(days: 7));
//     });
//   }

//   void _previousPeriod() {
//     setState(() {
//       _currentDates = _currentDates.subtract(Duration(days: 7));
//     });
//   }

//   Future<void> _saveDisabledButtons() async {
//     var box = Hive.box('settingsBox');
//     await box.put('disabledButtons', disabledButtons.toList());
//     setState(() {}); // Trigger a rebuild
//     print("When saving data: $disabledButtons");
//   }

//   Future<void> _loadDisabledButtons() async {
//     var box = Hive.box('settingsBox');
//     List<String>? disabledButtonsList =
//         box.get('disabledButtons')?.cast<String>();
//     if (disabledButtonsList != null) {
//       setState(() {
//         disabledButtons = disabledButtonsList.toSet().toList();
//       });
//     }
//     print("When loading data: $disabledButtons");
//   }

//   bool _isPastTime(DateTime day, String hour) {
//     DateTime now = DateTime.now();
//     DateTime buttonDateTime = DateFormat('yyyy-MM-dd HH:mm')
//         .parse('${DateFormat('yyyy-MM-dd').format(day)} $hour');
//     return buttonDateTime.isBefore(now);
//   }

//   List<DateTime> getWeekDays(DateTime startDate) {
//     return List.generate(7, (index) {
//       return startDate.add(Duration(days: index));
//     });
//   }

//   List<DateTime> getMonthDays(DateTime startDate) {
//     DateTime firstDayOfMonth = DateTime(startDate.year, startDate.month, 1);
//     DateTime lastDayOfMonth = DateTime(startDate.year, startDate.month + 1, 0);
//     return List.generate(lastDayOfMonth.day, (index) {
//       return firstDayOfMonth.add(Duration(days: index));
//     });
//   }

//   List<String> getHours() {
//     return List.generate(24, (index) {
//       return DateFormat('HH:00').format(DateTime(2021, 1, 1, index));
//     });
//   }

//   //HERE START API FUNCTION..........................
//   Future<void> _createAvailability(BuildContext context, String start,
//       List<int> types, int doctor, String token) async {
//     await createSingleAvailability(context, start, types, doctor, token);
//   }

//   Future<void> _createMultipleAvailabilities(
//       BuildContext context,
//       String start,
//       String finish,
//       String finishRepeat,
//       List<int> types,
//       bool repeat,
//       int doctor,
//       List<int> weekDays,
//       String token) async {
//     await createMultipleAvailabilities(context, start, finish, finishRepeat,
//         types, repeat, doctor, weekDays, token);
//   }

//   Future<void> createSingleAvailability(BuildContext context, String start,
//       List<int> types, int doctor, String token) async {
//     final url = Uri.parse('https://api-b2c-refactor.doctari.com/schedule/');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = json.encode({
//       'start': start,
//       'types': types,
//       'doctor': doctor,
//     });

//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 201) {
//       print('Availability created successfully');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Single availability created successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showSuccessDialogsingle(
//           context, 'Single availability created successfully');
//     } else {
//       print('Failed to create availability');
//       print('Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to create availability',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showFailureDialogsingle(context, 'Failed to create single availability');
//     }
//   }

//   Future<void> createMultipleAvailabilities(
//       BuildContext context,
//       String start,
//       String finish,
//       String finishRepeat,
//       List<int> types,
//       bool repeat,
//       int doctor,
//       List<int> weekDays,
//       String token) async {
//     final url = Uri.parse(
//         'https://api-b2c-refactor.doctari.com/schedule/create_multiple_schedules/');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = json.encode({
//       'date_start': start,
//       'date_finish': finish,
//       'date_finish_repeat': finishRepeat,
//       'types': types,
//       'repeat': repeat,
//       'doctor': doctor,
//       'days': weekDays,
//     });

//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 201) {
//       print('Multiple availabilities created successfully');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Multiple availabilities created successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showSuccessDialog(
//           context, 'Multiple availabilities created successfully');
//     } else {
//       print('Failed to create multiple availabilities');
//       print('Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to create multiple availabilities Date start should be bigger than today',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showFailureDialog(context, 'Failed to create multiple availabilities');
//     }
//   }

//   void _showSuccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Multiple availabilities created successfully',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'OK',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 // Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true)
//                     .pop(); // Close the original dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showFailureDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Doctor Schedual Create',
//             style: TextStyle(color: Colors.black),
//           ),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showSuccessDialogsingle(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Single availabilty created successfully',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'OK',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true)
//                     .pop(); // Close the original dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showFailureDialogsingle(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Single Availability',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// //HERE END API FUNCTION

// //first popup start here

//   _showPopup(
//       BuildContext context, DateTime day, String time, String delayedTime) {
//     bool isConsultationWeb = false;
//     bool isInPersonConsultation = false;
//     bool isInterconsultation = false;

//     Map<String, bool> weekDays = {
//       'Mon': false,
//       'Tue': false,
//       'Wed': false,
//       'Thu': false,
//       'Fri': false,
//       'Sat': false,
//       'Sun': false,
//     };

//     String selectedDay = DateFormat('EEE').format(day);
//     weekDays[selectedDay] = true;

//     List<int> selectedOptions = [];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             bool isAnyCheckboxSelected() {
//               return isConsultationWeb ||
//                   isInPersonConsultation ||
//                   isInterconsultation;
//             }

//             void updateSelectedOptions(bool? value, int option) {
//               if (value == true) {
//                 if (!selectedOptions.contains(option)) {
//                   selectedOptions.add(option);
//                 }
//               } else {
//                 selectedOptions.remove(option);
//               }
//             }

//             return AlertDialog(
//               titlePadding: EdgeInsets.zero,
//               contentPadding: EdgeInsets.all(20),
//               title: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//                   color: Colors.blue,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Mark hours as available',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     'Schedule consultation for ${DateFormat('yyyy-MM-dd').format(day)} $time and $delayedTime',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(height: 8),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Query type:',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Theme(
//                     data: Theme.of(context).copyWith(
//                       checkboxTheme: CheckboxThemeData(
//                         fillColor: MaterialStateProperty.resolveWith<Color>(
//                             (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.selected)) {
//                             return Colors
//                                 .blue; // Color when checkbox is selected
//                           }
//                           return Colors
//                               .white; // Color when checkbox is not selected
//                         }),
//                         checkColor: MaterialStateProperty.all<Color>(
//                             Colors.white), // Color of the check mark
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         CheckboxListTile(
//                           title: Text("Consultation via web"),
//                           value: isConsultationWeb,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isConsultationWeb = value ?? false;
//                               updateSelectedOptions(value, 1);
//                             });
//                           },
//                         ),
//                         // CheckboxListTile(
//                         //   title: Text("In-person consultation"),
//                         //   value: isInPersonConsultation,
//                         //   onChanged: (bool? value) {
//                         //     setState(() {
//                         //       isInPersonConsultation = value ?? false;
//                         //       updateSelectedOptions(value, 2);
//                         //     });
//                         //   },
//                         // ),
//                         CheckboxListTile(
//                           title: Text("Interconsultation"),
//                           value: isInterconsultation,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isInterconsultation = value ?? false;
//                               updateSelectedOptions(value, 3);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextButton(
//                     onPressed: isAnyCheckboxSelected()
//                         ? () {
//                             Navigator.of(context).pop();
//                             _showSecondPopup(
//                               context,
//                               day,
//                               time,
//                               delayedTime,
//                               selectedOptions,
//                               weekDays,
//                             );
//                           }
//                         : null,
//                     child: Container(
//                       height: 50,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color:
//                             isAnyCheckboxSelected() ? Colors.blue : Colors.grey,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Next',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showSecondPopup(
//     BuildContext context,
//     DateTime day,
//     String time,
//     String delayedTime,
//     List<int> selectedOptions,
//     Map<String, bool> initialWeekDays,
//   ) {
//     CalendarFormat _calendarFormat = CalendarFormat.month;
//     DateTime _focusedDay = DateTime.now();
//     DateTime? _selectedDay;
//     String? _formattedSelectedDay;
//     int _selectedOption = 0;
//     bool isRepeatSelected = false;
//     Map<String, bool> weekDays = Map.from(initialWeekDays);

//     List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//     List<String> getNext7Days(String selectedDay) {
//       int startIndex = allDays.indexOf(selectedDay);
//       List<String> next7Days = [];
//       for (int i = 0; i < 7; i++) {
//         next7Days.add(allDays[(startIndex + i) % 7]);
//       }
//       return next7Days;
//     }

//     List<int> selectedDaysIndices = [];
//     String currentSelectedTime =
//         '${DateFormat('yyyy-MM-dd').format(day)} $time';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               titlePadding: EdgeInsets.zero,
//               contentPadding: EdgeInsets.all(20),
//               title: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//                   color: Colors.blue,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Confirm Appointment',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       'Scheduled time: $currentSelectedTime',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'End time $delayedTime',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Selected options: ${selectedOptions.join(', ')}',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     RadioListTile<int>(
//                       title: Text('Available only this day'),
//                       value: 1,
//                       groupValue: _selectedOption,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedOption = value ?? 1;
//                           isRepeatSelected = _selectedOption == 2;
//                         });
//                       },
//                     ),
//                     RadioListTile<int>(
//                       title: Text('Repeat'),
//                       value: 2,
//                       groupValue: _selectedOption,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedOption = value ?? 2;
//                           isRepeatSelected = _selectedOption == 2;
//                         });
//                       },
//                     ),
//                     if (_selectedOption == 2) ...[
//                       Container(
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Select days:',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 8),
//                             FutureBuilder<List<String>>(
//                               future: LocalStorageMethods.instance
//                                   .getSelectedTimeSlotsList(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return CircularProgressIndicator();
//                                 }
//                                 if (snapshot.hasError) {
//                                   return Text('Error loading time slots');
//                                 }

//                                 List<String> storedTimeSlots =
//                                     snapshot.data ?? [];

//                                 return Wrap(
//                                   spacing: 5.0,
//                                   runSpacing: 5.0,
//                                   children: getNext7Days(
//                                     weekDays.keys.firstWhere(
//                                       (day) => weekDays[day]!,
//                                       orElse: () => 'Mon',
//                                     ),
//                                   ).map((String day) {
//                                     int dayIndex = allDays.indexOf(day) + 1;
//                                     bool isDisabled =
//                                         storedTimeSlots.contains('$day-$time');
//                                     return SizedBox(
//                                       width: MediaQuery.of(context).size.width /
//                                               2 -
//                                           20,
//                                       child: Theme(
//                                         data: Theme.of(context).copyWith(
//                                           checkboxTheme: CheckboxThemeData(
//                                             fillColor: MaterialStateProperty
//                                                 .resolveWith<Color>(
//                                               (Set<MaterialState> states) {
//                                                 if (states.contains(
//                                                     MaterialState.selected)) {
//                                                   return Colors.blue;
//                                                 }
//                                                 return Colors.white;
//                                               },
//                                             ),
//                                             checkColor: MaterialStateProperty
//                                                 .all<Color>(Colors.white),
//                                           ),
//                                         ),
//                                         child: CheckboxListTile(
//                                           title: Text(day),
//                                           value: weekDays[day],
//                                           onChanged: isDisabled
//                                               ? null
//                                               : (bool? value) {
//                                                   setState(() {
//                                                     weekDays[day] =
//                                                         value ?? false;
//                                                     if (value == true) {
//                                                       if (!selectedDaysIndices
//                                                           .contains(dayIndex)) {
//                                                         selectedDaysIndices
//                                                             .add(dayIndex);
//                                                       }
//                                                     } else {
//                                                       selectedDaysIndices
//                                                           .remove(dayIndex);
//                                                     }
//                                                   });
//                                                 },
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 );
//                               },
//                             ),
//                             Column(
//                               children: [
//                                 TableCalendar(
//                                   firstDay: DateTime.utc(2010, 10, 16),
//                                   lastDay: DateTime.utc(2030, 3, 14),
//                                   focusedDay: _focusedDay,
//                                   calendarFormat: _calendarFormat,
//                                   availableCalendarFormats: const {
//                                     CalendarFormat.month: 'Month',
//                                     CalendarFormat.week: 'Week',
//                                   },
//                                   selectedDayPredicate: (day) {
//                                     return isSameDay(_selectedDay, day);
//                                   },
//                                   onDaySelected: (selectedDay, focusedDay) {
//                                     if (!isSameDay(_selectedDay, selectedDay)) {
//                                       setState(() {
//                                         _selectedDay = selectedDay;
//                                         _focusedDay = focusedDay;
//                                         _formattedSelectedDay =
//                                             DateFormat('yyyy-MM-dd HH:mm')
//                                                 .format(selectedDay);
//                                       });
//                                     }
//                                   },
//                                   onFormatChanged: (format) {
//                                     if (_calendarFormat != format) {
//                                       setState(() {
//                                         _calendarFormat = format;
//                                       });
//                                     }
//                                   },
//                                   onPageChanged: (focusedDay) {
//                                     _focusedDay = focusedDay;
//                                   },
//                                 ),
//                                 if (_formattedSelectedDay != null)
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         'Selected Date: $_formattedSelectedDay'),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextButton(
//                     onPressed: () async {
//                       print('Accept button pressed');
//                       String? userId = SessionManager.getUserId();
//                       String? userToken = SessionManager.getUserToken();

//                       // Ensure userId and userToken are not null
//                       if (userId == null || userToken == null) {
//                         // Handle null case (e.g., show an error message)
//                         print("User ID or token is null");
//                         return;
//                       }

//                       int userIdInt = int.parse(userId);

//                       try {
//                         String formattedStart = DateFormat(
//                                 "yyyy-MM-ddTHH:mm:ss")
//                             .format(DateTime.parse(
//                                 "${DateFormat('yyyy-MM-dd').format(day)} $time"));

//                         if (_selectedOption == 1) {
//                           await _createAvailability(
//                             context,
//                             formattedStart,
//                             selectedOptions,
//                             userIdInt,
//                             userToken,
//                           );
//                         } else if (_selectedOption == 2) {
//                           await _createMultipleAvailabilities(
//                             context,
//                             formattedStart,
//                             delayedTime,
//                             _formattedSelectedDay!,
//                             selectedOptions,
//                             isRepeatSelected,
//                             userIdInt,
//                             selectedDaysIndices,
//                             userToken,
//                           );
//                         }
//                         // Update state and save disabled buttons
//                         print("current selected time $currentSelectedTime");
//                         await LocalStorageMethods.instance
//                             .writeSelectedTimeSlot(currentSelectedTime);
//                         storedTimeSlots = await LocalStorageMethods.instance
//                             .getSelectedTimeSlotsList();
//                         print("Stored timeSlots $storedTimeSlots");

//                         setState(() {
//                           disabledButtons.add(currentSelectedTime);
//                           // isButtontDisabled = true;
//                           isButtontDisabled =
//                               storedTimeSlots!.contains(storedTimeSlots);
//                         });
//                         await _saveDisabledButtons();
//                         Navigator.of(context).pop();
//                         // Ensure the dialog closes after all operations
//                         //print('About to close dialog');
//                         Navigator.of(context).pop();
//                         //print('Dialog closed');
//                       } catch (e) {
//                         // Handle any errors
//                         print("Error: $e");
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Accept',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   // void _showSecondPopup(
//   //   BuildContext context,
//   //   DateTime day,
//   //   String time,
//   //   String delayedTime,
//   //   List<int> selectedOptions,
//   //   Map<String, bool> initialWeekDays,
//   // ) {
//   //   CalendarFormat _calendarFormat = CalendarFormat.month;
//   //   DateTime _focusedDay = DateTime.now();
//   //   DateTime? _selectedDay;
//   //   String? _formattedSelectedDay;
//   //   int _selectedOption = 0;
//   //   bool isRepeatSelected = false;
//   //   Map<String, bool> weekDays = Map.from(initialWeekDays);

//   //   List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//   //   List<String> getNext7Days(String selectedDay) {
//   //     int startIndex = allDays.indexOf(selectedDay);
//   //     List<String> next7Days = [];
//   //     for (int i = 0; i < 7; i++) {
//   //       next7Days.add(allDays[(startIndex + i) % 7]);
//   //     }
//   //     return next7Days;
//   //   }

//   //   List<int> selectedDaysIndices = [];

//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return StatefulBuilder(
//   //         builder: (BuildContext context, StateSetter setState) {
//   //           return AlertDialog(
//   //             titlePadding: EdgeInsets.zero,
//   //             contentPadding: EdgeInsets.all(20),
//   //             title: Container(
//   //               width: double.infinity,
//   //               decoration: BoxDecoration(
//   //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//   //                 color: Colors.blue,
//   //               ),
//   //               child: Padding(
//   //                 padding: const EdgeInsets.all(8.0),
//   //                 child: Text(
//   //                   'Confirm Appointment',
//   //                   style: TextStyle(color: Colors.white),
//   //                 ),
//   //               ),
//   //             ),
//   //             content: SingleChildScrollView(
//   //               child: Column(
//   //                 mainAxisSize: MainAxisSize.min,
//   //                 children: <Widget>[
//   //                   Text(
//   //                     'Scheduled time: ${DateFormat('yyyy-MM-dd').format(day)} $time',
//   //                     style: TextStyle(color: Colors.black),
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                   Text(
//   //                     'End time $delayedTime',
//   //                     style: TextStyle(color: Colors.black),
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                   Text(
//   //                     'Selected options: ${selectedOptions.join(', ')}',
//   //                     style: TextStyle(color: Colors.black),
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                   RadioListTile<int>(
//   //                     title: Text('Available only this day'),
//   //                     value: 1,
//   //                     groupValue: _selectedOption,
//   //                     onChanged: (int? value) {
//   //                       setState(() {
//   //                         _selectedOption = value ?? 1;
//   //                         isRepeatSelected = _selectedOption == 2;
//   //                       });
//   //                     },
//   //                   ),
//   //                   RadioListTile<int>(
//   //                     title: Text('Repeat'),
//   //                     value: 2,
//   //                     groupValue: _selectedOption,
//   //                     onChanged: (int? value) {
//   //                       setState(() {
//   //                         _selectedOption = value ?? 2;
//   //                         isRepeatSelected = _selectedOption == 2;
//   //                       });
//   //                     },
//   //                   ),
//   //                   if (_selectedOption == 2) ...[
//   //                     Container(
//   //                       width: double.infinity,
//   //                       child: Column(
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: [
//   //                           Text(
//   //                             'Select days:',
//   //                             style: TextStyle(fontWeight: FontWeight.bold),
//   //                           ),
//   //                           SizedBox(height: 8),
//   //                           Wrap(
//   //                             spacing: 5.0,
//   //                             runSpacing: 5.0,
//   //                             children: getNext7Days(
//   //                               weekDays.keys.firstWhere(
//   //                                 (day) => weekDays[day]!,
//   //                                 orElse: () => 'Mon',
//   //                               ),
//   //                             ).map((String day) {
//   //                               int dayIndex = allDays.indexOf(day) + 1;
//   //                               return SizedBox(
//   //                                 width: MediaQuery.of(context).size.width / 2 -
//   //                                     20,
//   //                                 child: Theme(
//   //                                   data: Theme.of(context).copyWith(
//   //                                     checkboxTheme: CheckboxThemeData(
//   //                                       fillColor: MaterialStateProperty
//   //                                           .resolveWith<Color>(
//   //                                         (Set<MaterialState> states) {
//   //                                           if (states.contains(
//   //                                               MaterialState.selected)) {
//   //                                             return Colors.blue;
//   //                                           }
//   //                                           return Colors.white;
//   //                                         },
//   //                                       ),
//   //                                       checkColor:
//   //                                           MaterialStateProperty.all<Color>(
//   //                                               Colors.white),
//   //                                     ),
//   //                                   ),
//   //                                   child: CheckboxListTile(
//   //                                     title: Text(day),
//   //                                     value: weekDays[day],
//   //                                     onChanged: (bool? value) {
//   //                                       setState(() {
//   //                                         weekDays[day] = value ?? false;
//   //                                         if (value == true) {
//   //                                           if (!selectedDaysIndices
//   //                                               .contains(dayIndex)) {
//   //                                             selectedDaysIndices.add(dayIndex);
//   //                                           }
//   //                                         } else {
//   //                                           selectedDaysIndices
//   //                                               .remove(dayIndex);
//   //                                         }
//   //                                       });
//   //                                     },
//   //                                   ),
//   //                                 ),
//   //                               );
//   //                             }).toList(),
//   //                           ),
//   //                           Column(
//   //                             children: [
//   //                               TableCalendar(
//   //                                 firstDay: DateTime.utc(2010, 10, 16),
//   //                                 lastDay: DateTime.utc(2030, 3, 14),
//   //                                 focusedDay: _focusedDay,
//   //                                 calendarFormat: _calendarFormat,
//   //                                 availableCalendarFormats: const {
//   //                                   CalendarFormat.month: 'Month',
//   //                                   CalendarFormat.week: 'Week',
//   //                                 },
//   //                                 selectedDayPredicate: (day) {
//   //                                   return isSameDay(_selectedDay, day);
//   //                                 },
//   //                                 onDaySelected: (selectedDay, focusedDay) {
//   //                                   if (!isSameDay(_selectedDay, selectedDay)) {
//   //                                     setState(() {
//   //                                       _selectedDay = selectedDay;
//   //                                       _focusedDay = focusedDay;
//   //                                       _formattedSelectedDay =
//   //                                           DateFormat('yyyy-MM-dd HH:mm')
//   //                                               .format(selectedDay);
//   //                                     });
//   //                                   }
//   //                                 },
//   //                                 onFormatChanged: (format) {
//   //                                   if (_calendarFormat != format) {
//   //                                     setState(() {
//   //                                       _calendarFormat = format;
//   //                                     });
//   //                                   }
//   //                                 },
//   //                                 onPageChanged: (focusedDay) {
//   //                                   _focusedDay = focusedDay;
//   //                                 },
//   //                               ),
//   //                               if (_formattedSelectedDay != null)
//   //                                 Padding(
//   //                                   padding: const EdgeInsets.all(8.0),
//   //                                   child: Text(
//   //                                       'Selected Date: $_formattedSelectedDay'),
//   //                                 ),
//   //                             ],
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ],
//   //               ),
//   //             ),
//   //             actions: <Widget>[
//   //               Align(
//   //                 alignment: Alignment.center,
//   //                 child: TextButton(
//   //                   onPressed: () async {
//   //                     print('Accept button pressed');
//   //                     String? userId = SessionManager.getUserId();
//   //                     String? userToken = SessionManager.getUserToken();

//   //                     // Ensure userId and userToken are not null
//   //                     if (userId == null || userToken == null) {
//   //                       // Handle null case (e.g., show an error message)
//   //                       print("User ID or token is null");
//   //                       return;
//   //                     }

//   //                     int userIdInt = int.parse(userId);

//   //                     try {
//   //                       String formattedStart = DateFormat(
//   //                               "yyyy-MM-ddTHH:mm:ss")
//   //                           .format(DateTime.parse(
//   //                               "${DateFormat('yyyy-MM-dd').format(day)} $time"));

//   //                       if (_selectedOption == 1) {
//   //                         await _createAvailability(
//   //                           context,
//   //                           formattedStart,
//   //                           selectedOptions,
//   //                           userIdInt,
//   //                           userToken,
//   //                         );
//   //                       } else if (_selectedOption == 2) {
//   //                         await _createMultipleAvailabilities(
//   //                           context,
//   //                           formattedStart,
//   //                           delayedTime,
//   //                           _formattedSelectedDay!,
//   //                           selectedOptions,
//   //                           isRepeatSelected,
//   //                           userIdInt,
//   //                           selectedDaysIndices,
//   //                           userToken,
//   //                         );
//   //                       }
//   //                       //Navigator.of(context).pop();
//   //                       // Update state and save disabled buttons
//   //                       print("current selected time $day-$time");
//   //                       await LocalStorageMethods.instance
//   //                           .writeSelectedTimeSlot('$day-$time');
//   //                       List<String>? storedTimeSlots = LocalStorageMethods
//   //                           .instance
//   //                           .getSelectedTimeSlotsList();
//   //                       print("BfStored timeSlots $storedTimeSlots");
//   //                       setState(() {
//   //                         disabledButtons.add('$day-$time');
//   //                       });
//   //                       print("AfStored timeSlots $storedTimeSlots");
//   //                       await _saveDisabledButtons();
//   //                       Navigator.of(context).pop();
//   //                       // Ensure the dialog closes after all operations
//   //                       print('About to close dialog');
//   //                       Navigator.of(context).pop();
//   //                       print('Dialog closed');
//   //                     } catch (e) {
//   //                       // Handle any errors
//   //                       print("Error: $e");
//   //                     }
//   //                   },
//   //                   child: Container(
//   //                     height: 50,
//   //                     width: 110,
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.blue,
//   //                       borderRadius: BorderRadius.circular(8),
//   //                     ),
//   //                     child: Center(
//   //                       child: Text(
//   //                         'Accept',
//   //                         style: TextStyle(color: Colors.white),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           );
//   //         },
//   //       );
//   //     },
//   //   );
//   // }
//   List<String> selectedTime = [];

//   @override
//   Widget build(BuildContext context) {
//     //print("when build methode: $disabledButtons");
//     List<DateTime> days =
//         _isWeekView ? getWeekDays(_currentDates) : getMonthDays(_currentDates);
//     List<String> hours = getHours();

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         backgroundColor: theme.primaryColor,
//         title: Text(
//           'Doctor Time Slot',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
//           child: Column(
//             children: [
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     GestureDetector(
//               //       onTap: () {
//               //         setState(() {
//               //           _isWeekView = true;
//               //         });
//               //       },
//               //       child: Container(
//               //         padding: EdgeInsets.all(8.0),
//               //         child: Text(
//               //           'Week',
//               //           style: TextStyle(
//               //             color: _isWeekView ? Colors.black : Colors.grey,
//               //             fontSize: 18,
//               //             fontWeight:
//               //                 _isWeekView ? FontWeight.bold : FontWeight.normal,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //     SizedBox(width: 16),
//               //     GestureDetector(
//               //       onTap: () {
//               //         setState(() {
//               //           _isWeekView = false;
//               //         });
//               //       },
//               //       child: Container(
//               //         padding: EdgeInsets.all(8.0),
//               //         child: Text(
//               //           'Month',
//               //           style: TextStyle(
//               //             color: !_isWeekView ? Colors.black : Colors.grey,
//               //             fontSize: 18,
//               //             fontWeight: !_isWeekView
//               //                 ? FontWeight.bold
//               //                 : FontWeight.normal,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: _previousPeriod,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       getPeriodLabel(),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.arrow_forward),
//                     onPressed: _nextPeriod,
//                   ),
//                 ],
//               ),
//               Expanded(
//                   child: _isWeekView
//                       ? SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: days.map((day) {
//                               bool isToday =
//                                   DateFormat('yyyy-MM-dd').format(day) ==
//                                       DateFormat('yyyy-MM-dd')
//                                           .format(DateTime.now());

//                               return Container(
//                                 width: MediaQuery.of(context).size.width /
//                                     4, // 1/4th of the screen width
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: RichText(
//                                         textAlign: TextAlign.center,
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text:
//                                                   '${DateFormat('EEE').format(day)}. ', // Abbreviated day name
//                                               style: TextStyle(
//                                                 color: isToday
//                                                     ? Colors.blue
//                                                     : Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             TextSpan(
//                                               text: DateFormat('dd')
//                                                   .format(day), // Date
//                                               style: TextStyle(
//                                                 color: isToday
//                                                     ? Colors.blue
//                                                     : Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: ListView.builder(
//                                         itemCount: hours.length,
//                                         itemBuilder: (context, index) {
//                                           DateTime actualDateTime =
//                                               DateFormat('HH:00')
//                                                   .parse(hours[index]);
//                                           DateTime delayedDateTime =
//                                               actualDateTime
//                                                   .add(Duration(hours: 1));
//                                           String delayedTime =
//                                               DateFormat('HH:00')
//                                                   .format(delayedDateTime);

//                                           DateTime combinedDelayedDateTime =
//                                               DateTime(
//                                             day.year,
//                                             day.month,
//                                             day.day,
//                                             delayedDateTime.hour,
//                                             delayedDateTime.minute,
//                                           );

//                                           String formattedDelayedDateTime =
//                                               DateFormat('yyyy-MM-dd HH:mm')
//                                                   .format(
//                                                       combinedDelayedDateTime);
//                                           String buttonKey =
//                                               '$day-${hours[index]}';

//                                           bool isPastTime =
//                                               _isPastTime(day, hours[index]);
//                                           //bool isInDisabledList = disabledButtons
//                                           //.contains('$day-${hours[index]}');
//                                           bool isDisabled = isPastTime ||
//                                               isButtontDisabled ||
//                                               selectedTime.contains(
//                                                   "$day ${hours[index]}");

//                                           return
//                                               // InkWell(
//                                               //   onTap: () async {
//                                               //     if (selectedTime.contains(
//                                               //         hours[index].toString())) {
//                                               //       print("already selected");
//                                               //     } else {
//                                               //       LocalStorageMethods.instance
//                                               //           .writeSelectedTimeSlot(
//                                               //               hours[index]
//                                               //                   .toString());
//                                               //       selectedTime =
//                                               //           await LocalStorageMethods
//                                               //               .instance
//                                               //               .getSelectedTimeSlotsList();
//                                               //       setState(() {});
//                                               //     }
//                                               //   },
//                                               //   child: Container(
//                                               //     height: 30,
//                                               //     width: 30,
//                                               //     margin: EdgeInsets.all(4),
//                                               //     color: selectedTime.contains(
//                                               //             hours[index].toString())
//                                               //         ? Colors.red
//                                               //         : Colors.green,
//                                               //     child:
//                                               //         Text(hours[index].toString()),
//                                               //   ),
//                                               // );

//                                               Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 4.0, horizontal: 4),
//                                             child: ElevatedButton(
//                                               onPressed: isDisabled
//                                                   ? null
//                                                   : () async {
//                                                       print(
//                                                           "$day:${hours[index]}:$formattedDelayedDateTime");
//                                                       await _showPopup(
//                                                           context,
//                                                           day,
//                                                           hours[index],
//                                                           formattedDelayedDateTime);

//                                                       // Update the clickedButtons set to change the color
//                                                       setState(() {
//                                                         clickedButtons
//                                                             .add(buttonKey);
//                                                       });

//                                                       //Optionally, update disabledButtons list and save it
//                                                       if (!disabledButtons
//                                                           .contains(
//                                                               buttonKey)) {
//                                                         setState(() {
//                                                           disabledButtons
//                                                               .add(buttonKey);
//                                                         });
//                                                         await _saveDisabledButtons();
//                                                       }
//                                                     },
//                                               // child: Text(
//                                               //   hours[index],
//                                               //   style:
//                                               //       TextStyle(fontSize: 12),
//                                               // ),
//                                               style: ElevatedButton.styleFrom(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 8.0),
//                                                 backgroundColor: clickedButtons
//                                                         .contains(buttonKey)
//                                                     ? Colors
//                                                         .blue // Change to blue if clicked
//                                                     : (isDisabled
//                                                         ? Color(
//                                                             0xffd4d6fd) // Grey background if disabled
//                                                         : Color(
//                                                             0xffeff1f2)), // Transparent if enabled
//                                                 foregroundColor: Colors
//                                                     .black, // Text color remains the same
//                                                 shadowColor: Colors
//                                                     .transparent, // Remove shadow
//                                                 elevation:
//                                                     0, // Remove elevation
//                                               ),

//                                               child: ElevatedButton(
//                                                 onPressed: isDisabled
//                                                     ? null
//                                                     : () async {
//                                                         print(
//                                                             "$day:${hours[index]}:$formattedDelayedDateTime");
//                                                         await _showPopup(
//                                                             context,
//                                                             day,
//                                                             hours[index],
//                                                             formattedDelayedDateTime);

//                                                         // Update the disabledButtons list and save it
//                                                         // String buttonKey =
//                                                         //     '$day-${hours[index]}';
//                                                         // if (!disabledButtons
//                                                         //     .contains(buttonKey)) {
//                                                         //   setState(() {
//                                                         //     disabledButtons
//                                                         //         .add(buttonKey);
//                                                         //   });
//                                                         //   await _saveDisabledButtons();
//                                                         // }
//                                                       },
//                                                 child: Text(
//                                                   hours[index],
//                                                   style:
//                                                       TextStyle(fontSize: 12),
//                                                 ),
//                                                 style: ElevatedButton.styleFrom(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8.0),
//                                                   backgroundColor: isDisabled
//                                                       ? Color(
//                                                           0xffd4d6fd) // Grey background if disabled
//                                                       : Color(
//                                                           0xffeff1f2), // Transparent if enabled
//                                                   foregroundColor: isDisabled
//                                                       ? Colors
//                                                           .black // Grey text if disabled
//                                                       : Colors
//                                                           .black, // Black text if enabled
//                                                   shadowColor: Colors
//                                                       .transparent, // Remove shadow
//                                                   elevation:
//                                                       0, // Remove elevation
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Row containing day headers
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   for (var weekDay in [
//                                     'Mon',
//                                     'Tue',
//                                     'Wed',
//                                     'Thu',
//                                     'Fri',
//                                     'Sat',
//                                     'Sun'
//                                   ])
//                                     Container(
//                                       width:
//                                           MediaQuery.of(context).size.width / 7,
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text(
//                                         weekDay,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             // Expanded GridView
//                             Expanded(
//                               child: GridView.builder(
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 7,
//                                   childAspectRatio: 1.0,
//                                 ),
//                                 itemCount: days.length,
//                                 itemBuilder: (context, index) {
//                                   DateTime day = days[index];
//                                   bool isToday =
//                                       DateFormat('yyyy-MM-dd').format(day) ==
//                                           DateFormat('yyyy-MM-dd')
//                                               .format(DateTime.now());

//                                   return GestureDetector(
//                                     onTap: () {
//                                       // Handle the select property here
//                                       print(
//                                           'Selected: ${day.toIso8601String()}');
//                                     },
//                                     child: Container(
//                                       margin: EdgeInsets.all(4.0),
//                                       padding: EdgeInsets.all(8.0),
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius:
//                                             BorderRadius.circular(4.0),
//                                       ),
//                                       child: RichText(
//                                         textAlign: TextAlign.center,
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text:
//                                                   DateFormat('dd').format(day),
//                                               style: TextStyle(
//                                                 color: isToday
//                                                     ? Colors.blue
//                                                     : Colors.black,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         )

//                   // : Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     children: [
//                   //       Row(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           for (var weekDay in [
//                   //             'Mon',
//                   //             'Tue',
//                   //             'Wed',
//                   //             'Thu',
//                   //             'Fri',
//                   //             'Sat',
//                   //             'Sun'
//                   //           ])
//                   //             Container(
//                   //               width: MediaQuery.of(context).size.width / 7,
//                   //               padding: EdgeInsets.all(8.0),
//                   //               child: Text(
//                   //                 weekDay,
//                   //                 textAlign: TextAlign.center,
//                   //                 style:
//                   //                     TextStyle(fontWeight: FontWeight.bold),
//                   //               ),
//                   //             ),
//                   //         ],
//                   //       ),
//                   //       SizedBox(height: 8),
//                   //       Expanded(
//                   //         child: GridView.builder(
//                   //           gridDelegate:
//                   //               SliverGridDelegateWithFixedCrossAxisCount(
//                   //             crossAxisCount: 7,
//                   //             childAspectRatio: 1.0,
//                   //           ),
//                   //           itemCount: days.length,
//                   //           itemBuilder: (context, index) {
//                   //             DateTime day = days[index];
//                   //             bool isToday =
//                   //                 DateFormat('yyyy-MM-dd').format(day) ==
//                   //                     DateFormat('yyyy-MM-dd')
//                   //                         .format(DateTime.now());

//                   //             return GestureDetector(
//                   //               onTap: () {
//                   //                 // Handle the select property here
//                   //                 print('Selected: ${day.toIso8601String()}');
//                   //               },
//                   //               child: Container(
//                   //                 margin: EdgeInsets.all(4.0),
//                   //                 padding: EdgeInsets.all(8.0),
//                   //                 alignment: Alignment.center,
//                   //                 decoration: BoxDecoration(
//                   //                   border: Border.all(color: Colors.grey),
//                   //                   borderRadius: BorderRadius.circular(4.0),
//                   //                 ),
//                   //                 child: RichText(
//                   //                   textAlign: TextAlign.center,
//                   //                   text: TextSpan(
//                   //                     children: [
//                   //                       TextSpan(
//                   //                         text: DateFormat('dd').format(day),
//                   //                         style: TextStyle(
//                   //                           color: isToday
//                   //                               ? Colors.blue
//                   //                               : Colors.black,
//                   //                           fontWeight: FontWeight.w600,
//                   //                         ),
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //               ),
//                   //             );
//                   //           },
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),

//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//start updating code from here date 07/08/24
// import 'dart:convert';
// import 'package:doctari/local_storage_services/local_storage_methods.dart';
// import 'package:intl/intl.dart';
// import 'package:doctari/sessionManager/session_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class DoctorTimeSlot extends StatefulWidget {
//   final String token;
//   DoctorTimeSlot({required this.token, Key? key}) : super(key: key);

//   @override
//   _DoctorTimeSlotState createState() => _DoctorTimeSlotState();
// }

// class _DoctorTimeSlotState extends State<DoctorTimeSlot> {
//   DateTime _currentDate = DateTime(2024, 7, 8); // Starting date
//   DateTime _currentDates = DateTime.now();
//   bool _isWeekView = true;

//   List<String> disabledButtons =
//       LocalStorageMethods.instance.getSelectedTimeSlotsList() ?? [];

//   List<DateTime> getWeekDays(DateTime startDate) {
//     return List.generate(7, (index) {
//       return startDate.add(Duration(days: index));
//     });
//   }

//   List<DateTime> getMonthDays(DateTime startDate) {
//     DateTime firstDayOfMonth = DateTime(startDate.year, startDate.month, 1);
//     DateTime lastDayOfMonth = DateTime(startDate.year, startDate.month + 1, 0);
//     return List.generate(lastDayOfMonth.day, (index) {
//       return firstDayOfMonth.add(Duration(days: index));
//     });
//   }

//   List<String> getHours() {
//     return List.generate(24, (index) {
//       return DateFormat('HH:00').format(DateTime(2021, 1, 1, index));
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _currentDates = _getStartOfWeek(DateTime.now());
//     super.initState();
//     _loadDisabledButtons(); // Load disabled buttons on widget initialization
//   }

//   DateTime _getStartOfWeek(DateTime date) {
//     int weekday = date.weekday;
//     return date.subtract(Duration(days: weekday - DateTime.monday));
//   }

//   String getPeriodLabel() {
//     DateTime endDate = _currentDates.add(Duration(days: 6));
//     return '${DateFormat('MMM dd, yyyy').format(_currentDates)} - ${DateFormat('MMM dd, yyyy').format(endDate)}';
//   }

//   void _nextPeriod() {
//     setState(() {
//       _currentDates = _currentDates.add(Duration(days: 7));
//     });
//   }

//   void _previousPeriod() {
//     setState(() {
//       _currentDates = _currentDates.subtract(Duration(days: 7));
//     });
//   }

//   Future<void> _loadDisabledButtons() async {
//     var box = Hive.box('settingsBox');
//     List<String>? disabledButtonsList =
//         box.get('disabledButtons')?.cast<String>();
//     if (disabledButtonsList != null) {
//       setState(() {
//         disabledButtons = disabledButtonsList.toSet().toList();
//       });
//     }
//   }

//   Future<void> _saveDisabledButtons() async {
//     var box = Hive.box('settingsBox');
//     box.put('disabledButtons', disabledButtons.toList());
//     setState(() {});
//   }

// //HERE START API FUNCTION..........................
//   Future<void> _createAvailability(BuildContext context, String start,
//       List<int> types, int doctor, String token) async {
//     await createSingleAvailability(context, start, types, doctor, token);
//   }

//   Future<void> _createMultipleAvailabilities(
//       BuildContext context,
//       String start,
//       String finish,
//       String finishRepeat,
//       List<int> types,
//       bool repeat,
//       int doctor,
//       List<int> weekDays,
//       String token) async {
//     await createMultipleAvailabilities(context, start, finish, finishRepeat,
//         types, repeat, doctor, weekDays, token);
//   }

//   Future<void> createSingleAvailability(BuildContext context, String start,
//       List<int> types, int doctor, String token) async {
//     final url = Uri.parse('https://api-b2c-refactor.doctari.com/schedule/');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = json.encode({
//       'start': start,
//       'types': types,
//       'doctor': doctor,
//     });

//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 201) {
//       print('Availability created successfully');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Single availability created successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showSuccessDialogsingle(
//           context, 'Single availability created successfully');
//     } else {
//       print('Failed to create availability');
//       print('Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to create availability',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showFailureDialogsingle(context, 'Failed to create single availability');
//     }
//   }

//   Future<void> createMultipleAvailabilities(
//       BuildContext context,
//       String start,
//       String finish,
//       String finishRepeat,
//       List<int> types,
//       bool repeat,
//       int doctor,
//       List<int> weekDays,
//       String token) async {
//     final url = Uri.parse(
//         'https://api-b2c-refactor.doctari.com/schedule/create_multiple_schedules/');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = json.encode({
//       'date_start': start,
//       'date_finish': finish,
//       'date_finish_repeat': finishRepeat,
//       'types': types,
//       'repeat': repeat,
//       'doctor': doctor,
//       'days': weekDays,
//     });

//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 201) {
//       print('Multiple availabilities created successfully');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Multiple availabilities created successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showSuccessDialog(
//           context, 'Multiple availabilities created successfully');
//     } else {
//       print('Failed to create multiple availabilities');
//       print('Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to create multiple availabilities Date start should be bigger than today',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//         ),
//       );
//       _showFailureDialog(context, 'Failed to create multiple availabilities');
//     }
//   }

//   void _showSuccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Multiple availabilities created successfully',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'OK',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 // Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true)
//                     .pop(); // Close the original dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showFailureDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Doctor Schedual Create',
//             style: TextStyle(color: Colors.black),
//           ),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showSuccessDialogsingle(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Single availabilty created successfully',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'OK',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true)
//                     .pop(); // Close the original dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showFailureDialogsingle(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Single Availability',
//             style: TextStyle(color: Colors.black),
//           ),
//           // content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the success dialog
//                 Navigator.of(context, rootNavigator: true).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// //HERE END API FUNCTION

// //first popup start here

//   void _showPopup(
//       BuildContext context, DateTime day, String time, String delayedTime) {
//     bool isConsultationWeb = false;
//     bool isInPersonConsultation = false;
//     bool isInterconsultation = false;

//     Map<String, bool> weekDays = {
//       'Mon': false,
//       'Tue': false,
//       'Wed': false,
//       'Thu': false,
//       'Fri': false,
//       'Sat': false,
//       'Sun': false,
//     };

//     String selectedDay = DateFormat('EEE').format(day);
//     weekDays[selectedDay] = true;

//     List<int> selectedOptions = [];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             bool isAnyCheckboxSelected() {
//               return isConsultationWeb ||
//                   isInPersonConsultation ||
//                   isInterconsultation;
//             }

//             void updateSelectedOptions(bool? value, int option) {
//               if (value == true) {
//                 if (!selectedOptions.contains(option)) {
//                   selectedOptions.add(option);
//                 }
//               } else {
//                 selectedOptions.remove(option);
//               }
//             }

//             return AlertDialog(
//               titlePadding: EdgeInsets.zero,
//               contentPadding: EdgeInsets.all(20),
//               title: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//                   color: Colors.blue,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Mark hours as available',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     'Schedule consultation for ${DateFormat('yyyy-MM-dd').format(day)} $time and $delayedTime',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(height: 8),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Query type:',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Theme(
//                     data: Theme.of(context).copyWith(
//                       checkboxTheme: CheckboxThemeData(
//                         fillColor: MaterialStateProperty.resolveWith<Color>(
//                             (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.selected)) {
//                             return Colors
//                                 .blue; // Color when checkbox is selected
//                           }
//                           return Colors
//                               .white; // Color when checkbox is not selected
//                         }),
//                         checkColor: MaterialStateProperty.all<Color>(
//                             Colors.white), // Color of the check mark
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         CheckboxListTile(
//                           title: Text("Consultation via web"),
//                           value: isConsultationWeb,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isConsultationWeb = value ?? false;
//                               updateSelectedOptions(value, 1);
//                             });
//                           },
//                         ),
//                         CheckboxListTile(
//                           title: Text("In-person consultation"),
//                           value: isInPersonConsultation,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isInPersonConsultation = value ?? false;
//                               updateSelectedOptions(value, 2);
//                             });
//                           },
//                         ),
//                         CheckboxListTile(
//                           title: Text("Interconsultation"),
//                           value: isInterconsultation,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isInterconsultation = value ?? false;
//                               updateSelectedOptions(value, 3);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextButton(
//                     onPressed: isAnyCheckboxSelected()
//                         ? () {
//                             Navigator.of(context).pop();
//                             _showSecondPopup(
//                               context,
//                               day,
//                               time,
//                               delayedTime,
//                               selectedOptions,
//                               weekDays,
//                             );
//                           }
//                         : null,
//                     child: Container(
//                       height: 50,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color:
//                             isAnyCheckboxSelected() ? Colors.blue : Colors.grey,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Next',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showSecondPopup(
//     BuildContext context,
//     DateTime day,
//     String time,
//     String delayedTime,
//     List<int> selectedOptions,
//     Map<String, bool> initialWeekDays,
//   ) {
//     CalendarFormat _calendarFormat = CalendarFormat.month;
//     DateTime _focusedDay = DateTime.now();
//     DateTime? _selectedDay;
//     String? _formattedSelectedDay;
//     int _selectedOption = 0;
//     bool isRepeatSelected = false;
//     Map<String, bool> weekDays = Map.from(initialWeekDays);

//     List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//     List<String> getNext7Days(String selectedDay) {
//       int startIndex = allDays.indexOf(selectedDay);
//       List<String> next7Days = [];
//       for (int i = 0; i < 7; i++) {
//         next7Days.add(allDays[(startIndex + i) % 7]);
//       }
//       return next7Days;
//     }

//     List<int> selectedDaysIndices = [];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               titlePadding: EdgeInsets.zero,
//               contentPadding: EdgeInsets.all(20),
//               title: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//                   color: Colors.blue,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Confirm Appointment',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       'Scheduled time: ${DateFormat('yyyy-MM-dd').format(day)} $time',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'End time $delayedTime',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Selected options: ${selectedOptions.join(', ')}',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 8),
//                     RadioListTile<int>(
//                       title: Text('Available only this day'),
//                       value: 1,
//                       groupValue: _selectedOption,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedOption = value ?? 1;
//                           isRepeatSelected = _selectedOption == 2;
//                         });
//                       },
//                     ),
//                     RadioListTile<int>(
//                       title: Text('Repeat'),
//                       value: 2,
//                       groupValue: _selectedOption,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedOption = value ?? 2;
//                           isRepeatSelected = _selectedOption == 2;
//                         });
//                       },
//                     ),
//                     if (_selectedOption == 2) ...[
//                       Container(
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Select days:',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 8),
//                             Wrap(
//                               spacing: 5.0,
//                               runSpacing: 5.0,
//                               children: getNext7Days(
//                                 weekDays.keys.firstWhere(
//                                   (day) => weekDays[day]!,
//                                   orElse: () => 'Mon',
//                                 ),
//                               ).map((String day) {
//                                 int dayIndex = allDays.indexOf(day) + 1;
//                                 return SizedBox(
//                                   width: MediaQuery.of(context).size.width / 2 -
//                                       20,
//                                   child: Theme(
//                                     data: Theme.of(context).copyWith(
//                                       checkboxTheme: CheckboxThemeData(
//                                         fillColor: MaterialStateProperty
//                                             .resolveWith<Color>(
//                                           (Set<MaterialState> states) {
//                                             if (states.contains(
//                                                 MaterialState.selected)) {
//                                               return Colors.blue;
//                                             }
//                                             return Colors.white;
//                                           },
//                                         ),
//                                         checkColor:
//                                             MaterialStateProperty.all<Color>(
//                                                 Colors.white),
//                                       ),
//                                     ),
//                                     child: CheckboxListTile(
//                                       title: Text(day),
//                                       value: weekDays[day],
//                                       onChanged: (bool? value) {
//                                         setState(() {
//                                           weekDays[day] = value ?? false;
//                                           if (value == true) {
//                                             if (!selectedDaysIndices
//                                                 .contains(dayIndex)) {
//                                               selectedDaysIndices.add(dayIndex);
//                                             }
//                                           } else {
//                                             selectedDaysIndices
//                                                 .remove(dayIndex);
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                             Column(
//                               children: [
//                                 TableCalendar(
//                                   firstDay: DateTime.utc(2010, 10, 16),
//                                   lastDay: DateTime.utc(2030, 3, 14),
//                                   focusedDay: _focusedDay,
//                                   calendarFormat: _calendarFormat,
//                                   availableCalendarFormats: const {
//                                     CalendarFormat.month: 'Month',
//                                     CalendarFormat.week: 'Week',
//                                   },
//                                   selectedDayPredicate: (day) {
//                                     return isSameDay(_selectedDay, day);
//                                   },
//                                   onDaySelected: (selectedDay, focusedDay) {
//                                     if (!isSameDay(_selectedDay, selectedDay)) {
//                                       setState(() {
//                                         _selectedDay = selectedDay;
//                                         _focusedDay = focusedDay;
//                                         _formattedSelectedDay =
//                                             DateFormat('yyyy-MM-dd HH:mm')
//                                                 .format(selectedDay);
//                                       });
//                                     }
//                                   },
//                                   onFormatChanged: (format) {
//                                     if (_calendarFormat != format) {
//                                       setState(() {
//                                         _calendarFormat = format;
//                                       });
//                                     }
//                                   },
//                                   onPageChanged: (focusedDay) {
//                                     _focusedDay = focusedDay;
//                                   },
//                                 ),
//                                 if (_formattedSelectedDay != null)
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         'Selected Date: $_formattedSelectedDay'),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextButton(
//                     onPressed: () async {
//                       print('Accept button pressed');
//                       String? userId = SessionManager.getUserId();
//                       String? userToken = SessionManager.getUserToken();

//                       // Ensure userId and userToken are not null
//                       if (userId == null || userToken == null) {
//                         // Handle null case (e.g., show an error message)
//                         print("User ID or token is null");
//                         return;
//                       }

//                       int userIdInt = int.parse(userId);

//                       try {
//                         String formattedStart = DateFormat(
//                                 "yyyy-MM-ddTHH:mm:ss")
//                             .format(DateTime.parse(
//                                 "${DateFormat('yyyy-MM-dd').format(day)} $time"));

//                         if (_selectedOption == 1) {
//                           await _createAvailability(
//                             context,
//                             formattedStart,
//                             selectedOptions,
//                             userIdInt,
//                             userToken,
//                           );
//                         } else if (_selectedOption == 2) {
//                           await _createMultipleAvailabilities(
//                             context,
//                             formattedStart,
//                             delayedTime,
//                             _formattedSelectedDay!,
//                             selectedOptions,
//                             isRepeatSelected,
//                             userIdInt,
//                             selectedDaysIndices,
//                             userToken,
//                           );
//                         }
//                         Navigator.of(context).pop();
//                         // Update state and save disabled buttons
//                         await LocalStorageMethods.instance
//                             .writeSelectedTimeSlot('$day-$time');
//                         setState(() {
//                           disabledButtons.add('$day-$time');
//                         });
//                         await _saveDisabledButtons();

//                         // Ensure the dialog closes after all operations
//                         print('About to close dialog');
//                         Navigator.of(context).pop();
//                         print('Dialog closed');
//                       } catch (e) {
//                         // Handle any errors
//                         print("Error: $e");
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Accept',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<DateTime> days =
//         _isWeekView ? getWeekDays(_currentDates) : getMonthDays(_currentDates);
//     List<String> hours = getHours();

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isWeekView = true;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Week',
//                         style: TextStyle(
//                           color: _isWeekView ? Colors.black : Colors.grey,
//                           fontSize: 18,
//                           fontWeight:
//                               _isWeekView ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isWeekView = false;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Month',
//                         style: TextStyle(
//                           color: !_isWeekView ? Colors.black : Colors.grey,
//                           fontSize: 18,
//                           fontWeight: !_isWeekView
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: _previousPeriod,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       getPeriodLabel(),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.arrow_forward),
//                     onPressed: _nextPeriod,
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: _isWeekView
//                     ? SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: days.map((day) {
//                             return Container(
//                               width: MediaQuery.of(context).size.width /
//                                   4, // 1/4th of the screen width
//                               child: Column(
//                                 children: [
//                                   //in this container set uper day name and date
//                                   Container(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       '${DateFormat('EEE').format(day)}. ${DateFormat('dd').format(day)}', // Abbreviated day name and date
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),

//                                   /// store on local
//                                   /// list of map
//                                   /// {
//                                   ///   "Tue.23":"2:00"
//                                   /// }
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: hours.length,
//                                       itemBuilder: (context, index) {
//                                         DateTime actualDateTime =
//                                             DateFormat('HH:00')
//                                                 .parse(hours[index]);
//                                         DateTime delayedDateTime =
//                                             actualDateTime
//                                                 .add(Duration(hours: 1));
//                                         String delayedTime = DateFormat('HH:00')
//                                             .format(delayedDateTime);

//                                         // Combine day and delayedTime to get the complete DateTime
//                                         DateTime combinedDelayedDateTime =
//                                             DateTime(
//                                           day.year,
//                                           day.month,
//                                           day.day,
//                                           delayedDateTime.hour,
//                                           delayedDateTime.minute,
//                                         );

//                                         // Format the combined DateTime to the required format
//                                         String formattedDelayedDateTime =
//                                             DateFormat('yyyy-MM-dd HH:mm')
//                                                 .format(
//                                                     combinedDelayedDateTime);
//                                         bool isDisabled = !disabledButtons
//                                             .contains('$day-${hours[index]}');
//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 4.0,
//                                             horizontal: 4,
//                                           ),
//                                           child: ElevatedButton(
//                                             onPressed: isDisabled
//                                                 // !disabledButtons
//                                                 //         .contains(
//                                                 //             '$day-${hours[index]}')
//                                                 ? () {
//                                                     print(
//                                                         "$day:${hours[index]}:$formattedDelayedDateTime");
//                                                     _showPopup(
//                                                         context,
//                                                         day,
//                                                         hours[index],
//                                                         formattedDelayedDateTime);
//                                                   }
//                                                 : null, // Disable button if value is in disabledButtons
//                                             child: Text(
//                                               hours[index],
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             style: ElevatedButton.styleFrom(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 8.0),
//                                               backgroundColor: isDisabled
//                                                   // disabledButtons
//                                                   //         .contains(
//                                                   //             '$day-${hours[index]}')
//                                                   ? Color(
//                                                       0xffeff1f2) // Grey background if disabled
//                                                   : Color(
//                                                       0xffd4d6fd), // Transparent if enabled
//                                               foregroundColor: isDisabled
//                                                   // disabledButtons
//                                                   //         .contains(
//                                                   //             '$day-${hours[index]}')
//                                                   ? Colors
//                                                       .black // White text if disabled
//                                                   : Colors
//                                                       .black, // Black text if enabled
//                                               shadowColor: Colors
//                                                   .transparent, // Remove shadow
//                                               elevation: 0, // Remove elevation
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       )
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               for (var weekDay in [
//                                 'Mon',
//                                 'Tue',
//                                 'Wed',
//                                 'Thu',
//                                 'Fri',
//                                 'Sat',
//                                 'Sun'
//                               ])
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 7,
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     weekDay,
//                                     textAlign: TextAlign.center,
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           Expanded(
//                             child: GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 7,
//                                 childAspectRatio: 1.0,
//                               ),
//                               itemCount: days.length,
//                               itemBuilder: (context, index) {
//                                 DateTime day = days[index];
//                                 return GestureDetector(
//                                   onTap: () {
//                                     // Handle the select property here
//                                     print('Selected: ${day.toIso8601String()}');
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.all(4.0),
//                                     padding: EdgeInsets.all(8.0),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(4.0),
//                                     ),
//                                     child: Text(
//                                       DateFormat('dd').format(day),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
