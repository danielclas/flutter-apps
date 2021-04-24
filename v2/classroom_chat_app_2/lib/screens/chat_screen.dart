import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/chat_service.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ChatScreen extends StatefulWidget {
  static final String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  ChatService chatService;

  submitMessage() {
    chatService.addMessage(
        Message(content: textController.text, sender: FirebaseService.loggedInUser.email, timestamp: Timestamp.now()));
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context).settings.arguments as String;
    chatService = ChatService(collection: collection);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: Text('Aula ${collection.substring(collection.indexOf('_') + 1).toUpperCase()}'),
        backgroundColor: HexColor("8fd9a8"),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  scale: 1.5, repeat: ImageRepeat.repeat, image: AssetImage('images/chat-background-2.png'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(chatService: chatService),
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
                        onChanged: (value) => setState(() {}),
                        decoration:
                            kMessageTextFieldDecoration.copyWith(hintText: "Ingrese su mensaje", counterText: ''),
                      ),
                    ),
                    FlatButton(
                      onPressed: textController.text.length < 1 ? null : submitMessage,
                      child: Icon(
                        Icons.send,
                        size: 35,
                        color: textController.text.length < 1 ? Colors.grey : HexColor("28b5b5"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
