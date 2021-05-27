import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/chat_service.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';

class ChatScreen extends StatefulWidget {
  static final String id = "ChatScreen";
  static ScrollController controller = ScrollController();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  ChatService chatService;
  bool showFab = false;

  submitMessage() {
    chatService.addMessage(Message(
        content: textController.text,
        sender: FirebaseService.loggedInUser.email,
        timestamp: Timestamp.now()));
    textController.clear();
    showFab = true;
  }

  scroll(int duration) {
    if (this.mounted) {
      showFab = false;
      Timer(
        Duration(milliseconds: duration),
        () {
          ChatScreen.controller.animateTo(ChatScreen.controller.position.maxScrollExtent + 30,
              duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    ChatScreen.controller.addListener(() {
      if (this.mounted) {
        if (ChatScreen.controller.position.atEdge && ChatScreen.controller.position.pixels != 0) {
          setState(() => showFab = false);
        } else if (!showFab) setState(() => showFab = true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scroll(500);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context).settings.arguments as String;
    final room = collection.substring(collection.indexOf('_') + 1).toUpperCase();
    chatService = ChatService(collection: collection);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: TypewriterAnimatedTextKit(
          text: ['Aula $room'],
          textStyle: null,
          speed: Duration(milliseconds: 200),
        ),
        backgroundColor: room == 'A' ? HexColor("28b5b5") : HexColor('d2e69c'),
        shadowColor: Colors.black,
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 50.0,
            right: 5.0,
            child: Visibility(
              visible: showFab,
              child: FloatingActionButton(
                backgroundColor: HexColor('d2e69c'),
                onPressed: () => scroll(200),
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
          )
        ],
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
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: chatService.getMessages(),
                builder: MessagesStream.buildList,
              )),
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
                        decoration: kMessageTextFieldDecoration.copyWith(
                            hintText: "Ingrese su mensaje", counterText: ''),
                      ),
                    ),
                    FlatButton(
                      onPressed: textController.text.length < 1 ? null : submitMessage,
                      child: Icon(
                        Icons.send,
                        size: 10.percentOf(context.width),
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
