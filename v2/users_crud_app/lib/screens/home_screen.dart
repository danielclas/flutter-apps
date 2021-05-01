import 'package:flutter/material.dart';
import 'package:users_crud_app/components/add_user.dart';
import 'package:users_crud_app/components/users_list.dart';
import '../utils/extension_methods.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: bottomNavBarIndex == 0 ? UsersList() : AddUser(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => bottomNavBarIndex = index),
          currentIndex: bottomNavBarIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Listado de usuarios'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar un usuario')
          ],
        ),
      ),
    );
  }
}
