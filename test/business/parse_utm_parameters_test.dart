import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_utm_parameters.dart';

void main() {
  group('ParseUtmParameters (Issue #192)', () {
    test('captures source and campaign from LinkedIn UTM params', () {
      final attribution = ParseUtmParameters.call({'utm_source': 'linkedin', 'utm_campaign': 'bc_outreach'});
      expect(attribution!.source, 'linkedin');
      expect(attribution.campaign, 'bc_outreach');
    });

    test('campaign is optional', () {
      final attribution = ParseUtmParameters.call({'utm_source': 'linkedin'});
      expect(attribution!.source, 'linkedin');
      expect(attribution.campaign, isNull);
    });

    test('returns null for an organic visit with no utm_source', () {
      expect(ParseUtmParameters.call({}), isNull);
    });

    test('ignores an empty utm_source', () {
      expect(ParseUtmParameters.call({'utm_source': ''}), isNull);
    });
  });
}
