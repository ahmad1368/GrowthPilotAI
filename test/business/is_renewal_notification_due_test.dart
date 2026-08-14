import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_renewal_notification_due.dart';

void main() {
  final periodEnd = DateTime(2026, 1, 10);

  test('not due more than 3 days before the renewal', () {
    expect(IsRenewalNotificationDue.call(periodEnd, DateTime(2026, 1, 6)), isFalse);
  });

  test('due exactly 3 days before the renewal', () {
    expect(IsRenewalNotificationDue.call(periodEnd, DateTime(2026, 1, 7)), isTrue);
  });

  test('no longer due once the renewal date has passed', () {
    expect(IsRenewalNotificationDue.call(periodEnd, DateTime(2026, 1, 11)), isFalse);
  });
}
