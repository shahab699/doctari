//here latest updated code before delete message functionality
import 'dart:io';
import 'package:doctari/chat/chat_bubble.dart';
import 'package:doctari/chat/chat_model.dart';
import 'package:doctari/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserId;
  final String? currentUserId;
  final String? currentUserName;

  const ChatPage({
    Key? key,
    required this.receiverUserName,
    required this.receiverUserId,
    this.currentUserId,
    this.currentUserName,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  late Stream<List<Message>> _messagesStream;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Ensure currentUserId and receiverUserId are not null
    if (widget.currentUserId != null && widget.receiverUserId.isNotEmpty) {
      _messagesStream = _chatService.getMessages(
          widget.currentUserId!, widget.receiverUserId);
    } else {
      // Handle the case where IDs are null or empty
      _messagesStream = Stream.empty();
    }

    // Add listener to scroll to bottom on data change
    _scrollController.addListener(() {
      // You can also use _scrollController.position.maxScrollExtent to check scroll position
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage({
    String? message,
    String? fileUrl,
    MessageType? messageType,
  }) async {
    try {
      // Ensure currentUserId is not null
      if (widget.currentUserId == null || widget.receiverUserId.isEmpty) {
        throw 'Invalid user or receiver ID';
      }

      final newMessage = Message(
        senderId: widget.currentUserId!,
        receiverId: widget.receiverUserId,
        message: message ?? '',
        timestamp: Timestamp.now(),
        messageType: messageType ?? MessageType.Regular,
        fileUrl: fileUrl,
        senderEmail: widget.currentUserName ?? '',
        chatId: _generateChatRoomId(), // Ensure chatId is set correctly
      );

      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(newMessage.chatId)
          .collection('messages')
          .add(newMessage.toMap(true));

      _messageController.clear();
      // Scroll to bottom after sending a message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      print('Error sending message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
    }
  }

  Future<void> sendFileMessage(File file, MessageType messageType) async {
    try {
      String fileUrl = await _chatService.uploadFile(file);
      await sendMessage(fileUrl: fileUrl, messageType: messageType);
    } catch (e) {
      print('Error sending file message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending file message: $e')),
      );
    }
  }

  String _generateChatRoomId() {
    List<String> ids = [widget.currentUserId!, widget.receiverUserId];
    ids.sort();
    return ids.join("_");
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
      case MessageType.Image:
        messageWidget = message.fileUrl != null
            ? Align(
                alignment: alignment,
                child: SizedBox(
                  width: 250, // Set the desired width
                  height: 350, // Set the desired height
                  child: Image.network(
                    message.fileUrl!,
                    fit: BoxFit.cover, // Adjust the image to fit the dimensions
                  ),
                ),
              )
            : SizedBox.shrink();
        break;
      case MessageType.Document:
        messageWidget = message.fileUrl != null
            ? Align(
                alignment: alignment,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      if (await canLaunch(message.fileUrl!)) {
                        await launch(message.fileUrl!);
                      } else {
                        throw 'Could not launch ${message.fileUrl}';
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error opening document: $e')),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf),
                      SizedBox(width: 8),
                      Text("Document"),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink();
        break;
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await sendFileMessage(file, MessageType.Image);
    }
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await sendFileMessage(file, MessageType.Document);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverUserName,
        ),
        titleTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: false, // Ensure new messages appear at the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _buildMessageItem(message);
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickDocument,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText:
                          '${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () =>
                      sendMessage(message: _messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




//here latest code where every thing ok in chat
// import 'dart:io';
// import 'package:doctari/chat/chat_bubble.dart';
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:url_launcher/url_launcher.dart'; // For launching URLs

// class ChatPage extends StatefulWidget {
//   final String receiverUserName;
//   final String receiverUserId;
//   final String? currentUserId;
//   final String? currentUserName;

//   const ChatPage({
//     Key? key,
//     required this.receiverUserName,
//     required this.receiverUserId,
//     this.currentUserId,
//     this.currentUserName,
//   }) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _messagesStream;

//   @override
//   void initState() {
//     super.initState();
//     // Ensure currentUserId and receiverUserId are not null
//     if (widget.currentUserId != null && widget.receiverUserId.isNotEmpty) {
//       _messagesStream = _chatService.getMessages(
//           widget.currentUserId!, widget.receiverUserId);
//     } else {
//       // Handle the case where IDs are null or empty
//       _messagesStream = Stream.empty();
//     }
//   }

//   Future<void> sendMessage({
//     String? message,
//     String? fileUrl,
//     MessageType? messageType,
//   }) async {
//     try {
//       // Ensure currentUserId is not null
//       if (widget.currentUserId == null || widget.receiverUserId.isEmpty) {
//         throw 'Invalid user or receiver ID';
//       }

//       final newMessage = Message(
//         senderId: widget.currentUserId!,
//         receiverId: widget.receiverUserId,
//         message: message ?? '',
//         timestamp: Timestamp.now(),
//         messageType: messageType ?? MessageType.Regular,
//         fileUrl: fileUrl,
//         senderEmail: widget.currentUserName ?? '',
//         chatId: _generateChatRoomId(), // Ensure chatId is set correctly
//       );

//       await FirebaseFirestore.instance
//           .collection('conversations')
//           .doc(newMessage.chatId)
//           .collection('messages')
//           .add(newMessage.toMap(true));

//       _messageController.clear();
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sending message: $e')),
//       );
//     }
//   }

//   Future<void> sendFileMessage(File file, MessageType messageType) async {
//     try {
//       String fileUrl = await _chatService.uploadFile(file);
//       await sendMessage(fileUrl: fileUrl, messageType: messageType);
//     } catch (e) {
//       print('Error sending file message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sending file message: $e')),
//       );
//     }
//   }

//   String _generateChatRoomId() {
//     List<String> ids = [widget.currentUserId!, widget.receiverUserId];
//     ids.sort();
//     return ids.join("_");
//   }

//   Widget _buildMessageItem(Message message) {
//     var alignment = (message.senderId == widget.currentUserId)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     Widget messageWidget;

//     switch (message.messageType) {
//       case MessageType.Regular:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//         break;
//       case MessageType.Image:
//         messageWidget = message.fileUrl != null
//             ? Align(
//                 alignment: alignment,
//                 // child: Image.network(message.fileUrl!),
//                 child: SizedBox(
//                   width: 250, // Set the desired width
//                   height: 350, // Set the desired height
//                   child: Image.network(
//                     message.fileUrl!,
//                     fit: BoxFit.cover, // Adjust the image to fit the dimensions
//                   ),
//                 ),
//               )
//             : SizedBox.shrink();
//         break;
//       case MessageType.Document:
//         messageWidget = message.fileUrl != null
//             ? Align(
//                 alignment: alignment,
//                 child: GestureDetector(
//                   onTap: () async {
//                     try {
//                       if (await canLaunch(message.fileUrl!)) {
//                         await launch(message.fileUrl!);
//                       } else {
//                         throw 'Could not launch ${message.fileUrl}';
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error opening document: $e')),
//                       );
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.picture_as_pdf),
//                       SizedBox(width: 8),
//                       Text("Document"),
//                     ],
//                   ),
//                 ),
//               )
//             : SizedBox.shrink();
//         break;
//       default:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: (message.senderId == widget.currentUserId)
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           messageWidget,
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       await sendFileMessage(file, MessageType.Image);
//     }
//   }

//   Future<void> _pickDocument() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       await sendFileMessage(file, MessageType.Document);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.receiverUserName,
//         ),
//         titleTextStyle:
//             TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         backgroundColor: Colors.blue,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _messagesStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No messages yet.'));
//                 } else {
//                   final messages = snapshot.data!;
//                   return ListView.builder(
//                     reverse: false, // To show the latest messages at the bottom
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return _buildMessageItem(message);
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.attach_file),
//                   onPressed: _pickDocument,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText:
//                           '${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () =>
//                       sendMessage(message: _messageController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



//when show data in app
// import 'dart:io';
// import 'package:doctari/chat/chat_bubble.dart';
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:url_launcher/url_launcher.dart'; // For launching URLs

// class ChatPage extends StatefulWidget {
//   final String receiverUserName;
//   final String receiverUserId;
//   final String? currentUserId;
//   final String? currentUserName;

//   const ChatPage({
//     Key? key,
//     required this.receiverUserName,
//     required this.receiverUserId,
//     this.currentUserId,
//     this.currentUserName,
//   }) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _messagesStream;

//   @override
//   void initState() {
//     super.initState();
//     _messagesStream =
//         _chatService.getMessages(widget.currentUserId!, widget.receiverUserId);
//   }

//   Future<void> sendMessage({
//     String? message,
//     String? fileUrl,
//     MessageType? messageType,
//   }) async {
//     try {
//       final newMessage = Message(
//         senderId: widget.currentUserId!,
//         receiverId: widget.receiverUserId,
//         message: message ?? '',
//         timestamp: Timestamp.now(),
//         messageType: messageType ?? MessageType.Regular,
//         fileUrl: fileUrl,
//         senderEmail: widget.currentUserName ?? '', // Add sender's name here
//         chatId: '', // Update chatId logic if needed
//       );

//       await FirebaseFirestore.instance
//           .collection('conversations')
//           .doc(_generateChatRoomId())
//           .collection('messages')
//           .add(
//               newMessage.toMap(true)); // Assuming 'true' here, adjust as needed

//       _messageController.clear();
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sending message: $e')),
//       );
//     }
//   }

//   Future<void> sendFileMessage(File file, MessageType messageType) async {
//     try {
//       String fileUrl = await _chatService.uploadFile(file);
//       await sendMessage(fileUrl: fileUrl, messageType: messageType);
//     } catch (e) {
//       print('Error sending file message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sending file message: $e')),
//       );
//     }
//   }

//   String _generateChatRoomId() {
//     List<String> ids = [widget.currentUserId!, widget.receiverUserId];
//     ids.sort();
//     return ids.join("_");
//   }

//   Widget _buildMessageItem(Message message) {
//     var alignment = (message.senderId == widget.currentUserId)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     Widget messageWidget;

//     switch (message.messageType) {
//       case MessageType.Regular:
//         messageWidget = ChatBubble(
//           message: message.message, // Ensure message is never null
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//         break;
//       case MessageType.Image:
//         messageWidget = message.fileUrl != null
//             ? Align(
//                 alignment: alignment,
//                 child: Image.network(message.fileUrl!),
//               )
//             : SizedBox.shrink(); // Handle null fileUrl
//         break;
//       case MessageType.Document:
//         messageWidget = message.fileUrl != null
//             ? Align(
//                 alignment: alignment,
//                 child: GestureDetector(
//                   onTap: () async {
//                     try {
//                       if (await canLaunch(message.fileUrl!)) {
//                         await launch(message.fileUrl!);
//                       } else {
//                         throw 'Could not launch ${message.fileUrl}';
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error opening document: $e')),
//                       );
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.picture_as_pdf),
//                       SizedBox(width: 8),
//                       Text("Document"),
//                     ],
//                   ),
//                 ),
//               )
//             : SizedBox.shrink(); // Handle null fileUrl
//         break;
//       default:
//         messageWidget = ChatBubble(
//           message: message.message, // Ensure message is never null
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: (message.senderId == widget.currentUserId)
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           messageWidget,
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       await sendFileMessage(file, MessageType.Image);
//     }
//   }

//   Future<void> _pickDocument() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       await sendFileMessage(file, MessageType.Document);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.receiverUserName,
//         ),
//         titleTextStyle: TextStyle(color: Colors.white),
//         backgroundColor: Colors.blue,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _messagesStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No messages yet.'));
//                 } else {
//                   final messages = snapshot.data!;
//                   return ListView.builder(
//                     reverse: true, // To show the latest messages at the bottom
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return _buildMessageItem(message);
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.attach_file),
//                   onPressed: _pickDocument,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText:
//                           '${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () =>
//                       sendMessage(message: _messageController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







