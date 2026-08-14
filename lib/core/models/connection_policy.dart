import 'package:flutter/foundation.dart';

/// Client-side connection tuning for the backend network layer — the Flutter
/// analog of the NestJS/Mongoose connection options (serverSelectionTimeoutMS,
/// socketTimeoutMS, maxPoolSize, retryWrites). Values come from --dart-define
/// so environments (dev/staging/prod) differ without code changes.
@immutable
class ConnectionPolicy {
  final Duration connectTimeout; // fail-fast, ~ serverSelectionTimeoutMS
  final Duration receiveTimeout; // ~ socketTimeoutMS
  final int maxConcurrent; // ~ maxPoolSize
  final bool retryWrites;

  const ConnectionPolicy({
    this.connectTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 45),
    this.maxConcurrent = 10,
    this.retryWrites = true,
  });

  /// A connect timeout of 5s or less means the UI fails fast instead of hanging.
  bool get failsFast => connectTimeout <= const Duration(seconds: 5);

  factory ConnectionPolicy.fromEnvironment() {
    const connectMs =
        int.fromEnvironment('DB_TIMEOUT_MS', defaultValue: 5000);
    const pool = int.fromEnvironment('DB_MAX_POOL', defaultValue: 10);
    return const ConnectionPolicy(
      connectTimeout: Duration(milliseconds: connectMs),
      maxConcurrent: pool,
    );
  }
}
