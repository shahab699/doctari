import 'package:doctari/sessionManager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
class ChatApp extends StatefulWidget {
  final int currentUserId;
  const ChatApp({
    required this.currentUserId,
    Key? key}) : super(key: key);

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  @override
  Widget build(BuildContext context) {
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    int usersId = int.parse(userId!);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Conversations')),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: userId,
                  conversationType: conversation.type,
                );
              },
            ));
          },
        ),
      ),
    );

  }
}