import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_tax_deduction.dart';

void main() {
  test('applies the simulated flat rate to fee revenue', () {
    expect(ComputeTaxDeduction.call(100), 5.0);
  });

  test('returns zero for zero revenue', () {
    expect(ComputeTaxDeduction.call(0), 0.0);
  });
}
