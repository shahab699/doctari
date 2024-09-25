import 'dart:convert';
import 'package:doctari/chat/chat_bubble.dart';
import 'package:doctari/chat/chat_model.dart';
import 'package:doctari/chat/chat_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPageForPatient extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserId;
  final String? currentUserId;
  final String? currentUserName;

  const ChatPageForPatient({
    Key? key,
    required this.receiverUserName,
    required this.receiverUserId,
    required this.currentUserId,
    required this.currentUserName,
  }) : super(key: key);

  @override
  State<ChatPageForPatient> createState() => _ChatPageForPatientState();
}

class _ChatPageForPatientState extends State<ChatPageForPatient> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    ChatService().FirstSendMessageToDoctor(
        widget.receiverUserId,
        widget.currentUserId!,
        widget.receiverUserName,
        widget.currentUserName!);
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String messageText = _messageController.text;

      Message newMessage = Message(
        senderId: widget.currentUserId!,
        receiverId: widget.receiverUserId,
        message: messageText,
        timestamp: Timestamp.now(),
        messageType: MessageType.Regular,
        senderEmail: '',
        chatId: '',
      );

      _messages.insert(0, newMessage);

      _messageController.clear();

      _chatService
          .sendMessage(
        widget.receiverUserId,
        messageText,
        MessageType.Regular,
        widget.currentUserId!,
      )
          .then((_) {
        // Calculate the difference between current and maximum scroll extent
        double difference = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;

        // Adjust scroll position if there's any difference
        if (difference > 0) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - difference,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }).catchError((error) {
        _messages.remove(newMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.snackBarChatPagePatientSC}.'),
          ),
        );
      });

      // _chatService.sendNotification(widget.receiverUserId, messageText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.receiverUserName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Message>>(
      stream: _chatService.getMessages(
        widget.currentUserId!,
        widget.receiverUserId,
      ),
      builder: (context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.hasError) {
          return Text(
              "${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("${AppLocalizations.of(context)!.loadingSC}...");
        }
        List<Message> messages = snapshot.data!;
        messages = messages.reversed.toList(); // Reverse the order of messages
        return ListView.builder(
          reverse: true, // Set reverse to true to start from the bottom
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(messages[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(Message message) {
    var alignment = (message.senderId == widget.currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Widget messageWidget;

    switch (message.messageType) {
      case MessageType.Regular:
        messageWidget = ChatBubble(
          message: message.message,
          bubbleColor: (message.senderId == widget.currentUserId)
              ? Colors.blue
              : Colors.grey.shade600,
        );
        break;
      // case MessageType.Appointment:
      //   Map<String, dynamic> appointmentDetails = json.decode(message.message);
      //   messageWidget = AppointmentCard(
      //     appointmentDetails: appointmentDetails,
      //   );
      //   break;
      // case MessageType.Product:
      //   Map<String, dynamic> productDetails = json.decode(message.message);
      //   messageWidget = ConfirmationCard(
      //     onAccept: () async {
      //       // Handle accept action
      //       await fetchUserDataAndApprovedAppointment(
      //           productDetails['appointmentId']);
      //       debugPrint(productDetails['appointmentId']);
      //     },
      //     onReject: () async {
      //       // Handle reject action
      //       await fetchUserDataAndRejectAppointment(
      //           productDetails['appointmentId']);
      //     },
      //     productDetails: productDetails,
      //   );
      //   break;
      default:
        messageWidget = ChatBubble(
          message: message.message,
          bubbleColor: (message.senderId == widget.currentUserId)
              ? Colors.blue
              : Colors.grey.shade600,
        );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (message.senderId == widget.currentUserId)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          messageWidget,
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText:
                    "${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => sendMessage(),
            icon: Icon(
              Icons.send,
              size: 30,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
