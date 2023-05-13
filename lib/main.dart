import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config.dart';
import 'my_app.dart';
import 'utils/env/env.dart';
import 'error_tracker/error_tracker.dart';

void main() => _init();

Future<void> _init() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await env.initEnv();

    FlutterError.onError = errorTracker.onFlutterError;

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      if (isInProduction) {
        final List<dynamic> errorAndStacktrace = pair;
        errorTracker.firebaseRecordError(errorAndStacktrace);
        Restart.restartApp();
      }
    }).sendPort);

    runApp(const MyApp());
  }, errorTracker.captureError);
}