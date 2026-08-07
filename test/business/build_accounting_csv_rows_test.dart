import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_accounting_csv_rows.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';

void main() {
  test('maps each summary to a flat row', () {
    const summary = MerchantAccountingSummary(
      merchantName: 'Alpha',
      totalFees: 10,
      totalWaived: 5,
      totalPayouts: 100,
      taxDeduction: 0.5,
      netEarnings: 9.5,
    );
    final rows = BuildAccountingCsvRows.call([summary]);
    expect(rows.single, {
      'merchantName': 'Alpha',
      'totalFees': 10.0,
      'totalWaived': 5.0,
      'totalPayouts': 100.0,
      'taxDeduction': 0.5,
      'netEarnings': 9.5,
    });
  });

  test('returns an empty list for no summaries', () {
    expect(BuildAccountingCsvRows.call([]), isEmpty);
  });
}
