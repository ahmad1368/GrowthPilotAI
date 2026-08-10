import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_session_stale.dart';

void main() {
  final now = DateTime(2026, 6, 1);

  test('a session active within 30 days is not stale', () {
    expect(IsSessionStale.call(now.subtract(const Duration(days: 10)), now), isFalse);
  });

  test('a session inactive for exactly 30 days is stale', () {
    expect(IsSessionStale.call(now.subtract(const Duration(days: 30)), now), isTrue);
  });

  test('a session inactive for more than 30 days is stale', () {
    expect(IsSessionStale.call(now.subtract(const Duration(days: 45)), now), isTrue);
  });
}
