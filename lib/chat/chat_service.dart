//here latest updated code before delete message functionality
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctari/chat/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //first send message function
  Future<void> FirstSendMessage(
    String receiverId,
    String currentUserId,
    String receiverName,
    String currentUserName,
  ) async {
    print("FirstSendMessage function called with receiverId: $receiverId");
    try {
      List<String> ids = [
        currentUserId,
        receiverId,
      ];
      ids.sort();
      String chatRoomId = ids.join("_");

      // Check if the chat room already exists
      final chatRoomDoc =
          await _firestore.collection("conversations").doc(chatRoomId).get();
      if (chatRoomDoc.exists) {
        print(
            "Chat room already exists between users: $currentUserId and $receiverId");
        return; // Exit the function without creating a new chat room
      }

      // If the chat room doesn't exist, create it
      await _firestore.collection("conversations").doc(chatRoomId).set({
        'participants': FieldValue.arrayUnion(ids),
        'doctorIsRead': true,
        'patientIsRead': false,
        'isDoctorActive': true,
        'isPatientActive': false,
        'doctorName': currentUserName,
        'patientName': receiverName,
      }, SetOptions(merge: true));

      print("Chat room created between users: $currentUserId and $receiverId");
    } catch (error) {
      print('Failed to send message: $error');
      throw error;
    }
  }

  //first send message function
  Future<void> FirstSendMessageToDoctor(
    String receiverId,
    String currentUserId,
    String receiverName,
    String currentUserName,
  ) async {
    print("FirstSendMessage function called with receiverId: $receiverId");
    try {
      List<String> ids = [
        currentUserId,
        receiverId,
      ];
      ids.sort();
      String chatRoomId = ids.join("_");

      // Check if the chat room already exists
      final chatRoomDoc =
          await _firestore.collection("conversations").doc(chatRoomId).get();
      if (chatRoomDoc.exists) {
        print(
            "Chat room already exists between users: $currentUserId and $receiverId");
        return; // Exit the function without creating a new chat room
      }

      // If the chat room doesn't exist, create it
      await _firestore.collection("conversations").doc(chatRoomId).set({
        'participants': FieldValue.arrayUnion(ids),
        'doctorIsRead': false,
        'patientIsRead': true,
        'isDoctorActive': false,
        'isPatientActive': true,
        'doctorName': receiverName,
        'patientName': currentUserName,
      }, SetOptions(merge: true));

      print("Chat room created between users: $currentUserId and $receiverId");
    } catch (error) {
      print('Failed to send message: $error');
      throw error;
    }
  }

  Future<void> sendMessage(
    String receiverId,
    String message,
    MessageType messageType,
    String currentUserId,
  ) async {
    try {
      final Timestamp timestamp = Timestamp.now();

      List<String> ids = [
        currentUserId,
        receiverId,
      ];
      ids.sort();
      String chatRoomId = ids.join("_");

      // Use a transaction to read and update the patientIsRead field
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction
            .get(_firestore.collection("conversations").doc(chatRoomId));
        bool isDoctorActive = snapshot.get('isDoctorActive') ?? false;

        // Update patientIsRead field based on isPatientActive value
        bool DoctorIsRead = isDoctorActive;
        Message newMessage = Message(
            senderId: currentUserId,
            senderEmail: 'senderName',
            receiverId: receiverId,
            chatId: chatRoomId,
            timestamp: timestamp,
            message: message,
            messageType: messageType, // Set messageType
            doctorIsRead: DoctorIsRead,
            patientIsRead: true);

        // Add both user IDs to the conversation document if not already added
        transaction.set(
          _firestore.collection("conversations").doc(chatRoomId),
          {
            'participants': FieldValue.arrayUnion(ids),
            'doctorIsRead': DoctorIsRead,
            'patientIsRead': true,
          },
          SetOptions(merge: true),
        );

        // Add message to the conversation
        transaction.set(
          _firestore
              .collection("conversations")
              .doc(chatRoomId)
              .collection("messages")
              .doc(), // Using .doc() to auto-generate a unique document ID
          newMessage.toMap(DoctorIsRead),
        );
      });
    } catch (error) {
      print('Failed to send message: $error');
      throw error;
    }
  }

  // Upload file to Firebase Storage
  Future<String> uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _firebaseStorage.ref().child('chat_files/$fileName');
      UploadTask uploadTask = ref.putFile(file);

      // Log initial status
      print('Starting upload...');

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Upload progress: $progress%');
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String fileUrl = await taskSnapshot.ref.getDownloadURL();
      print('File URL: $fileUrl');
      return fileUrl;
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }

  // Future<String> uploadFile(File file) async {
  //   try {
  //     // Create a unique filename for the file
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     // Define the storage path
  //     Reference ref = _firebaseStorage.ref().child('chat_files/$fileName');
  //     // Upload the file
  //     UploadTask uploadTask = ref.putFile(file);
  //     // Wait for the upload to complete
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     print('Upload Task: $uploadTask');
  //     // Get the download URL
  //     String fileUrl = await taskSnapshot.ref.getDownloadURL();
  //     //print('Image Url: $getDownloadURL');
  //     print("file url: $fileUrl");
  //     return fileUrl;
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //     throw e;
  //   }
  // }

  Stream<List<Message>> getMessages(String currentUserId, String otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("conversations")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Message.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Stream<List<Message>> getMessages(
  //   String currentUserId,
  //   String otherUserId,
  // ) {
  //   List<String> ids = [
  //     currentUserId,
  //     otherUserId,
  //   ];
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //   return _firestore
  //       .collection("conversations")
  //       .doc(chatRoomId)
  //       .collection("messages")
  //       .orderBy("timestamp", descending: false)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Message.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // Stream<List<Message>> getMessages(
  //   String CurrentuserId,
  //   String otherUserId,
  // ) {
  //   List<String> ids = [
  //     CurrentuserId,
  //     otherUserId,
  //   ];
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //   return _firestore
  //       .collection("conversations")
  //       .doc(chatRoomId)
  //       .collection("messages")
  //       .orderBy("timestamp", descending: false)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Message.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // send notifications
  // Future<void> sendNotification(String docId, String msg) async {
  //   // send notification.
  //   try {
  //     DocumentReference postsRef =
  //         await FirebaseFirestore.instance.collection('doctors').doc(docId);
  //     DocumentSnapshot postSnapshot = await postsRef.get();
  //     String? receiverDeviceToken = postSnapshot.get('deviceToken');

  //     // get current user name
  //     DocumentReference userRef = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(CurrentuserId);
  //     DocumentSnapshot userSnapshot = await userRef.get();
  //     String? username = userSnapshot.get('firstName');
  //     // String? deviceToken = await FirebaseMessaging.instance.getToken();
  //     Map<String, dynamic> data = {
  //       'to': receiverDeviceToken,
  //       'priority': 'high',
  //       'notification': {'title': username, 'body': msg}
  //     };
  //     if (receiverDeviceToken == null) {
  //       print('Failed to get device token');
  //       return;
  //     }
  //     http.Response response = await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       body: jsonEncode(data),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'key=AAAAkBuS2y0:APA91bH-ioiXPSX_y-L8nRcKA0zxJsvjwV0RDH6-dk8XKePBPsI1uFPmGX08V1FVM-zuEZeUT_TIqE0a6cSoxkOIRUFjIBI8OdsId3hK5sy04ko0ZiCK3VZbHPYk5p0Kqyro5b6UQV79',
  //       },
  //     );
  //     if (response.statusCode != 200) {
  //       print('Failed to send notification: ${response.body}');
  //       return;
  //     }
  //     print('Notification sent successfully');
  //   } catch (error) {
  //     print('Failed to send notification: $error');
  //   }
  // }

  // conversation list
  Stream<List<Message>> getRecentConversations(String userId) {
    print('Fetching recent conversations for user ID: $userId');
    return _firestore
        .collection("conversations")
        .where("participants", arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Message> conversations = [];

      for (var doc in snapshot.docs) {
        print('Processing conversation document: ${doc.id}');
        var messagesSnapshot = await doc.reference
            .collection("messages")
            .orderBy("timestamp", descending: true)
            .limit(1)
            .get();

        if (messagesSnapshot.docs.isNotEmpty) {
          var messageData =
              messagesSnapshot.docs.first.data() as Map<String, dynamic>;
          print('Processing message data: $messageData');

          // Construct a message object with relevant data
          MessageType messageType = MessageType.Regular;
          if (messageData.containsKey('messageType')) {
            messageType = MessageType.values[messageData['messageType']];
          }

          Message message = Message(
            senderId: messageData['senderId'],
            senderEmail: messageData['senderEmail'],
            receiverId: messageData['receiverId'],
            chatId: messageData['chatId'],
            message: messageData['message'],
            messageType: messageType,
            timestamp: messageData['timestamp'],
            //add here to check data load
            fileUrl: messageData['fileUrl'],
          );
          conversations.add(message);
          print('Added message to conversation list');
        }
      }

      print('Returning ${conversations.length} conversations');
      return conversations;
    });
  }

  // chat room

  // Future<void> createChatRoom(String appointmentId) async {
  //   try {
  //     final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //     final String currentUserName =
  //         FirebaseAuth.instance.currentUser!.email ?? 'Unknown';

  //     // Create a new chat room document
  //     DocumentReference chatRoomRef =
  //         FirebaseFirestore.instance.collection('conversations').doc();

  //     // Get the doctor's ID from the appointment
  //     DocumentSnapshot appointmentSnapshot = await FirebaseFirestore.instance
  //         .collection('appointments')
  //         .doc(currentUserId)
  //         .collection('HomeAndClinic')
  //         .doc(appointmentId)
  //         .get();

  //     String? doctorId = appointmentSnapshot.get('docId');
  //     String? doctorName = appointmentSnapshot.get('docName');

  //     // Set up participants
  //     List<String> participants = [currentUserId, doctorId!];
  //     participants.sort();
  //     String chatRoomId = participants.join('_');

  //     // Set initial message
  //     String initialMessage = 'Appointment created by $currentUserName.';

  //     // Create message object
  //     Message initialMessageObject = Message(
  //         senderId: currentUserId,
  //         senderEmail: currentUserName,
  //         message: initialMessage,
  //         messageType: MessageType.Regular,
  //         timestamp: Timestamp.now(),
  //         receiverId: doctorId);

  //     // Add message to the conversation
  //     await chatRoomRef.set({
  //       'participants': participants,
  //     });

  //     await chatRoomRef
  //         .collection('messages')
  //         .add(initialMessageObject.toMap(false));

  //     print('Chat room created successfully: $chatRoomId');
  //   } catch (error) {
  //     print('Error creating chat room: $error');
  //     throw error;
  //   }
  // }
}
