import 'package:flutter/material.dart';
import 'package:relevamiento_visual_app/classes/picture_model.dart';
import 'package:relevamiento_visual_app/services/login_service.dart';
import 'package:relevamiento_visual_app/services/pictures_service.dart';
import 'package:date_format/date_format.dart';

class VotingCard extends StatefulWidget {
  Picture picture;

  VotingCard(this.picture);

  @override
  State<StatefulWidget> createState() {
    return _VotingCardState();
  }
}

class _VotingCardState extends State<VotingCard> {
  String date, time, user;
  Color color = null;

  @override
  void initState() {
    super.initState();
    user = widget.picture.path.substring(0, widget.picture.path.indexOf('-'));

    date = formatDate(widget.picture.date.toDate(), [yyyy, '-', M, '-', dd]);
    time = formatDate(widget.picture.date.toDate(), [HH, ':', nn]);

    if (widget.picture.usersVoted != null &&
        widget.picture.usersVoted.contains(LoginService.user.correo
            .substring(0, LoginService.user.correo.indexOf('@')))) {
      color = Colors.grey;
    }
  }

  void vote(bool like) {
    if (color == Colors.grey) return;
    if (widget.picture.usersVoted != null &&
        widget.picture.usersVoted.contains(LoginService.user.correo
            .substring(0, LoginService.user.correo.indexOf('@')))) return;

    if (like)
      widget.picture.likes++;
    else
      widget.picture.dislikes++;

    setState(() {
      color = Colors.grey;
      PictureService.votePicture(
          LoginService.user.correo
              .substring(0, LoginService.user.correo.indexOf('@')),
          widget.picture.path,
          like);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(widget.picture.url),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => vote(true),
                        child: Image(
                          image: AssetImage('images/like.png'),
                          color: color,
                          width: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Text(widget.picture.likes.toString()),
                      ),
                      GestureDetector(
                        onTap: () => vote(false),
                        child: Image(
                          image: AssetImage('images/dislike.png'),
                          color: color,
                          width: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Text(widget.picture.dislikes.toString()),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Subida por $user \n Fecha: $date $time",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
