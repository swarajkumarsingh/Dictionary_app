import 'package:flutter/material.dart';

class OnBoardingSCreenButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const OnBoardingSCreenButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) {
              return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
            },
          ),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
}
