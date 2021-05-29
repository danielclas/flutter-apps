import 'package:alert/alert.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:countup/countup.dart';
import 'package:credit_vault_app/components/squared_button.dart';
import 'package:credit_vault_app/services/credit_service.dart';
import 'package:credit_vault_app/utils/constants.dart';
import 'package:credit_vault_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../services/firebase_service.dart';
import '../utils/extension_methods.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String qrCode;
  int totalCredits;

  Future<int> scan() async {
    qrCode = await BarcodeScanner.scan();
    return kCreditCodes[qrCode.substring(0, 7)];
  }

  void initCredits() async {
    await CreditService.getCredits();
    setState(() {
      totalCredits = CreditService.credit == null ? 0 : CreditService.credit.totalCredits;
    });
  }

  void clearCreditHandler() async {
    if (totalCredits == null || totalCredits == 0) {
      await Alert(message: 'Usted no tiene créditos para eliminar').show();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Carga de créditos',
        ),
        backgroundColor: HexColor('a58faa'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                  height: 30.percentOf(context.height),
                  width: 80.percentOf(context.width),
                  image: Svg('images/graphic.svg')),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Bienvenido, ${FirebaseService.loggedInUser.email.substring(0, FirebaseService.loggedInUser.email.indexOf('@'))}!",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Usted tiene", style: TextStyle(fontSize: 20)),
                        totalCredits != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                                child: Material(
                                  elevation: 20,
                                  borderRadius: BorderRadius.circular(30),
                                  color: HexColor('a6d6d6'),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Countup(
                                      begin: 0,
                                      end: totalCredits.toDouble(),
                                      duration: Duration(seconds: 1),
                                      separator: ',',
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.all(8),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 5,
                                ),
                              ),
                        Text("créditos", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.only(top: 2.percentOf(context.height)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquaredButton(
                      handler: totalCredits != null ? putCreditHandler : null,
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 10.percentOf(context.width),
                      ),
                    ),
                    SquaredButton(
                      handler: totalCredits != null ? clearCreditHandler : null,
                      child: Icon(Icons.delete, size: 10.percentOf(context.width)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.percentOf(context.height)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Cargar un \nnuevo código",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text("Limpiar \nlos créditos",
                        style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
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
