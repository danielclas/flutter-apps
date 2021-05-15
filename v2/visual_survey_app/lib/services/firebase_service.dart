import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static FirebaseService _instance = FirebaseService._constructor();
  static String currentUser = 'admin@admin.com';

  static get auth => FirebaseAuth.instance;
  static Firestore get firestore => Firestore.instance;
  static get instance => _instance;
  static String get loggedInUser => currentUser;

  FirebaseService._constructor();

  //This method should be called on main to initialize Firebase
  static init() async => FirebaseApp.instance;

  static signIn(String email, String password) async {
    currentUser = email;
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static register(String email, String password) async =>
      await auth.createUserWithEmailAndPassword(email: email, password: password);
}
