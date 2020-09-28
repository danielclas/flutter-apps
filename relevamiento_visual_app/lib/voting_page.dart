import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relevamiento_visual_app/components/voting_card.dart';
import 'package:relevamiento_visual_app/services/pictures_service.dart';
import 'constants.dart';

class VotingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotingPageState();
  }
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Relevamiento visual',
                style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/back.png'),
                  repeat: ImageRepeat.repeat),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  VotingCard(),
                ],
              ),
            )),
      ),
    );
  }
}
