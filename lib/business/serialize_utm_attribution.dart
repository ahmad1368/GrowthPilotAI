import 'dart:convert';
import 'package:growth_pilot_ai/core/models/utm_attribution.dart';

/// Encodes [UtmAttribution] for [SecureStorageService] (Issue #192) so it
/// survives from first landing to the eventual Founding Member claim.
class SerializeUtmAttribution {
  static String call(UtmAttribution attribution) =>
      jsonEncode({'source': attribution.source, 'campaign': attribution.campaign});
}
