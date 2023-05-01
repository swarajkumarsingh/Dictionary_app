import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.size = 80.0, this.semanticsLabel})
      : super(key: key);

  final double size;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircularProgressIndicator(
          color: Colors.white70,
          strokeWidth: 2.0,
          semanticsLabel: semanticsLabel,
        ),
      ),
    );
  }
}
