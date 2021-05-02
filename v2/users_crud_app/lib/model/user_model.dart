class User {
  String name;
  String surname;
  String document;
  String email;

  User({this.name, this.surname, this.document, this.email});

  normalizeName(String s) => '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        document = json['document'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': normalizeName(name),
        'surname': normalizeName(surname),
        'document': document,
        'email': email,
      };
}
