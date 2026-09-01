import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/format_delta_change_label.dart';
import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';

void main() {
  test('formats a positive change with a leading plus sign', () {
    expect(FormatDeltaChangeLabel.call(FinancialDnaDimension.liquidityRatio, 15.4),
        '+15% Liquidity');
  });

  test('formats a negative change without an extra sign', () {
    expect(FormatDeltaChangeLabel.call(FinancialDnaDimension.vendorDiversity, -8.0),
        '-8% Vendor Diversity');
  });

  test('never includes an exact currency amount, only a percentage', () {
    final label = FormatDeltaChangeLabel.call(FinancialDnaDimension.burnVelocity, 5.0);
    expect(label, isNot(contains('\$')));
  });
}
