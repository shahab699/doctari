// import 'package:appointment_app/chat/appointment_detail_page.dart';
// import 'package:flutter/material.dart';

// class AppointmentCard extends StatelessWidget {
//   final Map<String, dynamic> appointmentDetails;

//   const AppointmentCard({Key? key, required this.appointmentDetails})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       child: Card(
//         elevation: 4,
//         margin: EdgeInsets.all(10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Appointment',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               _buildDetailRow("Name", '${appointmentDetails['patientName']}'),
//               _buildDivider(),
//               _buildDetailRow("Date", '${appointmentDetails['date']}'),
//               _buildDivider(),
//               _buildDetailRow("Time", '${appointmentDetails['time']}'),
//               _buildDivider(),
//               _buildDetailRow(
//                   "AppointmentType", '${appointmentDetails['type']}'),
//               _buildDivider(),
//               _buildDetailRow("Amount", '${appointmentDetails['amount']}\$'),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle view details button click
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: ((context) => AppointmentDetailPage(
//                                     appointmentId:
//                                         appointmentDetails['appointmentId'],
//                                   ))));
//                     },
//                     child: Text(
//                       'View Details',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//         SizedBox(height: 4.0),
//         Text(
//           value,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16.0,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(
//       color: Colors.grey[300],
//       height: 16.0,
//       thickness: 1.0,
//     );
//   }
// }
