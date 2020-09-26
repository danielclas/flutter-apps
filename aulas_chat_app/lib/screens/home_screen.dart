import 'package:aulas_chat_app/screens/loading_screen.dart';
import 'package:aulas_chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool isLoading = false;

  void openChatScreen(Aula aula) {
    isLoading = true;
    ChatService.initChatService();
    ChatService.setAula(aula);
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.downToUp,
        child: Chat(
          aula: aula,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.upToDown,
        child: LoginPage(),
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.upToDown,
            child: LoginPage(),
          ),
        );

        return;
      },
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: isLoading
              ? LoadingScreen()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/back.png'),
                        repeat: ImageRepeat.repeat),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              openChatScreen(Aula.a);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "A",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 150,
                                        color:
                                            Color(0xff8BC34A).withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xff8BC34A)
                                                .withOpacity(0.5),
                                            blurRadius: 3,
                                            offset: Offset(-5, -5),
                                          ),
                                        ]),
                                  ),
                                  Text("Presione para ingresar al Aula A"),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff8BC34A).withOpacity(0.05),
                                border: Border.all(
                                    color: Color(0xff8BC34A).withOpacity(0.1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(70),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              openChatScreen(Aula.b);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "B",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 150,
                                        color:
                                            Color(0xff8BC34A).withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xff8BC34A)
                                                .withOpacity(0.5),
                                            blurRadius: 3,
                                            offset: Offset(-5, -5),
                                          ),
                                        ]),
                                  ),
                                  Text("Presione para ingresar al Aula B"),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff8BC34A).withOpacity(0.05),
                                border: Border.all(
                                    color: Color(0xff8BC34A).withOpacity(0.1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(70),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      )),
    );
  }
}
