import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/transaction_sync_page.dart';

/// Contract for incremental transaction fetching (the client analog of the
/// backend's Plaid `/transactions/sync` worker). Callers page through results
/// with an opaque cursor until [TransactionSyncPage.hasMore] is false.
abstract class TransactionFetchService {
  OmniResult<TransactionSyncPage> fetchIncremental(String? cursor);
}
