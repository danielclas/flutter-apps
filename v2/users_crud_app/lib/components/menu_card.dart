import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:users_crud_app/utils/hex_color.dart';
import '../utils/extension_methods.dart';

class MenuCard extends StatefulWidget {
  bool enabled;

  MenuCard({this.enabled = false});

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                  color: Color(0xff757575),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
                      ),
                      TextField(
                        autofocus: true,
                        textAlign: TextAlign.center,
                      ),
                      MaterialButton(
                        onPressed: () => null,
                        child: Text('Add'),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ));
      },
      child: Material(
        shadowColor: HexColor('e84545'),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('e84545')),
              color: HexColor('903749'),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
              width: 40.percentOf(context.width),
              height: 35.percentOf(context.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('card title'), Image(image: Svg('images/login.svg'))],
              )),
        ),
      ),
    );
  }
}
