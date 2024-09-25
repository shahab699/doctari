// import 'package:appointment_app/chat/chat_page.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:appointment_app/chat/chat_service.dart'; // Import your ChatService
// import 'package:appointment_app/chat/chat_model.dart'; // Import your Message model

// class ConversationListPage extends StatefulWidget {
//   @override
//   _ConversationListPageState createState() => _ConversationListPageState();
// }

// class _ConversationListPageState extends State<ConversationListPage> {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _conversationStream;

//   @override
//   void initState() {
//     super.initState();
//     print('Initializing conversation list page...');
//     _conversationStream =
//         _chatService.getRecentConversations(_firebaseAuth.currentUser!.uid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Building conversation list page...');
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Conversations',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<List<Message>>(
//         stream: _conversationStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print('Waiting for conversation data...');
//             return Center(
//                 child: CircularProgressIndicator(
//               color: Colors.blue,
//             ));
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
//                 // Determine the ID of the other user in the conversation
//                 String otherUserId =
//                     _firebaseAuth.currentUser!.uid == conversation.senderId
//                         ? conversation.receiverId
//                         : conversation.senderId;
//                 return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('doctors')
//                       .doc(otherUserId)
//                       .get(),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return ListTile(
//                         title: Text('Loading...'),
//                       );
//                     }
//                     if (userSnapshot.hasError) {
//                       return Card(
//                         elevation: 1,
//                         child: ListTile(
//                           title: Text('Error loading user'),
//                         ),
//                       );
//                     }
//                     if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                       return ListTile(
//                         title: Text('Unknown User'),
//                       );
//                     }
//                     final userData = userSnapshot.data!;
//                     final userName = userData['title'];
//                     return ListTile(
//                       leading: Icon(
//                         Icons.account_circle,
//                         size: 50,
//                       ),
//                       title: Text(
//                         userName,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                       subtitle: Text(conversation.message),
//                       onTap: () {
//                         // Navigate to chat screen with conversation details
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatPage(
//                               receiverUserId: otherUserId,
//                               receiverUserEmail: userName,
//                             ),
//                           ),
//                         );
//                       },
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

import 'dart:async';
import 'package:doctari/chat/chat_model.dart';
import 'package:doctari/chat/chat_page.dart';
import 'package:doctari/chat/chat_service.dart';
import 'package:doctari/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConversationListPage extends StatefulWidget {
  final int currentUserId;
  const ConversationListPage({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);
  @override
  _ConversationListPageState createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  late Stream<List<Message>> _conversationStream;

  //check active status

  // Function to update isPatientActive status to true when patient opens chat screen
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

// Function to update isPatientActive status to false when patient closes chat screen
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
    print('Initializing conversation list page...');
    updateIsPatientActiveTrue(widget.currentUserId.toString());
    _conversationStream =
        _chatService.getRecentConversations(widget.currentUserId.toString());
  }

  @override
  void dispose() {
    // Call updateIsPatientActiveFalse with the appropriate chatRoomId
    print('Leaving conversation list page...');
    updateIsPatientActiveFalse(widget.currentUserId.toString());
    super.dispose();
  }

  Future<void> markMessagesAsRead(String userId, String conversationId) async {
    try {
      // Query for messages within the specified conversation where doctorIsRead is false
      QuerySnapshot messageSnapshot = await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .where('patientIsRead', isEqualTo: false)
          .get();

      // Loop through each message document and update doctorIsRead to true
      for (DocumentSnapshot messageDoc in messageSnapshot.docs) {
        await messageDoc.reference.update({'patientIsRead': true});
      }

      print('Marked messages as read for conversation: $conversationId');
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  int? notificationCount;

  @override
  Widget build(BuildContext context) {
    print('Building conversation list page...');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          '${AppLocalizations.of(context)!.conversationConversationListPatientSC}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      //   title: Text(
      //     '${AppLocalizations.of(context)!.conversationConversationListPatientSC}',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: StreamBuilder<List<Message>>(
        stream: _conversationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting for conversation data...');
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasError) {
            print('Error retrieving conversation data: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No conversation data available.');
            return Center(
                child: Text(
                    '${AppLocalizations.of(context)!.noConversationsFoundConversationListSC}.'));
          } else {
            final conversations = snapshot.data!;
            print(
                'Building conversation list with ${conversations.length} conversations.');
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                String otherUserId =
                    widget.currentUserId.toString() == conversation.senderId
                        ? conversation.receiverId
                        : conversation.senderId;
                String? conversationId = conversation.chatId;
                List<String> parts = conversationId!.split('_');

                String thirdId = '';
                for (String id in parts) {
                  if (id != widget.currentUserId.toString() &&
                      id != otherUserId) {
                    thirdId = id;
                    break;
                  }
                }

                print("the 3rd id is: ${thirdId}");

                return
                    // FutureBuilder<DocumentSnapshot>(
                    //   future: FirebaseFirestore.instance
                    //       .collection('conversations')
                    //       .doc(conversationId)
                    //       .get(),
                    //   builder: (context, userSnapshot) {
                    //     if (userSnapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return SizedBox(); // Use SizedBox instead of Container
                    //     }
                    //     if (userSnapshot.hasError) {
                    //       return Card(
                    //         elevation: 1,
                    //         color: Color(0xfff6f6f6f6),
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: ListTile(
                    //           title: Text('Error loading user'),
                    //         ),
                    //       );
                    //     }
                    //     if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    //       return ListTile(
                    //         title: Text('Unknown User'),
                    //       );
                    //     }
                    //     final userData = userSnapshot.data!;
                    //     final userName = userData['patientName'];
                    //     return Card(
                    //       child: ListTile(
                    //         leading: Icon(
                    //           Icons.account_circle,
                    //           size: 40,
                    //         ),
                    //         title: Text(
                    //           userName,
                    //           maxLines: 2,
                    //           style: TextStyle(
                    //               fontSize: 18, fontWeight: FontWeight.w500),
                    //         ),
                    //         trailing: StreamBuilder<QuerySnapshot>(
                    //           stream: FirebaseFirestore.instance
                    //               .collection('conversations')
                    //               .doc(conversationId)
                    //               .collection('messages')
                    //               .where('patientIsRead', isEqualTo: false)
                    //               .snapshots(),
                    //           builder: (BuildContext context,
                    //               AsyncSnapshot<QuerySnapshot> snapshot) {
                    //             if (snapshot.connectionState ==
                    //                 ConnectionState.waiting) {
                    //               return SizedBox(); // Use SizedBox instead of Container
                    //             }
                    //             if (snapshot.hasError) {
                    //               return Text('Error: ${snapshot.error}');
                    //             }
                    //             int notificationCount = snapshot.data!.docs.length;

                    //             return notificationCount == 0
                    //                 ? SizedBox()
                    //                 : Container(
                    //                     width: 22,
                    //                     height: 22,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.red,
                    //                       borderRadius: BorderRadius.circular(10),
                    //                     ),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "$notificationCount",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   );
                    //           },
                    //         ),
                    //         onTap: () {
                    //           markMessagesAsRead(
                    //               widget.currentUserId.toString(), conversationId!);
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => ChatPage(
                    //                 receiverUserId: otherUserId,
                    //                 receiverUserName: userName,
                    //                 currentUserId: widget.currentUserId.toString(),
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // );
                    FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('conversations')
                      .where('participants',
                          arrayContains: widget.currentUserId.toString())
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox(); // Use SizedBox instead of Container
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
                    final userName = userData?['patientName'] as String?;
                    final myName = userData?['doctorName'] as String?;

                    if (userName == null) {
                      // Handle the case where 'patientName' is null
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
                              return SizedBox(); // Use SizedBox instead of Container
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
                              widget.currentUserId.toString(), conversationId!);
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
