import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Step 1: MaterialApp(
// navigatorKey: navigatorKey,

// Usage --> () => AppRouter.pushNamed("/home-screen")
final appRouter = _AppRouter();

class _AppRouter {
  push(Widget page) => navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => page),
      );

  pushOFFAll(Widget page) => navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page),
        (Route<dynamic> route) => false,
      );

  pushNamed(String routeName) =>
      navigatorKey.currentState?.pushNamed(routeName);

  pop() => navigatorKey.currentState?.pop();
}
