import 'env.dart';

const String poppingFont = 'Poppins';

String sentryDSN = env.getSentryDSN;
String sentryEnvironment = env.getSentryEnvironment;

String newsApiUrl = env.getNewsApi;

const String newsTitleStatic = "Breaking News";
const String newsImageStatic =
    "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg";
