// ignore_for_file: non_constant_identifier_names

import 'package:flutter_tts/flutter_tts.dart';

import '../utils/env/env.dart';


const String poppingFont = 'Poppins';

String sentryDSN = env.getSentryDSN;
String sentryEnvironment = env.getSentryEnvironment;

String newsApiUrl = env.NEWS_BASE_URL;
String DICTIONARY_BASE_URL = env.DICTIONARY_BASE_URL;

FlutterTts flutterTts = FlutterTts();

const String newsTitleStatic = "Breaking News";
const String newsImageStatic =
    "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg";
