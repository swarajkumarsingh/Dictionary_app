import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

// Step 1: MaterialApp(
//    scaffoldMessengerKey: snackbarKey

// Step 2: () => showSnackBar()

void showSnackBar({String msg = "Unexpected error occurred"}) {
  final SnackBar snackBar = SnackBar(content: Text(msg));
  snackbarKey.currentState?.showSnackBar(snackBar);
}
