import 'package:flutter_tts/flutter_tts.dart';

class Tts {
  static FlutterTts _flutterTts;
  static String description = "Short test one two three";
  static bool isPlaying = false;

  static void setTtsLanguage(String language) async {
    if (_flutterTts == null) {
      initializeTts();
    }

    await _flutterTts.setLanguage(language);
  }

  static Future speak(String text) async {
    if (_flutterTts == null) {
      initializeTts();
    }

    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts.speak(text);
      if (result == 1) {
        isPlaying = true;
      }
    }
  }

  static Future stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) {
      isPlaying = false;
    }
  }

  static initializeTts() {
    _flutterTts = FlutterTts();

    _flutterTts.ttsInitHandler(() {
      setTtsLanguage('en-US');
    });

    _flutterTts.setStartHandler(() {
      isPlaying = true;
    });

    _flutterTts.setCompletionHandler(() {
      isPlaying = false;
    });

    _flutterTts.setErrorHandler((err) {
      isPlaying = false;
    });
  }
}
