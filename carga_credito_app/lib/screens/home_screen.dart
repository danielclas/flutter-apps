import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:carga_credito_app/screens/login_screen.dart';
import 'package:carga_credito_app/services/credit_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:countup/countup.dart';
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

  void scan(num) async {
    //qrCode = await scanner.scan();
    //print("Code: $qrCode");

    setState(() {
      //totalCredits = CreditService.credit.totalCredits;
      totalCredits = num;
    });
  }

  void initCredits() async {
    await CreditService.getCredits();
    totalCredits = CreditService.credit.totalCredits;
  }

  void cleanCredits() async {
    print("Borrar creditos");
  }

  @override
  void initState() {
    super.initState();
    initCredits();
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    if (totalCredits == null) initCredits();

    return Scaffold(
      appBar: AppBar(
        leading: RawMaterialButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.scale,
                    duration: Duration(milliseconds: 300),
                    child: LoginPage()));
          },
        ),
        title: Text(
          'Carga de créditos',
          style: GoogleFonts.overpass(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Usted tiene",
                    style: GoogleFonts.overpass(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Countup(
                      begin: 0,
                      end: totalCredits.toDouble(),
                      duration: Duration(seconds: 1),
                      separator: ',',
                      style: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Text("créditos", style: GoogleFonts.overpass(fontSize: 30)),
                ],
              ),
              height: 280,
              width: 280,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    onPressed: () {
                      scan(100);
                    },
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 50,
                        color: Colors.white70,
                      ),
                    ),
                    shape: CircleBorder()),
                RaisedButton(
                    onPressed: () {
                      cleanCredits();
                    },
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        size: 50,
                        color: Colors.white70,
                      ),
                    ),
                    shape: CircleBorder()),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Cargar un nuevo código",
                    style: GoogleFonts.overpass(color: Colors.white70),
                  ),
                  Text(
                    "Limpiar los créditos",
                    style: GoogleFonts.overpass(color: Colors.white70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
