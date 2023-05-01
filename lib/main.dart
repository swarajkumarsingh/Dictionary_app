// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:isolate';

import 'package:dictionary/config.dart';
import 'package:dictionary/constants/env.dart';
import 'package:dictionary/error_tracker/error_tracker.dart';
import 'package:dictionary/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

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
