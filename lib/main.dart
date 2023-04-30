import 'package:dictionary/constants/env.dart';
import 'package:dictionary/my_app.dart';
import 'package:flutter/material.dart';

Future main() => _init();

Future<void> _init() async {
  await environmentVariables.initEnv();
  runApp(const MyApp());
}
