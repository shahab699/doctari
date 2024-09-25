// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookingRequestData {
//   final String profileImageUrl;
//   final String name;
//   final String patientAddress;
//   final String date;
//   final String time;
//   final String id;
//   final String userId;
//   final String docName;
//   final String userDeviceToken;
//   final String docId;
//   final String docLocation;
//   final String appointmentType;
//   bool isAppointmentTimeReached;
//   final String? amount;
//   final String petName;
//   final String petBreed;

//   BookingRequestData(
//       {required this.profileImageUrl,
//       required this.name,
//       required this.patientAddress,
//       required this.date,
//       required this.time,
//       required this.id,
//       required this.userId,
//       required this.docName,
//       required this.userDeviceToken,
//       required this.docId,
//       required this.docLocation,
//       required this.appointmentType,
//       required this.isAppointmentTimeReached,
//       this.amount,
//       required this.petName,
//       required this.petBreed});
// }

// class AppointmentDetailPage extends StatefulWidget {
//   final String appointmentId;
//   const AppointmentDetailPage({Key? key, required this.appointmentId})
//       : super(key: key);

//   @override
//   State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
// }

// class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _timeController = TextEditingController();
//   TextEditingController _amountController = TextEditingController();

//   BookingRequestData? bookingRequestData;

//   @override
//   void initState() {
//     super.initState();
//     fetchAppointmentDetails();
//   }

//   Future<void> fetchAppointmentDetails() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       final currentUserId = currentUser.uid;
//       final usersCollection = FirebaseFirestore.instance.collection('users');
//       final appointmentsCollection =
//           FirebaseFirestore.instance.collection('appointments');

//       final userDocIds = await getDocIds(usersCollection);

//       for (var userDocId in userDocIds) {
//         final pendingDocs = await appointmentsCollection
//             .doc(userDocId)
//             .collection('HomeAndClinic')
//             .where('userId', isEqualTo: currentUserId)
//             .where('id', isEqualTo: widget.appointmentId)
//             .get();

//         for (var pendingDoc in pendingDocs.docs) {
//           final appointmentStatus = pendingDoc['appointmentStatus'];
//           if (appointmentStatus != 'Approved' &&
//               appointmentStatus != 'Rejected') {
//             setState(() {
//               bookingRequestData = BookingRequestData(
//                 profileImageUrl: 'assets/images/homedelivery.png',
//                 name: pendingDoc['patientName'],
//                 patientAddress: pendingDoc['patientHomeAddress'],
//                 date: pendingDoc['date'],
//                 time: pendingDoc['time'],
//                 id: pendingDoc['id'],
//                 userId: pendingDoc['userId'],
//                 docName: pendingDoc['docName'],
//                 userDeviceToken: pendingDoc['userDeviceToken'],
//                 docId: pendingDoc['docId'],
//                 docLocation: pendingDoc['doclocation'],
//                 appointmentType: pendingDoc['type'],
//                 isAppointmentTimeReached:
//                     pendingDoc['isAppointmentTimeReached'],
//                 amount: pendingDoc['amount'],
//                 petName: pendingDoc['petName'],
//                 petBreed: pendingDoc['petBreed'],
//               );
//             });
//           }
//         }
//       }
//     }
//   }

//   Future<List<String>> getDocIds(CollectionReference collection) async {
//     try {
//       final snapshot = await collection.get();
//       return snapshot.docs.map((doc) => doc.id).toList();
//     } catch (error) {
//       print('Error getting document IDs: $error');
//       return [];
//     }
//   }

//   Future<void> updateAppointment(String userId, String appointmentId,
//       String time, String date, String amount, BuildContext context) async {
//     final appointmentsCollection =
//         FirebaseFirestore.instance.collection('appointments');

//     try {
//       await appointmentsCollection
//           .doc(userId)
//           .collection('HomeAndClinic')
//           .doc(appointmentId)
//           .update({
//         'amount': amount,
//         'date': date,
//         'time': time,
//       }).then((value) {
//         setState(() {});
//       });
//       Navigator.pop(context);
//       final snackBar = SnackBar(
//         content: Text('Appointment Updated'),
//         duration: Duration(seconds: 2),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } catch (error) {
//       final snackBar = SnackBar(
//         content: Text('Failed to update appointment: $error'),
//         duration: Duration(seconds: 2),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _dateController.text = bookingRequestData?.date ?? '';
//     _timeController.text = bookingRequestData?.time ?? '';
//     _amountController.text = bookingRequestData?.amount ?? '';

//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(color: Colors.white),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         title: Text(
//           'Details',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 12.0, left: 10, right: 10),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildDetailRow('Name', bookingRequestData?.name ?? ''),
//                   _buildDivider(),

//                   _buildDetailRow(
//                       'Location', bookingRequestData?.patientAddress ?? ''),
//                   _buildDetailRow(
//                       'Doctor Name', bookingRequestData?.docName ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow(
//                       'Doctor Location', bookingRequestData?.docLocation ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow('Appointment Type',
//                       bookingRequestData?.appointmentType ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow('Date', bookingRequestData?.date ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow('Time', bookingRequestData?.time ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow('Amount', bookingRequestData?.amount ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow(
//                       'Pet Name', bookingRequestData?.petName ?? ''),
//                   _buildDivider(),
//                   _buildDetailRow(
//                       'Pet Breed', bookingRequestData?.petBreed ?? ''),
//                   // _buildEditableDetailRow('Date', _dateController),
//                   // _buildDivider(),
//                   // _buildEditableDetailRow('Time', _timeController),
//                   // _buildDivider(),
//                   // _buildEditableDetailRow('Amount', _amountController),
//                   _buildDivider(),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     ElevatedButton(
//                   //       style: ButtonStyle(
//                   //         shape:
//                   //             MaterialStateProperty.all(RoundedRectangleBorder(
//                   //           borderRadius: BorderRadius.circular(10),
//                   //         )),
//                   //         backgroundColor:
//                   //             MaterialStateProperty.all(Colors.blue),
//                   //       ),
//                   //       onPressed: () async {
//                   //         final newDate = _dateController.text.isNotEmpty
//                   //             ? _dateController.text
//                   //             : bookingRequestData?.date ?? '';
//                   //         final newTime = _timeController.text.isNotEmpty
//                   //             ? _timeController.text
//                   //             : bookingRequestData?.time ?? '';
//                   //         final newAmount = _amountController.text.isNotEmpty
//                   //             ? _amountController.text
//                   //             : bookingRequestData?.amount ?? '';

//                   //         await updateAppointment(
//                   //           bookingRequestData?.userId ?? '',
//                   //           bookingRequestData?.id ?? '',
//                   //           newTime,
//                   //           newDate,
//                   //           newAmount!,
//                   //           context,
//                   //         );

//                   //         setState(() {});
//                   //       },
//                   //       child: Text(
//                   //         "Update Appointment",
//                   //         style: TextStyle(color: Colors.white),
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                   // _buildDivider(),
//                 ],
//               ),
//             ),
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

//   Widget _buildEditableDetailRow(
//       String label, TextEditingController controller) {
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
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
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
