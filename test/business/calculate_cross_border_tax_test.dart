import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/calculate_cross_border_tax.dart';

void main() {
  test('an export sale has zero GST/PST and a duty estimate', () {
    final result = CalculateCrossBorderTax.call(1000, isExport: true, applyPst: true);
    expect(result.tax.gst, 0);
    expect(result.tax.pst, 0);
    expect(result.dutyEstimate, 50); // 5% placeholder
  });

  test('a domestic sale falls back to the normal GST/PST engine', () {
    final result = CalculateCrossBorderTax.call(1000, isExport: false, applyPst: true);
    expect(result.tax.gst, 50);
    expect(result.tax.pst, 70);
    expect(result.dutyEstimate, isNull);
  });
}
