import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static FirebaseService _instance = FirebaseService._constructor();

  static get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static get instance => _instance;
  static User get loggedInUser => auth.currentUser;

  FirebaseService._constructor();

  //This method should be called on main to initialize Firebase
  static init() async => await Firebase.initializeApp();
  static signIn(String email, String password) async => await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  static register(String email, String password) async =>
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
}
