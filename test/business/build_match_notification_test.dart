import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_match_notification.dart';

void main() {
  test('links to the matched listing without exposing pricing or identity', () {
    final notification = BuildMatchNotification.call(42, DateTime(2026, 1, 1));
    expect(notification.metadataRefType, 'CatalogListing');
    expect(notification.metadataRefId, '42');
    expect(notification.body, isNot(contains('\$')));
  });
}
