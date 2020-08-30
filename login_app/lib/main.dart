import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PPS - Login app'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          shadowColor: Colors.blueAccent[100],
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/signin.png'),
                    width: 200,
                    height: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.alternate_email),
                      SizedBox(
                        width: 300,
                        child: TextField(
                            controller: emailController,
                            decoration:
                                InputDecoration(hintText: 'Ingrese su mail')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.vpn_key),
                      SizedBox(
                        width: 300,
                        child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: 'Ingrese su contraseña')),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RaisedButton(
                          color: Colors.blueAccent,
                          colorBrightness: Brightness.dark,
                          onPressed: () => {print(passwordController.text)},
                          child: Text('Ingresar'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )
                  ])
                ]),
          ),
        )));
  }
}
