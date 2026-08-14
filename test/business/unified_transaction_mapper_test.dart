import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/unified_transaction_mapper.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';
import 'package:growth_pilot_ai/core/enum/verification_status.dart';
import 'package:growth_pilot_ai/core/models/plaid_transaction.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';
import 'package:growth_pilot_ai/core/models/unified_transaction.dart';

void main() {
  group('UnifiedTransaction defaults', () {
    test('applies CAD, uncategorized, pending, empty tags', () {
      final tx = UnifiedTransaction(
        businessId: 'b1',
        transactionId: 't1',
        amount: 10,
        date: DateTime(2027, 1, 1),
        merchantName: 'X',
        source: TransactionSource.manualScan,
      );
      expect(tx.currency, 'CAD');
      expect(tx.category, BusinessCategory.uncategorized);
      expect(tx.status, VerificationStatus.pending);
      expect(tx.tags, isEmpty);
    });
  });

  test('TaxBreakdown.total sums the components rounded to 2 decimals', () {
    const tax = TaxBreakdown(gst: 5.0, pst: 7.0);
    expect(tax.total, 12.0);
  });

  group('UnifiedTransactionMapper.fromPlaid', () {
    test('normalizes a Plaid record with provenance + taxonomy', () {
      const plaid = PlaidTransaction(
        transactionId: 'abc',
        amount: 42.5,
        merchantName: 'Staples',
        category: 'Office Supplies',
      );
      final unified = UnifiedTransactionMapper.fromPlaid(
        plaid,
        businessId: 'biz-1',
        date: DateTime(2027, 3, 2),
      );
      expect(unified.source, TransactionSource.plaid);
      expect(unified.businessId, 'biz-1');
      expect(unified.externalId, 'abc');
      expect(unified.transactionId, 'plaid-abc');
      expect(unified.category, BusinessCategory.officeSupplies);
      expect(unified.rawCategory, 'Office Supplies');
      expect(unified.amount, 42.5);
      expect(unified.currency, 'CAD');
    });
  });
}
