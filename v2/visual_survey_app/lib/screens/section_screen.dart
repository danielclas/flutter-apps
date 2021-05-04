import 'package:flutter/material.dart';

class SectionScreen extends StatefulWidget {
  static final String id = "SectionScreen";

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relevamiento visual'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: "Subir foto"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listado")
        ],
      ),
      body: Center(
        child: Text('Soy una sección!'),
      ),
    );
  }
}
