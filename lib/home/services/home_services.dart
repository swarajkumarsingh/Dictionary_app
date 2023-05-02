import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class HomeServices {
  Future<List<dynamic>> getNews() async {
    http.Response response = await http.get(Uri.parse(newsApiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      return body;
    } else {
      throw ("NO Articles");
    }
  }
}