// import 'dart:convert';
// import 'dart:io';
// import 'package:doctari/chat/chat_bubble.dart';
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:url_launcher/url_launcher.dart'; // For launching URLs

// class ChatPage extends StatefulWidget {
//   final String receiverUserName;
//   final String receiverUserId;
//   final String? currentUserId;
//   final String? currentUserName;

//   const ChatPage({
//     Key? key,
//     required this.receiverUserName,
//     required this.receiverUserId,
//     this.currentUserId,
//     this.currentUserName,
//   }) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   late Stream<List<Message>> _messagesStream;

//   @override
//   void initState() {
//     super.initState();
//     _messagesStream =
//         _chatService.getMessages(widget.currentUserId!, widget.receiverUserId);
//   }

//   Future<void> sendMessage(
//       {String? message, String? fileUrl, MessageType? messageType}) async {
//     try {
//       final newMessage = Message(
//         senderId: widget.currentUserId!,
//         receiverId: widget.receiverUserId,
//         message: message ?? '',
//         timestamp: Timestamp.now(),
//         messageType: messageType ?? MessageType.Regular,
//         fileUrl: fileUrl,
//         senderEmail: '',
//         chatId: '',
//       );

//       await FirebaseFirestore.instance.collection('conversations').add({
//         'senderId': widget.currentUserId,
//         'receiverId': widget.receiverUserId,
//         'message': message,
//         'fileUrl': fileUrl,
//         'messageType': messageType.toString(),
//         'timestamp': Timestamp.now(),
//       });

