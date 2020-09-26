import 'package:aulas_chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'chat_screen.dart';
import '../services/login_service.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  void init() async {
    ChatService.initChatService();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  //TODO login screen, login user
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Aulas chat')),
        body: SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/back.png'),
                    repeat: ImageRepeat.repeat),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(
                                        aula: Aula.a,
                                      )));
                        },
                        child: Container(
                          child: Image(
                            image: AssetImage('images/a.png'),
                            height: 180.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(
                                        aula: Aula.b,
                                      )));
                        },
                        child: Container(
                          child: Image(
                            image: AssetImage('images/b.png'),
                            height: 180.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Text(
                            "Aula A",
                            style: kTitlesTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Text(
                            "Aula B",
                            style: kTitlesTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 100),
                        Text("Presione para ingresar a alguna de las aulas"),
                      ])
                ],
              ),
            ),
          ),
        ));
  }
}
