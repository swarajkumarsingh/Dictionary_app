import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/services/api.dart';

import 'package:dictionary/home/services/home_services.dart';

class HomeServicesImpl extends HomeServices {
  @override
  Future<List<dynamic>?> getNews() async {
    final response = await Api().get(newsApiUrl);

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['articles'];

      return body;
    } 

    return null;
  }
}
