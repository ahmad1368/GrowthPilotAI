import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';
import 'package:growth_pilot_ai/core/enum/canadian_province.dart';

void main() {
  group('BC (Issue #146)', () {
    test('applies 5% GST and 7% PST when applicable', () {
      final tax = CalculateGstPst.call(100, applyPst: true);
      expect(tax.gst, 5.0);
      expect(tax.pst, 7.0);
      expect(tax.hst, 0.0);
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

    test('defaults to BC when no province is given', () {
      final tax = CalculateGstPst.call(100, applyPst: true);
      final explicitBc = CalculateGstPst.call(100, applyPst: true, province: CanadianProvince.bc);
      expect(tax.total, explicitBc.total);
      expect(tax.gst, explicitBc.gst);
      expect(tax.pst, explicitBc.pst);
    });
  });

  group('Ontario HST (Issue #205)', () {
    test('applies a single 13% harmonized rate, no separate GST/PST line', () {
      final tax = CalculateGstPst.call(100, applyPst: true, province: CanadianProvince.ontario);
      expect(tax.hst, 13.0);
      expect(tax.gst, 0.0);
      expect(tax.pst, 0.0);
      expect(tax.total, 13.0);
    });

    test('applyPst is irrelevant in Ontario (harmonized, no separate PST)', () {
      final withPstFlag = CalculateGstPst.call(100, applyPst: true, province: CanadianProvince.ontario);
      final withoutPstFlag = CalculateGstPst.call(100, applyPst: false, province: CanadianProvince.ontario);
      expect(withPstFlag.total, withoutPstFlag.total);
    });

    test('zero subtotal yields zero tax', () {
      final tax = CalculateGstPst.call(0, applyPst: true, province: CanadianProvince.ontario);
      expect(tax.total, 0.0);
    });

    test('rounds to the cent for non-round subtotals', () {
      final tax = CalculateGstPst.call(19.99, applyPst: true, province: CanadianProvince.ontario);
      expect(tax.hst, 2.6);
    });
  });
}
