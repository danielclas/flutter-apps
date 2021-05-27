class Picture {
  int dislikes;
  int likes;
  String path;
  String url;
  DateTime date;
  List<dynamic> usersVoted;

  Picture(this.likes, this.dislikes, this.path, this.usersVoted);

  Picture.fromJson(Map<String, dynamic> json, String url)
      : likes = json['likes'],
        dislikes = json['dislikes'],
        path = json['path'],
        this.url = url,
        date = json['date'],
        usersVoted = json['usersVoted'];
}
