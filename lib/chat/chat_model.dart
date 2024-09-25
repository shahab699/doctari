// import 'package:cloud_firestore/cloud_firestore.dart';

// enum MessageType {
//   Regular,
//   Appointment,
//   Product,
//   Document,
//   Image,
// }

// extension MessageTypeExtension on MessageType {
//   static MessageType fromIndex(int index) {
//     return MessageType.values[index];
//   }

//   int get index => MessageType.values.indexOf(this);
// }

// class Message {
//   final String senderId;
//   final String senderEmail;
//   final String receiverId;
//   final String? chatId;
//   final String message;
//   final Timestamp timestamp; // Ensure timestamp is properly handled
//   final MessageType messageType;
//   final bool? doctorIsRead;
//   final bool? patientIsRead;
//   final String? fileUrl;

//   Message({
//     required this.senderId,
//     required this.senderEmail,
//     required this.receiverId,
//     this.chatId,
//     required this.message,
//     required this.timestamp,
//     required this.messageType,
//     this.doctorIsRead,
//     this.patientIsRead,
//     this.fileUrl,
//   });

//   // Factory constructor to create a Message object from a Map
//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       senderId: map['senderId'] as String,
//       senderEmail: map['senderEmail'] as String,
//       receiverId: map['receiverId'] as String,
//       chatId: map['chatId'] as String?,
//       message: map['message'] as String,
//       timestamp: map['timestamp'] as Timestamp,
//       messageType: MessageTypeExtension.fromIndex(map['messageType'] ?? 0),
//       doctorIsRead: map['doctorIsRead'] as bool? ?? false,
//       patientIsRead: map['patientIsRead'] as bool? ?? false,
//       fileUrl: map['fileUrl'] as String?,
//     );
//   }

//   // Convert the Message object to a Map
//   Map<String, dynamic> toMap(bool isDoctorActive) {
//     return {
//       "senderId": senderId,
//       "senderEmail": senderEmail,
//       "receiverId": receiverId,
//       "chatId": chatId ?? '', // Ensure chatId is never null
//       "message": message,
//       "timestamp": timestamp,
//       "messageType": messageType.index,
//       'doctorIsRead': isDoctorActive,
//       'patientIsRead': patientIsRead ?? false,
//       'fileUrl': fileUrl ?? '', // Provide default empty string if fileUrl is null
//     };
//   }
// }

//last update to show data in app
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  Regular,
  Appointment,
  Product,
  Document,
  Image,
}

extension MessageTypeExtension on MessageType {
  static MessageType fromIndex(int index) {
    return MessageType.values[index];
  }

  int get index => MessageType.values.indexOf(this);
}

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String? chatId;
  final String message;
  final Timestamp timestamp; // Ensure timestamp is properly handled
  final MessageType messageType;
  final bool? doctorIsRead;
  final bool? patientIsRead;
  final String? fileUrl;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    this.chatId,
    required this.message,
    required this.timestamp,
    required this.messageType,
    this.doctorIsRead,
    this.patientIsRead,
    this.fileUrl,
  });

  // Factory constructor to create a Message object from a Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      chatId: map['chatId'] as String?,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
      messageType: MessageTypeExtension.fromIndex(map['messageType'] ?? 0),
      doctorIsRead: map['doctorIsRead'] as bool? ?? false,
      patientIsRead: map['patientIsRead'] as bool? ?? false,
      fileUrl: map['fileUrl'] as String?,
    );
  }

  // Convert the Message object to a Map
  Map<String, dynamic> toMap(bool isDoctorActive) {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "chatId": chatId,
      "message": message,
      "timestamp": timestamp,
      "messageType": messageType.index,
      'doctorIsRead': isDoctorActive,
      'patientIsRead': patientIsRead ?? false,
      'fileUrl': fileUrl,
    };
  }
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// enum MessageType {
//   Regular,
//   Appointment,
//   Product,
//   Document,
//   Image,
// }

