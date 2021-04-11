import 'package:administracion_usuarios_app/classes/person.dart';
import 'package:administracion_usuarios_app/components/person_card.dart';
import 'package:administracion_usuarios_app/screens/login_screen.dart';
import 'package:administracion_usuarios_app/services/login_service.dart';
import 'package:administracion_usuarios_app/services/people_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'form_screen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int index = 0;
  bool isAdmin;

  List<BottomNavigationBarItem> barItems;
  List<Widget> widgets;

  void onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  void initState() {
    super.initState();
    PeopleService.init();
    isAdmin = LoginService.user.correo.contains('admin');

    barItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        title: Text('Listado'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Cargar'),
      ),
    ];

    widgets = [];

    widgets.add(
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'),
              repeat: ImageRepeat.repeat),
        ),
        child: StreamBuilder(
          stream: PeopleService.getPeople(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitWave(
                  color: Colors.orange[200],
                  size: 50,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    buildListItem(context, snapshot.data.documents[index]),
              );
            }
          },
        ),
      ),
    );

    if (isAdmin) {
      widgets.add(FormPage());
    } else {
      widgets.add(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'),
                repeat: ImageRepeat.repeat),
          ),
          child: Center(
            child: Text("Sólo los administradores pueden cargar usuarios"),
          ),
        ),
      );
    }
  }

  buildListItem(BuildContext context, DocumentSnapshot document) {
    Person obj = Person.fromJson(document.data());
    return PersonCard(obj);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            duration: Duration(milliseconds: 300),
            child: LoginPage(),
          ),
        );

        return;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Administración de usuarios'),
            backgroundColor: Colors.orange[200],
          ),
          body: Center(
            child: widgets.elementAt(index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: barItems,
            currentIndex: index,
            selectedItemColor: Colors.amber[800],
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
