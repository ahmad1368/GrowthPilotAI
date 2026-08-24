import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_omni_log_entry.dart';
import 'package:growth_pilot_ai/core/data/repositories/omni_log_entry_repository.dart';
import 'package:growth_pilot_ai/core/enum/omni_log_level.dart';

/// Offline persistence side effect for [OmniLogger] (Issue #266) —
/// silently skipped if the ObjectBox-backed repository isn't registered
/// yet (e.g. a log call during app bootstrap, before
/// `DependencyInjection.init` runs), so logging itself can never crash
/// the app.
class PersistOmniLogEntry {
  static void call(OmniLogLevel level, String title, dynamic message,
      [StackTrace? stackTrace, String userId = 'local-user']) {
    if (!GetIt.I.isRegistered<OmniLogEntryRepository>()) return;
    try {
      GetIt.I<OmniLogEntryRepository>().insert(BuildOmniLogEntry.call(
        level: level,
        title: title,
        message: message,
        stackTrace: stackTrace,
        now: DateTime.now(),
        userId: userId,
      ));
    } catch (_) {
      // Best-effort: never let offline log persistence itself throw.
    }
  }
}
