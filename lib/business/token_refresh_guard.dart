import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';

/// Client-side equivalent of the backend's Redis lock (Issue #56): stops two
/// concurrent callers from triggering a refresh for the same provider at once.
class TokenRefreshGuard {
  static final Set<AccountingProvider> _inProgress = {};

  /// Claims the lock for [provider]. Returns false if a refresh is already
  /// running, in which case the caller should wait rather than refresh again.
  static bool tryStart(AccountingProvider provider) =>
      _inProgress.add(provider);

  /// Releases the lock once the refresh attempt (success or failure) settles.
  static void finish(AccountingProvider provider) =>
      _inProgress.remove(provider);

  static bool isInProgress(AccountingProvider provider) =>
      _inProgress.contains(provider);
}
