import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'snackbar.dart';

final tts = _TTS(_flutterTts);

FlutterTts _flutterTts = FlutterTts();
String _erroOccured = "Error occured";

class _TTS {
  _TTS(this.flutterTts);
  final FlutterTts flutterTts;

  Future<void> init() async {
    if (Platform.isIOS) {
      await _flutterTts.setSharedInstance(true);
    }
  }

  Future<void> speak(String content) async {
    try {
      await flutterTts.speak(content);
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }

  Future<void> pause() async {
    try {
      await flutterTts.pause();
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }

  Future<void> stop(String content) async {
    try {
      await flutterTts.stop();
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }
}
