import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visual_survey_app/models/picture.dart';
import 'package:visual_survey_app/services/firebase_service.dart';
import 'package:visual_survey_app/services/pictures_service.dart';
import 'package:visual_survey_app/utils/hex_color.dart';

import '../utils/extension_methods.dart';

class VotingCard extends StatefulWidget {
  final Picture picture;

  VotingCard(this.picture);

  @override
  State<StatefulWidget> createState() {
    return _VotingCardState();
  }
}

class _VotingCardState extends State<VotingCard> {
  String date, time, user;
  Color color;
  bool alreadyVoted = false;
  Widget image;
  bool showSpinner = true;

  final Widget spinner = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    strokeWidth: 2,
  );

  @override
  void initState() {
    super.initState();
    user = widget.picture.user;
    user = user[0].toUpperCase() + user.substring(1);

    date = widget.picture.date.substring(0, widget.picture.date.indexOf(' '));

    if (widget.picture.usersVoted != null && widget.picture.usersVoted.contains(FirebaseService.shortUser)) {
      alreadyVoted = true;
    }

    image = Image.file(File(widget.picture.path));
    Timer(Duration(seconds: 3), () {
      setState(() {
        showSpinner = false;
      });
    });
  }

  void vote(bool like) {
    if (alreadyVoted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usted ya ha votado esta foto')));
      return;
    } else {
      alreadyVoted = true;
    }

    setState(() {
      color = Colors.grey;
      PictureService.votePicture(widget.picture, like);
      if (like)
        widget.picture.likes++;
      else
        widget.picture.dislikes++;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('El voto fue registrado correctamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: HexColor('14ffec').withOpacity(0.9), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 30.percentOf(context.width),
                child: showSpinner ? spinner : image,
              ),
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      MaterialButton(
                        onPressed: () => vote(true),
                        elevation: 10,
                        color: alreadyVoted ? Colors.grey : HexColor('14ffec'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 20,
                            ),
                            Text('  ' + widget.picture.likes.toString())
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: MaterialButton(
                          onPressed: () => vote(false),
                          elevation: 10,
                          disabledColor: Colors.grey,
                          color: alreadyVoted ? Colors.grey : HexColor('14ffec'),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                size: 20,
                              ),
                              Text('  ' + widget.picture.dislikes.toString())
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person),
                    ),
                    Text(' $user'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.calendar_today),
                    ),
                    Text(' $date'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
