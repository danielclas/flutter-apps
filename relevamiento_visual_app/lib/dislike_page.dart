import 'package:flutter/material.dart';
import './components/camera_component.dart';

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
