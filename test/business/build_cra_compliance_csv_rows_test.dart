import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_cra_compliance_csv_rows.dart';
import 'package:growth_pilot_ai/core/enum/tax_category.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';

void main() {
  test('maps each compliance row to a flat CSV row', () {
    final row = CraComplianceRow(
      loggedAt: DateTime(2026, 1, 1),
      counterpartyName: 'Beta',
      amount: 100,
      currency: 'CAD',
      exchangeRateAtSettlement: 1,
      taxCategory: TaxCategory.businessIncome,
      transactionHash: 'hash-1',
      integrityValid: true,
    );
    final rows = BuildCraComplianceCsvRows.call([row]);
    expect(rows.single['counterpartyName'], 'Beta');
    expect(rows.single['taxCategory'], 'businessIncome');
    expect(rows.single['integrityValid'], true);
  });

  test('returns an empty list for no rows', () {
    expect(BuildCraComplianceCsvRows.call([]), isEmpty);
  });
}
