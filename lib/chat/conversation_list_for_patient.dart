import 'dart:async';
import 'dart:io'; // Import for File handling
import 'package:doctari/chat/chat_model.dart';
import 'package:doctari/chat/chat_page.dart';
import 'package:doctari/chat/chat_service.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:file_picker/file_picker.dart'; // For file picking

class ConversationListPageForPatient extends StatefulWidget {
  final int currentUserId;
  const ConversationListPageForPatient({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ConversationListPageForPatientState createState() =>
      _ConversationListPageForPatientState();
}

class _ConversationListPageForPatientState
    extends State<ConversationListPageForPatient> {
  final ChatService _chatService = ChatService();
  late Stream<List<Message>> _conversationStream;

  Future<void> updateIsPatientActiveTrue(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("conversations")
          .where('participants', arrayContains: userId)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.update({'isPatientActive': true});
      }
    } catch (error) {
      print('Failed to update isPatientActive status to true: $error');
      throw error;
    }
  }

  Future<void> updateIsPatientActiveFalse(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("conversations")
          .where('participants', arrayContains: userId)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.update({'isPatientActive': false});
      }
    } catch (error) {
      print('Failed to update isPatientActive status to false: $error');
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    updateIsPatientActiveTrue(widget.currentUserId.toString());
    _conversationStream =
        _chatService.getRecentConversations(widget.currentUserId.toString());
  }

  @override
  void dispose() {
    updateIsPatientActiveFalse(widget.currentUserId.toString());
    super.dispose();
  }

  Future<void> markMessagesAsRead(String userId, String conversationId) async {
    try {
      QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .where('patientIsRead', isEqualTo: false)
          .get();

      for (DocumentSnapshot messageDoc in messageSnapshot.docs) {
        await messageDoc.reference.update({'patientIsRead': true});
      }

      print('Marked messages as read for conversation: $conversationId');
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          '${AppLocalizations.of(context)!.conversationConversationListPatientSC}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<Message>>(
        stream: _conversationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No conversations found.'));
          } else {
            final conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                String otherUserId =
                    widget.currentUserId.toString() == conversation.senderId
                        ? conversation.receiverId
                        : conversation.senderId;
                String? conversationId = conversation.chatId;

                // Check if conversationId is null or empty
                if (conversationId == null || conversationId.isEmpty) {
                  return SizedBox.shrink(); // Skip rendering for this item
                }

                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('conversations')
                      .where('participants',
                          arrayContains: widget.currentUserId.toString())
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox();
                    }
                    if (userSnapshot.hasError) {
                      return Card(
                        elevation: 1,
                        color: Color(0xfff6f6f6f6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                              '${AppLocalizations.of(context)!.errorLoadingConversationListPatientSC}'),
                        ),
                      );
                    }
                    if (userSnapshot.data == null ||
                        userSnapshot.data!.docs.isEmpty) {
                      return ListTile(
                        title: Text(
                            '${AppLocalizations.of(context)!.unknownUserConversationListPatientSC}'),
                      );
                    }
                    final userData = userSnapshot.data!.docs.first.data()
                        as Map<String, dynamic>?;
                    final userName = userData?['doctorName'] as String?;
                    final myName = userData?['patientName'] as String?;

                    if (userName == null) {
                      return Text(
                          '${AppLocalizations.of(context)!.nameNullConversationListPatientSC}');
                    }

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: 40,
                        ),
                        title: Text(
                          userName,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        trailing: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('conversations')
                              .doc(conversationId)
                              .collection('messages')
                              .where('patientIsRead', isEqualTo: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            }
                            if (snapshot.hasError) {
                              return Text(
                                  '${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}');
                            }
                            int notificationCount = snapshot.data!.docs.length;

                            return notificationCount == 0
                                ? SizedBox()
                                : Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$notificationCount",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                        onTap: () {
                          markMessagesAsRead(
                              widget.currentUserId.toString(), conversationId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                receiverUserId: otherUserId,
                                receiverUserName: userName!,
                                currentUserId: widget.currentUserId.toString(),
                                currentUserName: myName,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}



// import 'dart:async';
// import 'dart:io'; // Import for File handling
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_page.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:doctari/theme/theme_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:image_picker/image_picker.dart'; // For image picking
// import 'package:file_picker/file_picker.dart'; // For file picking

// class ConversationListPageForPatient extends StatefulWidget {
//   final int currentUserId;
//   const ConversationListPageForPatient({
//     Key? key,
//     required this.currentUserId,
//   }) : super(key: key);

//   @override
//   _ConversationListPageForPatientState createState() =>
//       _ConversationListPageForPatientState();
// }

// class _ConversationListPageForPatientState
//     extends State<ConversationListPageForPatient> {
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _conversationStream;

//   Future<void> updateIsPatientActiveTrue(String userId) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("conversations")
//           .where('participants', arrayContains: userId)
//           .get();

//       for (DocumentSnapshot doc in querySnapshot.docs) {
//         await doc.reference.update({'isPatientActive': true});
//       }
//     } catch (error) {
//       print('Failed to update isPatientActive status to true: $error');
//       throw error;
//     }
//   }

//   Future<void> updateIsPatientActiveFalse(String userId) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("conversations")
//           .where('participants', arrayContains: userId)
//           .get();

//       for (DocumentSnapshot doc in querySnapshot.docs) {
//         await doc.reference.update({'isPatientActive': false});
//       }
//     } catch (error) {
//       print('Failed to update isPatientActive status to false: $error');
//       throw error;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     updateIsPatientActiveTrue(widget.currentUserId.toString());
//     _conversationStream =
//         _chatService.getRecentConversations(widget.currentUserId.toString());
//   }

//   @override
//   void dispose() {
//     updateIsPatientActiveFalse(widget.currentUserId.toString());
//     super.dispose();
//   }

//   Future<void> markMessagesAsRead(String userId, String conversationId) async {
//     try {
//       QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
//           .collection('conversations')
//           .doc(conversationId)
//           .collection('messages')
//           .where('patientIsRead', isEqualTo: false)
//           .get();

//       for (DocumentSnapshot messageDoc in messageSnapshot.docs) {
//         await messageDoc.reference.update({'patientIsRead': true});
//       }

//       print('Marked messages as read for conversation: $conversationId');
//     } catch (e) {
//       print('Error marking messages as read: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: theme.colorScheme.primary,
//         title: Text(
//           '${AppLocalizations.of(context)!.conversationConversationListPatientSC}',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<List<Message>>(
//         stream: _conversationStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Colors.blue,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No conversations found.'));
//           } else {
//             final conversations = snapshot.data!;
//             return ListView.builder(
//               itemCount: conversations.length,
//               itemBuilder: (context, index) {
//                 final conversation = conversations[index];
//                 String otherUserId =
//                     widget.currentUserId.toString() == conversation.senderId
//                         ? conversation.receiverId
//                         : conversation.senderId;
//                 String? conversationId = conversation.chatId;

//                 return FutureBuilder<QuerySnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('conversations')
//                       .where('participants',
//                           arrayContains: widget.currentUserId.toString())
//                       .get(),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return SizedBox();
//                     }
//                     if (userSnapshot.hasError) {
//                       return Card(
//                         elevation: 1,
//                         color: Color(0xfff6f6f6f6),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: ListTile(
//                           title: Text(
//                               '${AppLocalizations.of(context)!.errorLoadingConversationListPatientSC}'),
//                         ),
//                       );
//                     }
//                     if (userSnapshot.data == null ||
//                         userSnapshot.data!.docs.isEmpty) {
//                       return ListTile(
//                         title: Text(
//                             '${AppLocalizations.of(context)!.unknownUserConversationListPatientSC}'),
//                       );
//                     }
//                     final userData = userSnapshot.data!.docs.first.data()
//                         as Map<String, dynamic>?;
//                     final userName = userData?['doctorName'] as String?;
//                     final myName = userData?['patientName'] as String?;

//                     if (userName == null) {
//                       return Text(
//                           '${AppLocalizations.of(context)!.nameNullConversationListPatientSC}');
//                     }

//                     return Card(
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.account_circle,
//                           size: 40,
//                         ),
//                         title: Text(
//                           userName,
//                           maxLines: 2,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                         trailing: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('conversations')
//                               .doc(conversationId)
//                               .collection('messages')
//                               .where('patientIsRead', isEqualTo: false)
//                               .snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return SizedBox();
//                             }
//                             if (snapshot.hasError) {
//                               return Text(
//                                   '${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}');
//                             }
//                             int notificationCount = snapshot.data!.docs.length;

//                             return notificationCount == 0
//                                 ? SizedBox()
//                                 : Container(
//                                     width: 22,
//                                     height: 22,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "$notificationCount",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                           },
//                         ),
//                         onTap: () {
//                           markMessagesAsRead(
//                               widget.currentUserId.toString(), conversationId!);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChatPage(
//                                 receiverUserId: otherUserId,
//                                 receiverUserName: userName!,
//                                 currentUserId: widget.currentUserId.toString(),
//                                 currentUserName: myName,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }






//Last code when start to update data
// import 'dart:async';
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_page.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:doctari/theme/theme_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ConversationListPageForPatient extends StatefulWidget {
//   final int currentUserId;
//   const ConversationListPageForPatient({
//     Key? key,
//     required this.currentUserId,
//   }) : super(key: key);
//   @override
//   _ConversationListPageForPatientState createState() =>
//       _ConversationListPageForPatientState();
// }

// class _ConversationListPageForPatientState
//     extends State<ConversationListPageForPatient> {
//   // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _conversationStream;

//   //check active status

//   // Function to update isPatientActive status to true when patient opens chat screen
//   Future<void> updateIsPatientActiveTrue(String userId) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("conversations")
//           .where('participants', arrayContains: userId)
//           .get();

//       for (DocumentSnapshot doc in querySnapshot.docs) {
//         await doc.reference.update({'isPatientActive': true});
//       }
//     } catch (error) {
//       print('Failed to update isPatientActive status to true: $error');
//       throw error;
//     }
//   }

// // Function to update isPatientActive status to false when patient closes chat screen
//   Future<void> updateIsPatientActiveFalse(String userId) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("conversations")
//           .where('participants', arrayContains: userId)
//           .get();

//       for (DocumentSnapshot doc in querySnapshot.docs) {
//         await doc.reference.update({'isPatientActive': false});
//       }
//     } catch (error) {
//       print('Failed to update isPatientActive status to false: $error');
//       throw error;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     print('Initializing conversation list page...');
//     updateIsPatientActiveTrue(widget.currentUserId.toString());
//     _conversationStream =
//         _chatService.getRecentConversations(widget.currentUserId.toString());
//   }

//   @override
//   void dispose() {
//     // Call updateIsPatientActiveFalse with the appropriate chatRoomId
//     print('Leaving conversation list page...');
//     updateIsPatientActiveFalse(widget.currentUserId.toString());
//     super.dispose();
//   }

//   Future<void> markMessagesAsRead(String userId, String conversationId) async {
//     try {
//       // Query for messages within the specified conversation where doctorIsRead is false
//       QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
//           .collection('conversations')
//           .doc(conversationId)
//           .collection('messages')
//           .where('patientIsRead', isEqualTo: false)
//           .get();

//       // Loop through each message document and update doctorIsRead to true
//       for (DocumentSnapshot messageDoc in messageSnapshot.docs) {
//         await messageDoc.reference.update({'patientIsRead': true});
//       }

//       print('Marked messages as read for conversation: $conversationId');
//     } catch (e) {
//       print('Error marking messages as read: $e');
//     }
//   }

//   int? notificationCount;

//   @override
//   Widget build(BuildContext context) {
//     print('Building conversation list page...');
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: theme.colorScheme.primary,
//         title: Text(
//           '${AppLocalizations.of(context)!.conversationConversationListPatientSC}',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<List<Message>>(
//         stream: _conversationStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print('Waiting for conversation data...');
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Colors.blue,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             print('Error retrieving conversation data: ${snapshot.error}');
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             print('No conversation data available.');
//             return Center(child: Text('No conversations found.'));
//           } else {
//             final conversations = snapshot.data!;
//             print(
//                 'Building conversation list with ${conversations.length} conversations.');
//             return ListView.builder(
//               itemCount: conversations.length,
//               itemBuilder: (context, index) {
//                 final conversation = conversations[index];
//                 String otherUserId =
//                     widget.currentUserId.toString() == conversation.senderId
//                         ? conversation.receiverId
//                         : conversation.senderId;
//                 String? conversationId = conversation.chatId;
//                 List<String> parts = conversationId!.split('_');

//                 String thirdId = '';
//                 for (String id in parts) {
//                   if (id != widget.currentUserId.toString() &&
//                       id != otherUserId) {
//                     thirdId = id;
//                     break;
//                   }
//                 }

//                 print("the 3rd id is: ${thirdId}");

//                 return
//                     // FutureBuilder<DocumentSnapshot>(
//                     //   future: FirebaseFirestore.instance
//                     //       .collection('conversations')
//                     //       .doc(conversationId)
//                     //       .get(),
//                     //   builder: (context, userSnapshot) {
//                     //     if (userSnapshot.connectionState ==
//                     //         ConnectionState.waiting) {
//                     //       return SizedBox(); // Use SizedBox instead of Container
//                     //     }
//                     //     if (userSnapshot.hasError) {
//                     //       return Card(
//                     //         elevation: 1,
//                     //         color: Color(0xfff6f6f6f6),
//                     //         shape: RoundedRectangleBorder(
//                     //             borderRadius: BorderRadius.circular(10)),
//                     //         child: ListTile(
//                     //           title: Text('Error loading user'),
//                     //         ),
//                     //       );
//                     //     }
//                     //     if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                     //       return ListTile(
//                     //         title: Text('Unknown User'),
//                     //       );
//                     //     }
//                     //     final userData = userSnapshot.data!;
//                     //     final userName = userData['patientName'];
//                     //     return Card(
//                     //       child: ListTile(
//                     //         leading: Icon(
//                     //           Icons.account_circle,
//                     //           size: 40,
//                     //         ),
//                     //         title: Text(
//                     //           userName,
//                     //           maxLines: 2,
//                     //           style: TextStyle(
//                     //               fontSize: 18, fontWeight: FontWeight.w500),
//                     //         ),
//                     //         trailing: StreamBuilder<QuerySnapshot>(
//                     //           stream: FirebaseFirestore.instance
//                     //               .collection('conversations')
//                     //               .doc(conversationId)
//                     //               .collection('messages')
//                     //               .where('patientIsRead', isEqualTo: false)
//                     //               .snapshots(),
//                     //           builder: (BuildContext context,
//                     //               AsyncSnapshot<QuerySnapshot> snapshot) {
//                     //             if (snapshot.connectionState ==
//                     //                 ConnectionState.waiting) {
//                     //               return SizedBox(); // Use SizedBox instead of Container
//                     //             }
//                     //             if (snapshot.hasError) {
//                     //               return Text('Error: ${snapshot.error}');
//                     //             }
//                     //             int notificationCount = snapshot.data!.docs.length;

//                     //             return notificationCount == 0
//                     //                 ? SizedBox()
//                     //                 : Container(
//                     //                     width: 22,
//                     //                     height: 22,
//                     //                     decoration: BoxDecoration(
//                     //                       color: Colors.red,
//                     //                       borderRadius: BorderRadius.circular(10),
//                     //                     ),
//                     //                     child: Center(
//                     //                       child: Text(
//                     //                         "$notificationCount",
//                     //                         style: TextStyle(
//                     //                           color: Colors.white,
//                     //                           fontWeight: FontWeight.bold,
//                     //                         ),
//                     //                       ),
//                     //                     ),
//                     //                   );
//                     //           },
//                     //         ),
//                     //         onTap: () {
//                     //           markMessagesAsRead(
//                     //               widget.currentUserId.toString(), conversationId!);
//                     //           Navigator.push(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //               builder: (context) => ChatPage(
//                     //                 receiverUserId: otherUserId,
//                     //                 receiverUserName: userName,
//                     //                 currentUserId: widget.currentUserId.toString(),
//                     //               ),
//                     //             ),
//                     //           );
//                     //         },
//                     //       ),
//                     //     );
//                     //   },
//                     // );
//                     FutureBuilder<QuerySnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('conversations')
//                       .where('participants',
//                           arrayContains: widget.currentUserId.toString())
//                       .get(),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return SizedBox(); // Use SizedBox instead of Container
//                     }
//                     if (userSnapshot.hasError) {
//                       return Card(
//                         elevation: 1,
//                         color: Color(0xfff6f6f6f6),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: ListTile(
//                           title: Text(
//                               '${AppLocalizations.of(context)!.errorLoadingConversationListPatientSC}'),
//                         ),
//                       );
//                     }
//                     if (userSnapshot.data == null ||
//                         userSnapshot.data!.docs.isEmpty) {
//                       return ListTile(
//                         title: Text(
//                             '${AppLocalizations.of(context)!.unknownUserConversationListPatientSC}'),
//                       );
//                     }
//                     final userData = userSnapshot.data!.docs.first.data()
//                         as Map<String, dynamic>?;
//                     final userName = userData?['doctorName'] as String?;
//                     final myName = userData?['patientName'] as String?;

//                     if (userName == null) {
//                       // Handle the case where 'patientName' is null
//                       return Text(
//                           '${AppLocalizations.of(context)!.nameNullConversationListPatientSC}');
//                     }

//                     return Card(
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.account_circle,
//                           size: 40,
//                         ),
//                         title: Text(
//                           userName,
//                           maxLines: 2,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                         trailing: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('conversations')
//                               .doc(conversationId)
//                               .collection('messages')
//                               .where('patientIsRead', isEqualTo: false)
//                               .snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return SizedBox(); // Use SizedBox instead of Container
//                             }
//                             if (snapshot.hasError) {
//                               return Text(
//                                   '${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}');
//                             }
//                             int notificationCount = snapshot.data!.docs.length;

//                             return notificationCount == 0
//                                 ? SizedBox()
//                                 : Container(
//                                     width: 22,
//                                     height: 22,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "$notificationCount",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                           },
//                         ),
//                         onTap: () {
//                           markMessagesAsRead(
//                               widget.currentUserId.toString(), conversationId!);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChatPage(
//                                 receiverUserId: otherUserId,
//                                 receiverUserName: userName!,
//                                 currentUserId: widget.currentUserId.toString(),
//                                 currentUserName: myName,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
