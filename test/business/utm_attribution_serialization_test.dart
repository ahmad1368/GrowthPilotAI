import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deserialize_utm_attribution.dart';
import 'package:growth_pilot_ai/business/serialize_utm_attribution.dart';
import 'package:growth_pilot_ai/core/models/utm_attribution.dart';

void main() {
  group('UTM attribution round-trip (Issue #192)', () {
    test('serialize then deserialize preserves source and campaign', () {
      const attribution = UtmAttribution(source: 'linkedin', campaign: 'bc_outreach');
      final restored = DeserializeUtmAttribution.call(SerializeUtmAttribution.call(attribution));

      expect(restored!.source, 'linkedin');
      expect(restored.campaign, 'bc_outreach');
    });

    test('deserialize returns null for no prior storage', () {
      expect(DeserializeUtmAttribution.call(null), isNull);
    });

    test('deserialize returns null for corrupted storage', () {
      expect(DeserializeUtmAttribution.call('not json'), isNull);
    });
  });
}
