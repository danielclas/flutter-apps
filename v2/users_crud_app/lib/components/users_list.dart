import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/components/user_card.dart';
import 'package:users_crud_app/model/user_model.dart';
import 'package:users_crud_app/services/users_service.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Widget buildList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final list = <Widget>[];
      for (var u in snapshot.data.docs) {
        list.add(UserCard(
          user: User.fromJson(u.data()),
        ));
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            reverse: true,
            children: list,
          ),
        ),
      );
    }
    return Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: UsersService.getUsers(), builder: buildList);
  }
}
