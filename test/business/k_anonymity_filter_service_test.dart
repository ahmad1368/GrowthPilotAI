import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/k_anonymity_filter_service.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';

AnonymousRecord _record(String region, String period) => AnonymousRecord(
      orgHash: 'h',
      period: period,
      region: region,
      amount: 1,
    );

void main() {
  test('drops records whose region+period group is smaller than k', () {
    final records = [
      _record('V3J', '2027-03'),
      _record('V3J', '2027-03'),
      _record('V3J', '2027-03'),
      _record('V3J', '2027-03'),
      _record('V3J', '2027-03'),
      _record('X1X', '2027-03'), // group of 1 — should be suppressed
    ];

    final filtered = KAnonymityFilterService().filter(records, k: 5);

    expect(filtered.length, 5);
    expect(filtered.every((r) => r.region == 'V3J'), isTrue);
  });

  test('default k=5 keeps a large enough group intact', () {
    final records = List.generate(5, (_) => _record('V3J', '2027-03'));
    expect(KAnonymityFilterService().filter(records), records);
  });
}
