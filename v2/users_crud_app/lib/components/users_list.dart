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
  final spinner = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    strokeWidth: 2,
  );

  Widget buildList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    Widget child = spinner;
    if (snapshot.hasData) {
      child = Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          reverse: true,
          children: snapshot.data.docs
              .map((e) => UserCard(
                    user: User.fromJson(e.data()),
                  ))
              .toList(),
        ),
      );
    }
    return Center(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: UsersService.getUsers(), builder: buildList);
  }
}
