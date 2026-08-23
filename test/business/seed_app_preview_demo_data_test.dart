import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_app_preview_demo_data.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

void main() {
  group('SeedAppPreviewDemoData (Issue #195)', () {
    test('builds a Toronto vendor with Ontario HST applied', () {
      final tx = SeedAppPreviewDemoData.call();

      expect(tx.merchantName, contains('Toronto'));
      expect(tx.source, TransactionSource.manualScan);
      expect(tx.hst, closeTo(1240.0 * 0.13, 0.01));
      expect(tx.gst, 0.0);
      expect(tx.pst, 0.0);
    });

    test('total equals subtotal plus HST', () {
      final tx = SeedAppPreviewDemoData.call();
      expect(tx.amount, closeTo(1240.0 + tx.hst, 0.01));
    });

    test('has a stable externalId so re-seeding upserts instead of duplicating', () {
      final first = SeedAppPreviewDemoData.call();
      final second = SeedAppPreviewDemoData.call();
      expect(first.externalId, second.externalId);
    });
  });
}
