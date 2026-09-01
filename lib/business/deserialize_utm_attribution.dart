import 'dart:convert';
import 'package:growth_pilot_ai/core/models/utm_attribution.dart';

/// Decodes what [SerializeUtmAttribution] wrote (Issue #192) — no prior
/// visit, or corrupted storage, both mean "nothing to attribute".
class DeserializeUtmAttribution {
  static UtmAttribution? call(String? stored) {
    if (stored == null) return null;
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      final source = map['source'] as String?;
      if (source == null) return null;
      return UtmAttribution(source: source, campaign: map['campaign'] as String?);
    } catch (_) {
      return null;
    }
  }
}
