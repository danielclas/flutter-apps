import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:carga_credito_app/services/credit_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../constants.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String qrCode;
  int totalCredits;
  bool showSpinner;
  StorageUploadTask task;

  void scan() async {
    qrCode = await scanner.scan();
    print("Code: $qrCode");

    setState(() {
      totalCredits = CreditService.credit.totalCredits;
    });
  }

  void initCredits() async {
    await CreditService.getCredits();
  }

  @override
  void initState() {
    super.initState();
    initCredits();
    totalCredits = CreditService.credit.totalCredits;
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Relevamiento visual',
              style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/back.png'), repeat: ImageRepeat.repeat),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                scan();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),
                    Text("Presiona para escanear un código"),
                  ],
                ),
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.9), width: 2),
                ),
              ),
            ),
            Text("Usted posee $totalCredits créditos"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    onPressed: null,
                    child: Text(
                      "Cargar crédito",
                    ),
                    color: ThemeData.dark().accentColor),
                RaisedButton(
                    onPressed: null,
                    child: Text(
                      "Limpiar créditos", //TODO preguntar confirmar
                    ),
                    color: ThemeData.dark().accentColor),
              ],
            )
          ],
        ),
      ),
    );
  }
}
