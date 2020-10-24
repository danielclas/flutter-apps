import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';
import '../classes/person.dart';

class PeopleService {
  static FirebaseFirestore firestore;
  static User user;

  static Future<void> init() async {
    await Firebase.initializeApp();
  }

  static void addPerson(Person p) async {
    if (FirebaseFirestore.instance == null) init();
    await FirebaseFirestore.instance.collection('people').add(p.toJson());
  }

  static Stream<QuerySnapshot> getPeople() {
    if (FirebaseFirestore.instance == null) init();

    return FirebaseFirestore.instance
        .collection('people')
        .orderBy('correo', descending: true)
        .snapshots();
  }
}
