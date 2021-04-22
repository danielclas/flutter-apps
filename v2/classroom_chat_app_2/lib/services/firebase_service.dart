import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseService _instance = FirebaseService._constructor();

  static get auth => _auth;
  static get instance => _instance;
  static get loggedInUser => _auth.currentUser;

  FirebaseService._constructor();

  //This method should be called on main to initialize Firebase
  static init() async => await Firebase.initializeApp();
}
