import 'package:flutter/material.dart';
import 'camera_page.dart';

class DislikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DislikePageState();
  }
}

class _DislikePageState extends State<DislikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CameraComponent());
  }
}
