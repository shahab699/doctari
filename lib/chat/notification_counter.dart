// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class NotificationCounter extends StatefulWidget {
//   @override
//   _NotificationCounterState createState() => _NotificationCounterState();
// }

// class _NotificationCounterState extends State<NotificationCounter> {
//   late NotificationCounterLogic _logic;

//   @override
//   void initState() {
//     super.initState();
//     _logic = NotificationCounterLogic();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<int>(
//       stream: _logic.notificationCountStream,
//       initialData: _logic.notificationCount,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Container(); // Return a loading indicator or an empty container while waiting for data
//         }
//         return Container(
//           width: 22,
//           height: 22,
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               "${snapshot.data}",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class NotificationCounterLogic {
//   late StreamController<int> _notificationCountController;
//   int _notificationCount = 0;
//   late List<StreamSubscription<QuerySnapshot>> _subscriptions;

//   Stream<int> get notificationCountStream =>
//       _notificationCountController.stream;

//   int get notificationCount => _notificationCount;

//   NotificationCounterLogic() {
//     _notificationCountController = StreamController<int>.broadcast();
//     _subscriptions = [];

//     FirebaseFirestore.instance
//         .collection('conversations')
//         .where('participants',
//             arrayContains: FirebaseAuth.instance.currentUser!.uid)
//         .snapshots()
//         .listen((snapshot) {
//       snapshot.docs.forEach((conversationDoc) {
//         String conversationId = conversationDoc.id;

//         StreamSubscription<QuerySnapshot> subscription = FirebaseFirestore
//             .instance
//             .collection('conversations')
//             .doc(conversationId)
//             .collection('messages')
//             .where('patientIsRead', isEqualTo: false)
//             .snapshots()
//             .listen((messageSnapshot) {
//           int newCount = messageSnapshot.size;
//           _notificationCount += newCount;
//           _notificationCountController.add(_notificationCount);
//           print(
//               'New message count for conversation $conversationId: $_notificationCount');
//         });

//         _subscriptions.add(subscription);
//       });
//     });
//   }

//   void dispose() {
//     _notificationCountController.close();
//     _subscriptions.forEach((subscription) {
//       subscription.cancel();
//     });
//   }
// }
