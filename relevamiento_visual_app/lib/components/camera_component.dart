import 'package:flutter/material.dart';
import 'package:relevamiento_visual_app/constants.dart';
import 'package:camera/camera.dart';

class CameraComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraComponentState();
  }
}

class _CameraComponentState extends State<CameraComponent> {
  CameraController frontCamera;
  CameraController backCamera;
  Future<void> _initializeControllerFuture;

  void initCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();

    backCamera = CameraController(cameras[0], ResolutionPreset.medium);
    frontCamera = CameraController(cameras[1], ResolutionPreset.medium);
  }

  @override
  void initState() {
    super.initState();
    initCameras();
    _initializeControllerFuture = backCamera.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Relevamiento visual',
              style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/back.png'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('images/camera.png'),
                height: 180.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Subir una foto',
                    style: kTitlesTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    backCamera.dispose();
    super.dispose();
  }
}
