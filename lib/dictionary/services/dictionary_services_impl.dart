import 'package:dictionary/constants/status_code.dart';
import 'package:dictionary/dictionary/models/dictionary.dart';
import 'package:dictionary/dictionary/services/dictionary_services.dart';
import 'package:dictionary/services/api.dart';

final dictionaryServicesImpl = DictionaryServicesImpl();

class DictionaryServicesImpl extends DictionaryServices {
  @override
  Future<Dictionary?> get(String prompt) async {
    final response = await Api()
        .get("https://api.dictionaryapi.dev/api/v2/entries/en/$prompt");

    if (response.statusCode == STATUS_OK) {
      return Dictionary.fromJson(response.data[0]);
    }

    return null;
  }
}
