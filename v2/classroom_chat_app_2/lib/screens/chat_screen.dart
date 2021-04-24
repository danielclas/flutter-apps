import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/chat_service.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static final String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  String message;
  ChatService chatService;

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context).settings.arguments as String;
    chatService = ChatService(collection: collection);
    print("passing collection $collection");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: Text('Aula ${collection.substring(collection.indexOf('-') + 1).toUpperCase()}'),
        backgroundColor: HexColor("8fd9a8"),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(stream: chatService.getMessages()),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLength: 21,
                      maxLines: 1,
                      controller: textController,
                      onChanged: (value) {
                        if (value.length <= 21) {
                          message = value;
                        }
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      chatService.addMessage(Message(
                          content: textController.text,
                          sender: FirebaseService.loggedInUser.email,
                          timestamp: Timestamp.now()));
                      textController.clear();
                    },
                    child: Text(
                      'Enviar',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
