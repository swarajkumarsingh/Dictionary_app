// ignore_for_file: non_constant_identifier_names

import 'package:dictionary/common/string_extension.dart';
import 'package:dictionary/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sf = _SFClass();

class _SFClass {
  String DICTIONARY_HISTORY = "DICTIONARY_HISTORY";
  String IS_NEW_USER = "IS_NEW_USER";

  Future<List<String>> getDictionaryHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> result = prefs.getStringList(DICTIONARY_HISTORY) ?? [];
    return result;
  }

  Future<List<String>> saveDictionaryHistory(String prompt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> result = prefs.getStringList(DICTIONARY_HISTORY) ?? [];
    if (result.contains(prompt.capitalize)) {
      return result;
    }
    result.add(prompt.capitalize);
    bool isInserted = await prefs.setStringList(DICTIONARY_HISTORY, result);
    if (isInserted == false) {
      showSnackBar(msg: "Unable able to add Dictionary history");
    }
    return result;
  }

  Future<void> clearDictionaryHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDeleted = await prefs.remove(DICTIONARY_HISTORY);
    if (!isDeleted) {
      return showSnackBar(msg: "Failed to clear history");
    }
    return showSnackBar(msg: "Dictionary history cleared");
  }

  Future<void> registerNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDeleted = await prefs.setBool(IS_NEW_USER, false);
    if (!isDeleted) {
      return showSnackBar(msg: "Failed to register");
    }
  }

  Future<bool> isNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(IS_NEW_USER) ?? true;
  }

  Future<void> deleteRegisterNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDeleted = await prefs.remove(IS_NEW_USER);
    if (!isDeleted) {
      return showSnackBar(msg: "Failed to log out");
    }
    return showSnackBar(msg: "User deleted");
  }
}