//       _messageController.clear();
//       print('file url: $fileUrl');
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   Future<void> sendFileMessage(File file, MessageType messageType) async {
//     try {
//       String fileUrl = await _chatService.uploadFile(file);
//       await sendMessage(fileUrl: fileUrl, messageType: messageType);
//       print('fileurl: $file');
//     } catch (e) {
//       print('Error sending file message: $e');
//     }
//   }

//   Widget _buildMessageItem(Message message) {
//     var alignment = (message.senderId == widget.currentUserId)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     Widget messageWidget;

//     switch (message.messageType) {
//       case MessageType.Regular:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//         break;
//       case MessageType.Image:
//         messageWidget = Align(
//           alignment: alignment,
//           child: Image.network(message.fileUrl!),
//         );
//         break;
//       case MessageType.Document:
//         messageWidget = Align(
//           alignment: alignment,
//           child: GestureDetector(
//             onTap: () async {
//               if (await canLaunch(message.fileUrl!)) {
//                 await launch(message.fileUrl!);
//               } else {
//                 throw 'Could not launch ${message.fileUrl}';
//               }
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.picture_as_pdf),
//                 SizedBox(width: 8),
//                 Text("Document"),
//               ],
//             ),
//           ),
//         );
//         break;
//       default:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: (message.senderId == widget.currentUserId)
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           messageWidget,
//         ],
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       await sendFileMessage(file, MessageType.Image);
//     }
//   }

