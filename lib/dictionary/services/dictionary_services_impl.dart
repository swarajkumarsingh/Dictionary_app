import 'package:dictionary/constants/status_code.dart';
import 'package:dictionary/dictionary/models/dictionary.dart';
import 'package:dictionary/dictionary/services/dictionary_services.dart';
import 'package:dictionary/services/api.dart';
import 'package:dictionary/utils/snackbar.dart';

final dictionaryServicesImpl = DictionaryServicesImpl();

class DictionaryServicesImpl extends DictionaryServices {
  @override
  Future<Dictionary?> get(String prompt) async {
    try {
      final response = await Api()
          .get("https://api.dictionaryapi.dev/api/v2/entries/en/$prompt");

      if (response.statusCode != STATUS_OK) {
        throw "Unable to connect with the dictionary";
      }
      return Dictionary.fromJson(response.data[0]);
    } catch (e) {
      showSnackBar(msg: e.toString());
    }
    return null;
  }
}