// extension MessageTypeExtension on MessageType {
//   static MessageType fromIndex(int index) {
//     return MessageType.values[index];
//   }

//   int get index => MessageType.values.indexOf(this);
// }

// class Message {
//   final String senderId;
//   final String senderEmail;
//   final String receiverId;
//   final String? chatId;
//   final String message;
//   final Timestamp timestamp;
//   final MessageType messageType; // Use MessageType enum directly
//   final bool? doctorIsRead;
//   final bool? patientIsRead;
//   final String? fileUrl;

//   Message({
//     required this.senderId,
//     required this.senderEmail,
//     required this.receiverId,
//     this.chatId,
//     required this.message,
//     required this.timestamp,
//     required this.messageType, // Initialize messageType in constructor
//     this.doctorIsRead,
//     this.patientIsRead,
//     this.fileUrl,
//   });

//   // Factory constructor to create a Message object from a Map
//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       senderId: map['senderId'],
//       senderEmail: map['senderEmail'],
//       receiverId: map['receiverId'],
//       chatId: map['chatId'],
//       message: map['message'],
//       timestamp: map['timestamp'],
//       messageType: MessageTypeExtension.fromIndex(map['messageType']),
//       doctorIsRead: map['doctorIsRead'],
//       patientIsRead: map['patientIsRead'],
//       fileUrl: map['fileUrl'],
//     );
//   }

//   // Convert the Message object to a Map
//   Map<String, dynamic> toMap(bool isDoctorActive) {
//     return {
//       "senderId": senderId,
//       "senderEmail": senderEmail,
//       "receiverId": receiverId,
//       "chatId": chatId,
//       "message": message,
//       "timestamp": timestamp,
//       "messageType": messageType.index, // Store messageType as an index
//       'doctorIsRead': isDoctorActive,
//       'patientIsRead': patientIsRead ?? false, // Use default value if null
//       'fileUrl': fileUrl,
//     };
//   }
// }






//old code before updated data
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// enum MessageType {
//   Regular,
//   Appointment,
//   Product, Document, Image,
// }

// extension MessageTypeExtension on MessageType {
//   static MessageType fromIndex(int index) {
//     switch (index) {
//       case 0:
//         return MessageType.Regular;
//       case 1:
//         return MessageType.Appointment;
//       case 2:
//         return MessageType.Product;
//       default:
//         throw ArgumentError('Invalid MessageType index: $index');
//     }
//   }
// }

// class Message {
//   final String senderId;
//   final String senderEmail;
//   final String receiverId;
//   final String? chatId;
//   final String message;
//   final Timestamp timestamp;
//   final dynamic messageType; // Add messageType field
//   final bool? doctorIsRead;
//   final bool? patientIsRead;
//   final String? fileUrl;

//   Message({
//     required this.senderId,
//     required this.senderEmail,
//     required this.receiverId,
//     this.chatId,
//     required this.message,
//     required this.timestamp,
//     required this.messageType, // Initialize messageType in constructor
//     this.doctorIsRead,
//     this.patientIsRead, 
//     this.fileUrl,
//   });

//   // Factory constructor to create a Message object from a Map
//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       senderId: map['senderId'],
//       senderEmail: map['senderEmail'],
//       receiverId: map['receiverId'],
//       chatId: map['chatId'],
//       message: map['message'],
//       timestamp: map['timestamp'],
//       messageType: MessageType
//           .values[map['messageType']], // Convert index to MessageType enum
//       // doctorIsRead: false,
//       // patientIsRead: true,
//     );
//   }

//   // Convert the Message object to a Map
//   Map<String, dynamic> toMap(bool isDoctorActive) {
//     return {
//       "senderId": senderId,
//       "senderEmail": senderEmail,
//       "receiverId": receiverId,
//       "chatId": chatId,
//       "message": message,
//       "timestamp": timestamp,
//       "messageType": messageType.index, // Store messageType as an index
//       'doctorIsRead': isDoctorActive,
//       'patientIsRead': true,
//     };
//   }
// }
