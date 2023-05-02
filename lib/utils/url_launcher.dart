// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:url_launcher/url_launcher.dart';

final urlLauncher = _UrlLauncher();

class _UrlLauncher {
  
Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}