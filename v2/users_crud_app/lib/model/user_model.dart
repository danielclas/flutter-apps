import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String surname;
  String document;
  String email;

  User({this.name, this.surname, this.document, this.email});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        document = json['document'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'document': document,
        'email': email,
      };
}
