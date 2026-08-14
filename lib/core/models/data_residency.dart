import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/data_region.dart';

/// Client-visible reflection of where and how the backend stores data — the
/// Flutter-side counterpart of the MongoDB Atlas provisioning. Lets the app
/// surface the PIPA/PIPEDA compliance narrative. Values come from --dart-define.
@immutable
class DataResidency {
  final DataRegion region;
  final bool encryptedAtRest;
  final double minTlsVersion;

  const DataResidency({
    required this.region,
    this.encryptedAtRest = true,
    this.minTlsVersion = 1.2,
  });

  /// Canadian residency + AES-256 at rest + TLS >= 1.2 satisfies the PIPA/PIPEDA
  /// "safeguards" narrative for BC businesses.
  bool get isPipaCompliant =>
      region.isCanadian && encryptedAtRest && minTlsVersion >= 1.2;

  factory DataResidency.fromEnvironment() {
    const code =
        String.fromEnvironment('DATA_REGION', defaultValue: 'ca-central-1');
    return DataResidency(region: _parse(code));
  }

  static DataRegion _parse(String code) {
    switch (code.toLowerCase()) {
      case 'ca-central-1':
        return DataRegion.caCentral;
      case 'us-east-1':
        return DataRegion.usEast;
      case 'eu-west-1':
        return DataRegion.euWest;
      default:
        return DataRegion.unknown;
    }
  }
}
