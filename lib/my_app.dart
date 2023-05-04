import 'package:dictionary/home/screens/home_screen.dart';
import 'package:dictionary/utils/logger.dart';
import 'package:dictionary/utils/sf.dart';
import 'package:flutter/material.dart';

import 'onboard/screens/onboarding_screen.dart';
import 'utils/navigator.dart';
import 'utils/network/network_utils.dart';
import 'utils/snackbar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNewUser = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    networkUtils.checkNet();
    bool isNewUser = await sf.isNewUser();

    setState(() {
      _isNewUser = isNewUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S Dictionary',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: _isNewUser ? const OnBoardingScreen() : const HomeScreen(),
    );
  }
}
