class Credit {
  String user;
  var credits;
  var totalCredits;

  Credit(this.user, this.credits);

  Credit.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        credits = json['credits'] {
    totalCredits = 0;

    for (var obj in credits) {
      totalCredits += obj;
    }
  }
}
