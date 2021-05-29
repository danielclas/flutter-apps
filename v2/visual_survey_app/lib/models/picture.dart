import 'package:visual_survey_app/services/firebase_service.dart';
import 'package:visual_survey_app/services/pictures_service.dart';

class Picture {
  int dislikes;
  int likes;
  String path;
  String date;
  String user;
  List<dynamic> usersVoted;
  bool isNice;

  Picture(this.likes, this.dislikes, this.path, this.usersVoted) {
    this.date = DateTime.now().toString();
    this.user = FirebaseService.shortUser;
    this.isNice = PictureService.niceThings;
  }

  Map<String, dynamic> toJson() => {
        'dislikes': dislikes,
        'likes': likes,
        'path': path,
        'date': date,
        'user': user,
        'usersVoted': usersVoted,
        'isNice': isNice,
      };

  Picture.fromJson(Map<String, dynamic> json)
      : likes = json['likes'],
        dislikes = json['dislikes'],
        path = json['path'],
        date = json['date'],
        user = json['user'],
        isNice = json['isNice'],
        usersVoted = json['usersVoted'];
}
