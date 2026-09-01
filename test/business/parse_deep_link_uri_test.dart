import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_deep_link_uri.dart';

void main() {
  group('ParseDeepLinkUri', () {
    test('resolves a known path to the matching route name', () {
      final route = ParseDeepLinkUri.call(Uri.parse('growthpilotai://inbox'));

      expect(route, isNotNull);
      expect(route!.routeName, '/inbox');
    });

    test('resolves a known nested path', () {
      final route =
          ParseDeepLinkUri.call(Uri.parse('growthpilotai://requirements/traceability/matrix'));

      expect(route!.routeName, '/requirements/traceability/matrix');
    });

    test('preserves query parameters (Issue #176 AC: state preservation)', () {
      final route = ParseDeepLinkUri.call(Uri.parse('growthpilotai://inbox?from=promo&category=tools'));

      expect(route!.queryParameters, {'from': 'promo', 'category': 'tools'});
    });

    test('returns null for an unrecognized path (Issue #176 AC: graceful failure)', () {
      final route = ParseDeepLinkUri.call(Uri.parse('growthpilotai://unknown/path'));

      expect(route, isNull);
    });

    test('returns null for the bare scheme with no path', () {
      final route = ParseDeepLinkUri.call(Uri.parse('growthpilotai://'));

      expect(route, isNull);
    });
  });
}
