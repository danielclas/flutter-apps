import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static FirebaseService _instance = FirebaseService._constructor();
  static String currentUser = '';

  static get auth => FirebaseAuth.instance;
  static get instance => _instance;
  static String get loggedInUser => auth.currentUser;
  static String get shortUser => currentUser.substring(0, currentUser.indexOf('@'));

  FirebaseService._constructor();

  //This method should be called on main to initialize Firebase
  static init() async => FirebaseApp;

  static signIn(String email, String password) async {
    currentUser = email;
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static register(String email, String password) async =>
      await auth.createUserWithEmailAndPassword(email: email, password: password);
}
