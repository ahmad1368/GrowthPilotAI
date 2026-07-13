import 'package:growth_pilot_ai/core/interfaces/transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/plaid_transaction.dart';

/// Runs the incremental fetch loop client-side: pages through the service by
/// cursor, upserting added/modified by transactionId (dedup) and dropping
/// removed ids, until there are no more pages.
class FetchTransactionsUseCase {
  final TransactionFetchService _service;

  FetchTransactionsUseCase(this._service);

  OmniResult<List<PlaidTransaction>> fetchAll({String? startCursor}) async {
    final Map<String, PlaidTransaction> byId = {};
    String? cursor = startCursor;
    var hasMore = true;

    while (hasMore) {
      final response = await _service.fetchIncremental(cursor);
      final page = response.data;
      if (!response.success || page == null) {
        return OmniResponse.error(response.message ?? 'Fetch failed',
            statusCode: response.statusCode);
      }
      for (final t in page.added) {
        byId[t.transactionId] = t;
      }
      for (final t in page.modified) {
        byId[t.transactionId] = t;
      }
      for (final id in page.removedIds) {
        byId.remove(id);
      }
      cursor = page.nextCursor;
      hasMore = page.hasMore;
    }
    return OmniResponse.success(byId.values.toList(),
        message: 'Fetched ${byId.length}');
  }
}
