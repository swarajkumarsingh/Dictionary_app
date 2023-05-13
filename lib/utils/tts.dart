import 'dart:io';

import '../constants/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'snackbar.dart';

final tts = _TTS(flutterTts);
String _erroOccured = "Error occured";

class _TTS {
  _TTS(this._flutterTts);
  final FlutterTts _flutterTts;

  // getter for tts package
  FlutterTts get getTTS => _flutterTts;

  Future<void> init() async {
    if (Platform.isIOS) {
      await _flutterTts.setSharedInstance(true);
    }
  }

  Future<void> speak(String content) async {
    try {
      await _flutterTts.speak(content);
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }

  Future<void> pause() async {
    try {
      await _flutterTts.pause();
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      showSnackBar(msg: _erroOccured);
    }
  }
}
