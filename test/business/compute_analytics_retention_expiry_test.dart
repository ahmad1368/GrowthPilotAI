import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_analytics_retention_expiry.dart';

void main() {
  test('adds the 1-year retention period to the recorded time', () {
    final recordedAt = DateTime.utc(2027, 3, 14, 15);
    // 365 days from a date whose following year contains a Feb 29 lands
    // one day short of the same calendar date next year.
    expect(ComputeAnalyticsRetentionExpiry.call(recordedAt), DateTime.utc(2028, 3, 13, 15));
  });
}
