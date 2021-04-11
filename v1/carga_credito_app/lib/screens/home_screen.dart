import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:carga_credito_app/classes/credit.dart';
import 'package:carga_credito_app/screens/login_screen.dart';
import 'package:carga_credito_app/services/credit_service.dart';
import 'package:carga_credito_app/services/login_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:countup/countup.dart';
import '../constants.dart';
import 'package:alert/alert.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String qrCode;
  int totalCredits;

  Future<int> scan() async {
    qrCode = await scanner.scan();
    return kCreditCodes[qrCode.substring(0, 7)];
  }

  void initCredits() async {
    await CreditService.getCredits();
    setState(() {
      totalCredits =
          CreditService.credit == null ? 0 : CreditService.credit.totalCredits;
    });
  }

  void clearCreditHandler() async {
    if (totalCredits == null || totalCredits == 0) {
      Alert(message: 'Usted no tiene créditos para eliminar').show();
      return;
    }

    setState(() {
      //Set to null to show spinner
      totalCredits = null;
    });

    await Future.delayed(Duration(seconds: 3));
    await CreditService.putCredits(0, true);
    await CreditService.getCredits();

    setState(() {
      totalCredits = CreditService.credit.totalCredits;
    });
  }

  void putCreditHandler() async {
    int amount = await scan();
    await CreditService.getCredits();
    bool canPutCredit = CreditService.canPutCredit(amount);

    if (!canPutCredit) {
      Alert(message: 'No es posible acumular más créditos').show();
    } else {
      setState(() {
        //Set to null to show spinner
        totalCredits = null;
      });

      await Future.delayed(Duration(seconds: 3));
      await CreditService.putCredits(amount, false);
      await CreditService.getCredits();

      setState(() {
        totalCredits = CreditService.credit.totalCredits;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initCredits();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(milliseconds: 500),
            child: LoginPage(),
          ),
        );

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: RawMaterialButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      duration: Duration(milliseconds: 500),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Text(
                        "Bienvenido, ${LoginService.user.correo.substring(0, LoginService.user.correo.indexOf('@'))}!",
                        style: GoogleFonts.overpass(fontSize: 20),
                      ),
                    ),
                    Text(
                      "Usted tiene",
                      style: GoogleFonts.overpass(fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: totalCredits != null
                          ? Countup(
                              begin: 0,
                              end: totalCredits.toDouble(),
                              duration: Duration(seconds: 1),
                              separator: ',',
                              style: TextStyle(
                                fontSize: 36,
                              ),
                            )
                          : SpinKitRipple(
                              color: Colors.blueGrey,
                              size: 40,
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
                  //Cargar nuevo codigo
                  RaisedButton(
                      onPressed: putCreditHandler,
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
                      //Limpiar creditos
                      onPressed: clearCreditHandler,
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
      ),
    );
  }
}
