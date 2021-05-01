import 'package:flutter/cupertino.dart';
import 'package:users_crud_app/model/user_model.dart';
import 'firebase_service.dart';

class UsersService {
  static final String collection = 'users';

  static getUsers() => FirebaseService.firestore.collection(collection).snapshots();
  static addUser(User user, String password) async {
    final authCreated = await FirebaseService.createUser(user.email, password);
    bool success = false;
    if (authCreated) {
      final userRef = await FirebaseService.firestore.collection(collection).add(user.toJson());
      success = userRef != null;
    }

    return success;
  }
}
