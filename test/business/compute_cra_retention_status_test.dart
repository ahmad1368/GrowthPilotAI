import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cra_retention_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('is within the statutory period just after logging', () {
    expect(ComputeCraRetentionStatus.isWithinStatutoryPeriod(now, now), true);
  });

  test('is past the statutory period after 6+ years', () {
    final loggedAt = now.subtract(const Duration(days: 365 * 6 + 1));
    expect(ComputeCraRetentionStatus.isWithinStatutoryPeriod(loggedAt, now), false);
  });

  test('remaining time never goes negative', () {
    final loggedAt = now.subtract(const Duration(days: 365 * 10));
    expect(ComputeCraRetentionStatus.remaining(loggedAt, now), Duration.zero);
  });
}
