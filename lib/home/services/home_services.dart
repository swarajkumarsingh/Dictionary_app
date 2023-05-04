import 'package:dictionary/news/models/news_model.dart';

abstract class HomeServices {
  Future<News?> getNews();
}
