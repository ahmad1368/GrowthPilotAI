import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_trust_badge.dart';
import 'package:growth_pilot_ai/core/enum/trust_badge.dart';

void main() {
  test('elite above 9.0', () {
    expect(ResolveTrustBadge.call(9.5), TrustBadge.elite);
  });

  test('verified pro above 7.5 but at or below 9.0', () {
    expect(ResolveTrustBadge.call(8.0), TrustBadge.verifiedPro);
    expect(ResolveTrustBadge.call(9.0), TrustBadge.verifiedPro);
  });

  test('standard at or below 7.5', () {
    expect(ResolveTrustBadge.call(7.5), TrustBadge.standard);
    expect(ResolveTrustBadge.call(2.0), TrustBadge.standard);
  });
}
