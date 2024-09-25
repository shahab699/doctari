// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatefulWidget {
//   final Function(DateTime) onDateSelected;
//   const CalendarWidget({Key? key, required this.onDateSelected})
//       : super(key: key);
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   late CalendarFormat _calendarFormat;
//   late DateTime _focusedDay;
//   late DateTime _selectedDay;

//   @override
//   void initState() {
//     super.initState();
//     _calendarFormat = CalendarFormat.month;
//     _focusedDay = DateTime.now();
//     _selectedDay = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.0), // Rounded border radius
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       padding: EdgeInsets.all(20.0),
//       child: TableCalendar(
//         calendarFormat: _calendarFormat,
//         focusedDay: _focusedDay,
//         firstDay: DateTime(2010),
//         lastDay: DateTime(2030),
//         selectedDayPredicate: (day) {
//           return isSameDay(_selectedDay, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//         },
//         onPageChanged: (focusedDay) {
//           _focusedDay = focusedDay;
//         },
//         calendarStyle: CalendarStyle(
//           todayDecoration: BoxDecoration(
//             color: Colors.blue.withOpacity(0.5),
//             shape: BoxShape.circle,
//           ),
//           selectedDecoration: BoxDecoration(
//             color: Color(0xff0066FF),
//             shape: BoxShape.rectangle,
//           ),
//         ),
//         headerStyle: HeaderStyle(
//           formatButtonVisible: false,
//           titleTextStyle: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = selectedDay;
//       _focusedDay = focusedDay;
//     });
//     widget.onDateSelected(selectedDay); // Call the callback function
//   }
// }
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const CalendarWidget({Key? key, required this.onDateSelected})
      : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0), // Rounded border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(20.0),
      child: TableCalendar(
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        firstDay: DateTime(2010),
        lastDay: DateTime(2030),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: _onDaySelected, // Call _onDaySelected function
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xff0066FF),
            shape: BoxShape.rectangle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    widget.onDateSelected(selectedDay); // Call the callback function
  }
}