//   Future<void> _pickDocument() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       await sendFileMessage(file, MessageType.Document);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.receiverUserName,
//         ),
//         titleTextStyle: TextStyle(color: Colors.white),
//         backgroundColor: Colors.blue,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _messagesStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No messages yet.'));
//                 } else {
//                   final messages = snapshot.data!;
//                   return ListView.builder(
//                     reverse: true, // To show the latest messages at the bottom
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return _buildMessageItem(message);
//                     },
//                   );
//                 }
//               },
//             ),
//           ),

//           // Expanded(
//           //   child: StreamBuilder<List<Message>>(
//           //     stream: _messagesStream,
//           //     builder: (context, snapshot) {
//           //       if (snapshot.connectionState == ConnectionState.waiting) {
//           //         return Center(child: CircularProgressIndicator());
//           //       } else if (snapshot.hasError) {
//           //         return Center(child: Text('Error: ${snapshot.error}'));
//           //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           //         return Center(child: Text('No messages yet.'));
//           //       } else {
//           //         final messages = snapshot.data!;
//           //         return ListView.builder(
//           //           reverse: true,
//           //           itemCount: messages.length,
//           //           itemBuilder: (context, index) {
//           //             final message = messages[index];
//           //             return _buildMessageItem(message);
//           //           },
//           //         );
//           //       }
//           //     },
//           //   ),
//           // ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.attach_file),
//                   onPressed: _pickDocument,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText:
//                           '${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () =>
//                       sendMessage(message: _messageController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //add here build message
//   Widget _buildMessageItems(Message message) {
//     // Check the message type and render the corresponding widget
//     if (message.messageType == 'MessageType.Document') {
//       return GestureDetector(
//         onTap: () async {
//           // Implement file download functionality here
//           // Example: Download and open the file using `url_launcher` or any other method
//           final url = message.fileUrl;
//           if (await canLaunch(url!)) {
//             await launch(url);
//           } else {
//             throw 'Could not launch $url';
//           }
//         },
//         child: Container(
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.file_present, color: Colors.blue),
//               SizedBox(width: 10),
//               Expanded(child: Text('Document')),
//             ],
//           ),
//         ),
//       );
//     } else {
//       // Display the text message
//       return Container(
//         padding: EdgeInsets.all(10),
//         margin: EdgeInsets.symmetric(vertical: 5),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(message.message ?? ''),
//       );
//     }
//   }
// }

