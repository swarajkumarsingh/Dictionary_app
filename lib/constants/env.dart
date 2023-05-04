// ignore_for_file: non_constant_identifier_names

import 'package:dictionary/constants/env_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final env = _Environment();

class _Environment {
  Future<void> initEnv() async {
    await dotenv.load(fileName: env.fileName);
  }

  String get getSentryDSN {
    return dotenv.get(environmentVariables.ENV_SENTRY_DNS, fallback: "");
  }

  String get NEWS_BASE_URL {
    return dotenv.get(environmentVariables.NEWS_BASE_URL, fallback: "");
  }

  String get DICTIONARY_BASE_URL {
    return dotenv.get(environmentVariables.DICTIONARY_BASE_URL, fallback: "");
  }

  String get getSentryEnvironment {
    return dotenv.get(
      environmentVariables.SENTRY_ENVIRONMENT,
      fallback: environmentVariables.LOCAL,
    );
  }

  String getString(String key, {String defaultValue = ""}) {
    return dotenv.get(key, fallback: defaultValue);
  }

  String get fileName {
    if (kReleaseMode) {
      return ".env.production";
    }
    return ".env.development";
  }
}
