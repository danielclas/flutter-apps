import 'package:flutter/material.dart';
import './components/camera_component.dart';

class LikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LikePageState();
  }
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CameraComponent());
  }
}
