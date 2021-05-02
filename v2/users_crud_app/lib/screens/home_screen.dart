import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/components/add_user.dart';
import 'package:users_crud_app/components/users_list.dart';
import 'package:users_crud_app/services/firebase_service.dart';
import 'package:users_crud_app/utils/hex_color.dart';
import '../utils/extension_methods.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int bottomNavBarIndex = 0;
  bool userIsAdmin = FirebaseService.userIsAdmin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('53354a'),
          title: Text('Administración de usuarios'),
        ),
        body: AnimatedBackground(
          behaviour: RacingLinesBehaviour(
            numLines: 10,
          ),
          vsync: this,
          child: Center(
            child: Container(
              child: bottomNavBarIndex == 0 ? UsersList() : AddUser(),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor('53354a'),
          onTap: (index) => setState(() {
            bottomNavBarIndex = userIsAdmin ? index : 0;
            if (index == 1 && !userIsAdmin) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Debe ser admin para agregar usuarios')));
            }
          }),
          currentIndex: bottomNavBarIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Listado de usuarios'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: userIsAdmin ? null : Colors.grey,
                ),
                label: 'Agregar un usuario')
          ],
        ),
      ),
    );
  }
}
