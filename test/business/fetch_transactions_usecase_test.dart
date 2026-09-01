import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/fetch_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/interfaces/transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/transaction_sync_page.dart';

/// Service that always fails, to verify error propagation.
class _FailingFetch implements TransactionFetchService {
  @override
  OmniResult<TransactionSyncPage> fetchIncremental(String? cursor) async =>
      OmniResponse.error('plaid down', statusCode: 503);
}

void main() {
  test('pages through the cursor loop, applying add/modify/remove', () async {
    final usecase = FetchTransactionsUseCase(MockTransactionFetchService());
    final response = await usecase.fetchAll();

    expect(response.success, isTrue);
    final byId = {for (final t in response.data!) t.transactionId: t};
    // t2 was removed on page 2; t1 modified; t3 added.
    expect(byId.keys.toSet(), {'t1', 't3'});
    expect(byId['t1']!.amount, 45.00); // modified value wins (dedup upsert)
    expect(byId.containsKey('t2'), isFalse);
  });

  test('propagates a fetch failure', () async {
    final usecase = FetchTransactionsUseCase(_FailingFetch());
    final response = await usecase.fetchAll();
    expect(response.success, isFalse);
    expect(response.statusCode, 503);
  });
}
