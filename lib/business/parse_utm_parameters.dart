import 'package:growth_pilot_ai/core/models/utm_attribution.dart';

/// Reads `utm_source`/`utm_campaign` off the landing URL's query string
/// (Issue #192: `?utm_source=linkedin&utm_campaign=bc_outreach`). No
/// `utm_source` means an organic/direct visit — nothing to attribute.
class ParseUtmParameters {
  static UtmAttribution? call(Map<String, String> queryParameters) {
    final source = queryParameters['utm_source'];
    if (source == null || source.isEmpty) return null;
    return UtmAttribution(source: source, campaign: queryParameters['utm_campaign']);
  }
}
