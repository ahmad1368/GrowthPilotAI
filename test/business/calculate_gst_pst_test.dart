import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';

void main() {
  test('applies 5% GST and 7% PST when applicable', () {
    final tax = CalculateGstPst.call(100, applyPst: true);
    expect(tax.gst, 5.0);
    expect(tax.pst, 7.0);
    expect(tax.total, 12.0);
  });

  test('skips PST when not applicable, GST-only', () {
    final tax = CalculateGstPst.call(100, applyPst: false);
    expect(tax.gst, 5.0);
    expect(tax.pst, 0.0);
    expect(tax.total, 5.0);
  });

  test('rounds to the cent for non-round subtotals', () {
    final tax = CalculateGstPst.call(19.99, applyPst: true);
    expect(tax.gst, 1.0);
    expect(tax.pst, 1.4);
  });
}
