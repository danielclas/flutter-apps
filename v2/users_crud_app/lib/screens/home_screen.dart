import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:users_crud_app/utils/hex_color.dart';
import '../utils/extension_methods.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: HexColor('2b2e4a')),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text('I AM A TITLE'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box(),
                  Box(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box(),
                  Box(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
          width: 40.percentOf(context.width),
          height: 35.percentOf(context.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('card title'), Image(image: Svg('images/login.svg'))],
          )),
    );
  }
}
