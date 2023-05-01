final config = _Config();

class _Config {
  String applicationName = "Dictionary";
  String packageName = "com.example.dictionary";
  String packageNameIOS = "com.example.dictionary";
}

final bool isInProduction = isDebugModeCustom == false ? false : true;

bool get isDebugModeCustom {
  bool value = false;
  assert(() {
    value = true;
    return true;
  }());
  return value;
}
