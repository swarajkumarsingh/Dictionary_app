import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../utils/url_launcher.dart';

class DropMenu extends StatelessWidget {
  const DropMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: PopupMenuButton(
        color: colors.white,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: GestureDetector(
              onTap: () => urlLauncher.launchURL(
                "https://github.com/swarajkumarsingh",
              ),
              child: const Text("Github"),
            ),
          ),
          PopupMenuItem(
            child: GestureDetector(
              onTap: () => urlLauncher.launchURL(
                "https://instagram.com/swaraj_singh_4444",
              ),
              child: const Text("Instagram"),
            ),
          ),
          PopupMenuItem(
            child: GestureDetector(
              onTap: () => urlLauncher.launchURL(
                "https://www.linkedin.com/in/swaraj-kumar-singh-a65ab922a/",
              ),
              child: const Text("Linkedin"),
            ),
          ),
        ],
        child: const Icon(
          Icons.more_vert_outlined,
          size: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}
