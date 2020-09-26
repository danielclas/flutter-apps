import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/message_component.dart';
import '../classes/user.dart';
import '../classes/message_model.dart';
import '../services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chat extends StatefulWidget {
  Aula aula;

  Chat({this.aula}) {
    ChatService.setAula(aula);
  }

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  ScrollController controller = ScrollController();
  Key key = Key("list");

  @override
  void initState() {
    super.initState();
    ChatService.initChatService();
  }

  //TODO scroll list when new message arrives
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              print("A");
            });
          },
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    child: Center(
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/back.png'),
                          repeat: ImageRepeat.repeat),
                    ),
                    child: StreamBuilder(
                        stream: ChatService.stream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Expanded(
                              child: SpinKitDoubleBounce(
                                color: Colors.black,
                                size: 50,
                              ),
                            );
                          else
                            return ListView.builder(
                              key: key,
                              controller: controller,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) => _buildListItem(
                                  context, snapshot.data.documents[index]),
                            );
                        }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    MessageModel obj = MessageModel.fromJson(document.data());
    return Message(message: obj);
  }
}
