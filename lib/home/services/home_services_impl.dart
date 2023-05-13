import '../../constants/constants.dart';
import '../../news/models/news_model.dart';
import '../../services/api.dart';
import 'home_services.dart';

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
