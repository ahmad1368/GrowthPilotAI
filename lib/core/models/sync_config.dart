import 'package:growth_pilot_ai/core/enum/sync_environment.dart';

/// Client-side view of the sync backend connection settings — the Flutter
/// analog of the NestJS `.env` (MONGO_URI / PORT / NODE_ENV). Values come from
/// compile-time `--dart-define` flags, so no endpoint or secret is hardcoded
/// in source. Pure Dart, web-safe (no dart:io).
class SyncConfig {
  final String baseUrl;
  final int port;
  final SyncEnvironment environment;

  const SyncConfig({
    required this.baseUrl,
    this.port = 3000,
    this.environment = SyncEnvironment.development,
  });

  bool get isConfigured => baseUrl.isNotEmpty;

  factory SyncConfig.fromEnvironment() {
    const env =
        String.fromEnvironment('NODE_ENV', defaultValue: 'development');
    return const SyncConfig(
      baseUrl: String.fromEnvironment('SYNC_BASE_URL'),
      port: int.fromEnvironment('PORT', defaultValue: 3000),
      environment: env == 'production'
          ? SyncEnvironment.production
          : SyncEnvironment.development,
    );
  }
}
