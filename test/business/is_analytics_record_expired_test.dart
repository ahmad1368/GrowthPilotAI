import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_analytics_record_expired.dart';

void main() {
  final expireAt = DateTime.utc(2028, 1, 1);

  test('is not expired before the expiry time', () {
    expect(IsAnalyticsRecordExpired.call(expireAt, DateTime.utc(2027, 12, 31)), isFalse);
  });

  test('is expired after the expiry time', () {
    expect(IsAnalyticsRecordExpired.call(expireAt, DateTime.utc(2028, 1, 2)), isTrue);
  });

  test('is not yet expired exactly at the expiry instant', () {
    expect(IsAnalyticsRecordExpired.call(expireAt, expireAt), isFalse);
  });
}
