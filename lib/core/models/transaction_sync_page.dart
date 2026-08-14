import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/plaid_transaction.dart';

/// One page of Plaid `/transactions/sync` output: incremental [added] /
/// [modified] records, [removedIds] to delete, and the [nextCursor] to resume
/// from. [hasMore] drives the pagination loop.
@immutable
class TransactionSyncPage {
  final List<PlaidTransaction> added;
  final List<PlaidTransaction> modified;
  final List<String> removedIds;
  final String nextCursor;
  final bool hasMore;

  const TransactionSyncPage({
    required this.nextCursor,
    this.added = const [],
    this.modified = const [],
    this.removedIds = const [],
    this.hasMore = false,
  });
}
