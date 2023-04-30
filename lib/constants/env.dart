import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final environmentVariables = _Environment();

class _Environment {
  final String _ENV_SENTRY_DNS = "ENV_SENTRY_DSN";

  // addition fun

  String get fileName {
    if (kReleaseMode) {
      return ".env.production";
    }
    return ".env.development";
  }

  String get getSentryDSN {
    return dotenv.get(_ENV_SENTRY_DNS, fallback: "");
  }

  Future<void> initEnv() async {
    await dotenv.load(fileName: environmentVariables.fileName);
  }

  String getString(String key, {String fallback = ""}) {
    return dotenv.get(key, fallback: fallback);
  }
}
