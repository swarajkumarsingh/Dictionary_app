import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/news/models/news_model.dart';
import 'package:dictionary/services/api.dart';

import 'package:dictionary/home/services/home_services.dart';

class HomeServicesImpl extends HomeServices {
  @override
  Future<News?> getNews() async {
    final response = await Api().get(newsApiUrl);

    if (response.statusCode == 200) {
      return News.fromJson(response.data);
    }

    return null;
  }
}
