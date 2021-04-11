import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/login_service.dart';
import '../classes/person.dart';

int count = 0;

class PersonCard extends StatefulWidget {
  Person person;

  PersonCard(this.person);

  @override
  State<StatefulWidget> createState() {
    return _PersonCardState();
  }
}

class _PersonCardState extends State<PersonCard> {
  String formatNombre() {
    String nombre = widget.person.nombre[0].toUpperCase() +
        widget.person.nombre.substring(1);
    String apellidos = widget.person.apellidos[0].toUpperCase() +
        widget.person.apellidos.substring(1);

    return nombre + ' ' + apellidos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.orange[200], width: 2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nombre: ' + formatNombre()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('DNI: ' + widget.person.dni.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Correo: ' + widget.person.correo),
                  ),
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.person,
                      size: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
