import 'package:dictionary/dictionary/models/dictionary.dart';

abstract class DictionaryServices {
  Future<Dictionary?> get(String prompt);
}
