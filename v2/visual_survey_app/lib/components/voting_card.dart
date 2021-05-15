import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
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

  @override
  void initState() {
    super.initState();
    user = widget.picture.path.substring(0, widget.picture.path.indexOf('-'));

    date = formatDate(widget.picture.date.toDate(), [yyyy, '-', mm, '-', dd]);

    if (widget.picture.usersVoted != null &&
        widget.picture.usersVoted
            .contains(FirebaseService.loggedInUser.substring(0, FirebaseService.loggedInUser.indexOf('@')))) {
      color = Colors.grey;
    }
  }

  void vote(bool like) {
    if (color == Colors.grey) return;
    if (widget.picture.usersVoted != null &&
        widget.picture.usersVoted
            .contains(FirebaseService.loggedInUser.substring(0, FirebaseService.loggedInUser.indexOf('@'))))
      return;

    if (like)
      widget.picture.likes++;
    else
      widget.picture.dislikes++;

    setState(() {
      color = Colors.grey;
      PictureService.votePicture(
          FirebaseService.loggedInUser.substring(0, FirebaseService.loggedInUser.indexOf('@')),
          widget.picture.path,
          like);
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
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: HexColor('14ffec').withOpacity(0.9), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.percentOf(context.width),
                child: Image.network(widget.picture.url),
              ),
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      GestureDetector(
                        onTap: () => vote(true),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.thumb_up),
                        ),
                      ),
                      Text(widget.picture.likes.toString()),
                      GestureDetector(
                        onTap: () => vote(false),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.thumb_down),
                        ),
                      ),
                      Text(widget.picture.dislikes.toString()),
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Icon(Icons.person), Text(' $user')]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Icon(Icons.calendar_today), Text(' $date')]),
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
