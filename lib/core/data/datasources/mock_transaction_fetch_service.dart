import 'package:growth_pilot_ai/core/interfaces/transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/plaid_transaction.dart';
import 'package:growth_pilot_ai/core/models/transaction_sync_page.dart';

/// Local stand-in for the Plaid fetch worker. Emulates a two-page sandbox sync
/// exercising added / modified / removed changes, so the fetch loop can be
/// built and tested without a backend. Web-safe.
class MockTransactionFetchService implements TransactionFetchService {
  @override
  OmniResult<TransactionSyncPage> fetchIncremental(String? cursor) async {
    if (cursor == null) {
      return OmniResponse.success(const TransactionSyncPage(
        nextCursor: 'cursor-1',
        hasMore: true,
        added: [
          PlaidTransaction(
              transactionId: 't1', amount: 42.50, merchantName: 'Staples'),
          PlaidTransaction(
              transactionId: 't2', amount: 1200, merchantName: 'Landlord'),
        ],
      ));
    }
    return OmniResponse.success(const TransactionSyncPage(
      nextCursor: 'cursor-2',
      added: [
        PlaidTransaction(
            transactionId: 't3', amount: 80, merchantName: 'Hydro'),
      ],
      modified: [
        PlaidTransaction(
            transactionId: 't1', amount: 45.00, merchantName: 'Staples'),
      ],
      removedIds: ['t2'],
    ));
  }
}
