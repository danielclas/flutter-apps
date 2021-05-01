import 'package:flutter/material.dart';
import 'package:users_crud_app/model/user_model.dart';
import '../utils/extension_methods.dart';

class UserCard extends StatelessWidget {
  User user;
  UserCard({this.user});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person_pin,
              size: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Nombre:'), Text('Documento:'), Text('Email:')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${user.name} ${user.surname}'),
                Text('${user.document}'),
                Text('${user.email}')
              ],
            )
          ],
        ),
      ),
    );
  }
}
