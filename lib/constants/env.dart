// ignore_for_file: non_constant_identifier_names

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

  String get getSentryEnvironment {
    return dotenv.get(environmentVariables.SENTRY_ENVIRONMENT,
        fallback: environmentVariables.LOCAL);
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

final environmentVariables = _EnvironmentVariables();

class _EnvironmentVariables {
  final String ENV_SENTRY_DNS = "SENTRY_DSN";
  final String SENTRY_ENVIRONMENT = "SENTRY_ENVIRONMENT";
  final String LOCAL = "local";
}