//here code before updating screen
// import 'dart:convert';
// import 'package:doctari/chat/chat_bubble.dart';
// import 'package:doctari/chat/chat_model.dart';
// import 'package:doctari/chat/chat_service.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ChatPage extends StatefulWidget {
//   final String receiverUserName;
//   final String receiverUserId;
//   final String? currentUserId;
//   final String? currentUserName;

//   const ChatPage({
//     Key? key,
//     required this.receiverUserName,
//     required this.receiverUserId,
//     required this.currentUserId,
//     required this.currentUserName,
//   }) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   late ScrollController _scrollController;
//   List<Message> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     ChatService().FirstSendMessage(widget.receiverUserId, widget.currentUserId!,
//         widget.receiverUserName, widget.currentUserName!);
//   }

//   void sendMessage() {
//     if (_messageController.text.isNotEmpty) {
//       String messageText = _messageController.text;

//       Message newMessage = Message(
//         senderId: widget.currentUserId!,
//         receiverId: widget.receiverUserId,
//         message: messageText,
//         timestamp: Timestamp.now(),
//         messageType: MessageType.Regular,
//         senderEmail: '',
//         chatId: '',
//       );

//       _messages.insert(0, newMessage);

//       _messageController.clear();

//       _chatService
//           .sendMessage(
//         widget.receiverUserId,
//         messageText,
//         MessageType.Regular,
//         widget.currentUserId!,
//       )
//           .then((_) {
//         // Calculate the difference between current and maximum scroll extent
//         double difference = _scrollController.position.maxScrollExtent -
//             _scrollController.position.pixels;

//         // Adjust scroll position if there's any difference
//         if (difference > 0) {
//           _scrollController.animateTo(
//             _scrollController.position.maxScrollExtent - difference,
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//           );
//         }
//       }).catchError((error) {
//         _messages.remove(newMessage);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 '${AppLocalizations.of(context)!.snackBarChatPagePatientSC}.'),
//           ),
//         );
//       });

//       // _chatService.sendNotification(widget.receiverUserId, messageText);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           widget.receiverUserName,
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 5),
//           Expanded(child: _buildMessageList()),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     return StreamBuilder<List<Message>>(
//       stream: _chatService.getMessages(
//         widget.currentUserId!,
//         widget.receiverUserId,
//       ),
//       builder: (context, AsyncSnapshot<List<Message>> snapshot) {
//         if (snapshot.hasError) {
//           return Text(
//               "${AppLocalizations.of(context)!.errorSC}: ${snapshot.error}");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("${AppLocalizations.of(context)!.loadingSC}...");
//         }
//         List<Message> messages = snapshot.data!;
//         messages = messages.reversed.toList(); // Reverse the order of messages
//         return ListView.builder(
//           reverse: true, // Set reverse to true to start from the bottom
//           controller: _scrollController,
//           itemCount: messages.length,
//           itemBuilder: (context, index) {
//             return _buildMessageItem(messages[index]);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildMessageItem(Message message) {
//     var alignment = (message.senderId == widget.currentUserId)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     Widget messageWidget;

//     switch (message.messageType) {
//       case MessageType.Regular:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//         break;
//       // case MessageType.Appointment:
//       //   Map<String, dynamic> appointmentDetails = json.decode(message.message);
//       //   messageWidget = AppointmentCard(
//       //     appointmentDetails: appointmentDetails,
//       //   );
//       //   break;
//       // case MessageType.Product:
//       //   Map<String, dynamic> productDetails = json.decode(message.message);
//       //   messageWidget = ConfirmationCard(
//       //     onAccept: () async {
//       //       // Handle accept action
//       //       await fetchUserDataAndApprovedAppointment(
//       //           productDetails['appointmentId']);
//       //       debugPrint(productDetails['appointmentId']);
//       //     },
//       //     onReject: () async {
//       //       // Handle reject action
//       //       await fetchUserDataAndRejectAppointment(
//       //           productDetails['appointmentId']);
//       //     },
//       //     productDetails: productDetails,
//       //   );
//       //   break;
//       default:
//         messageWidget = ChatBubble(
//           message: message.message,
//           bubbleColor: (message.senderId == widget.currentUserId)
//               ? Colors.blue
//               : Colors.grey.shade600,
//         );
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: (message.senderId == widget.currentUserId)
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           messageWidget,
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText:
//                     "${AppLocalizations.of(context)!.hintSndMsgChatPagePatientSC}",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => sendMessage(),
//             icon: Icon(
//               Icons.send,
//               size: 30,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
