import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_referral_code.dart';

void main() {
  final issuedAt = DateTime(2026, 1, 1);

  test('is deterministic for the same inputs', () {
    final a = GenerateReferralCode.call('Alpha', 'beta@example.com', issuedAt);
    final b = GenerateReferralCode.call('Alpha', 'beta@example.com', issuedAt);
    expect(a, b);
  });

  test('differs for different contacts', () {
    final a = GenerateReferralCode.call('Alpha', 'beta@example.com', issuedAt);
    final b = GenerateReferralCode.call('Alpha', 'gamma@example.com', issuedAt);
    expect(a, isNot(b));
  });

  test('is an 8-character uppercase code', () {
    final code = GenerateReferralCode.call('Alpha', 'beta@example.com', issuedAt);
    expect(code.length, 8);
    expect(code, code.toUpperCase());
  });
}
