import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';

/// Contract for the cloud sync backend the app will talk to (the NestJS/Mongo
/// REST API). Implementations return standard [OmniResult]s so callers handle
/// success/failure uniformly.
abstract class RemoteSyncDataSource {
  SyncConfig get config;

  /// Verifies the backend is reachable — the client analog of the API's
  /// `GET /` health check returning 200 OK.
  OmniResult<bool> healthCheck();

  /// Delta upload of dirty records (client analog of `POST /sync/upload`).
  /// Resolves to the list of local ids the backend confirmed as synced.
  OmniResult<List<int>> uploadTransactions(List<TransactionEntity> dirty);
}
