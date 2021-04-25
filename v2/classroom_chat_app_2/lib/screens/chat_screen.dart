import 'dart:async';

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
  ScrollController controller = ScrollController();
  ChatService chatService;
  bool showFab = false;

  submitMessage() {
    chatService.addMessage(Message(content: textController.text, sender: FirebaseService.loggedInUser.email, timestamp: Timestamp.now()));
    textController.clear();
  }

  scroll(int duration) {
    showFab = false;
    Timer(
      Duration(milliseconds: duration),
      () {
        controller.animateTo(controller.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        setState(() => showFab = false);
      } else if (!showFab) setState(() => showFab = true);
    });
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
          decoration:
              BoxDecoration(image: DecorationImage(scale: 1.5, repeat: ImageRepeat.repeat, image: AssetImage('images/chat-background-2.png'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: chatService.getMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data.docs;
                    final list = <Widget>[];
                    for (var m in messages) {
                      final temp = MessagesStream.buildListItem(m);
                      for (var t in temp) list.add(t);
                    }
                    MessagesStream.previousDate = null;
                    return ListView(controller: controller, padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), children: list);
                  }
                  return Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: HexColor('d2e69c'),
                    )),
                  );
                },
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
                        decoration: kMessageTextFieldDecoration.copyWith(hintText: "Ingrese su mensaje", counterText: ''),
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
