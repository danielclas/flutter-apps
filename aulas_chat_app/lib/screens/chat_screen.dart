import 'package:flutter/services.dart';
import 'package:aulas_chat_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import '../components/message_component.dart';
import '../classes/message_model.dart';
import '../services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chat extends StatefulWidget {
  final Aula aula;

  Chat({@required this.aula}) {
    ChatService.setAula(aula);
  }

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  ScrollController controller = ScrollController();
  Key key = Key("list");
  bool showFab = false;

  @override
  void initState() {
    super.initState();
    ChatService.initChatService();
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          setState(() {
            showFab = false;
          });
        }
      } else {
        setState(() {
          showFab = true;
        });
      }
    });
  }

  //TODO scroll list when new message arrives
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.upToDown,
            duration: Duration(milliseconds: 300),
            child: Home(),
          ),
        );

        return;
      },
      child: Scaffold(
          floatingActionButton: Stack(
            children: <Widget>[
              Positioned(
                bottom: 50.0,
                right: 5.0,
                child: Visibility(
                  visible: showFab,
                  child: FloatingActionButton(
                    backgroundColor: Colors.teal[300],
                    heroTag: 'scroll',
                    onPressed: () {
                      setState(() {
                        showFab = false;

                        controller.animateTo(
                            controller.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut);
                      });
                    },
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/back.png'),
                    repeat: ImageRepeat.repeat),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      child: Row(children: [
                        Container(
                          width: 40,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.upToDown,
                                  duration: Duration(milliseconds: 300),
                                  child: Home(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.aula == Aula.a ? "Aula A" : "Aula B",
                              style: kAulaTitleTextStyle,
                            ),
                          ),
                        ),
                      ]),
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: StreamBuilder(
                        stream: ChatService.stream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SpinKitDoubleBounce(
                                color: Colors.black,
                                size: 50,
                              ),
                            );
                          } else {
                            showFab = true;

                            return ListView.builder(
                              key: key,
                              controller: controller,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) => _buildListItem(
                                  context, snapshot.data.documents[index]),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(25),
                                ],
                                controller: messageController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  focusColor: Colors.teal[300],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: FloatingActionButton(
                              child: Icon(Icons.send),
                              backgroundColor: Colors.teal[300],
                              onPressed: () {
                                setState(() {
                                  ChatService.writeMessage(
                                      messageController.text);
                                  messageController.text = "";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    MessageModel obj = MessageModel.fromJson(document.data());
    return Message(message: obj);
  }
}
