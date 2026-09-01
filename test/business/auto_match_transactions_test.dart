import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/auto_match_transactions.dart';
import 'package:growth_pilot_ai/business/seed_demo_unified_transactions.dart';

void main() {
  test('auto-merges the seeded Home Depot pair and leaves the unrelated one alone', () {
    final all = SeedDemoUnifiedTransactions.call([]);

    final merged = AutoMatchTransactions.call(all);

    expect(merged.length, 1);
    final (bankTx, accountingTx) = merged.single;
    expect({bankTx.externalId, accountingTx.externalId}, {'plaid-hd-451', 'qbo-hd-9001'});
    expect(all.firstWhere((t) => t.externalId == 'xero-utilities-77').isMerged, isFalse);
  });
}
