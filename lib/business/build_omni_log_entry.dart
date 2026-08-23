import 'package:growth_pilot_ai/core/data/entities/omni_log_entry_entity.dart';
import 'package:growth_pilot_ai/core/enum/omni_log_level.dart';

/// Packages one [OmniLogger] call into a storable [OmniLogEntryEntity]
/// (Issue #266) — [message] is coerced to a string since [OmniLogger.error]
/// accepts `dynamic`.
class BuildOmniLogEntry {
  static OmniLogEntryEntity call({
    required OmniLogLevel level,
    required String title,
    dynamic message,
    StackTrace? stackTrace,
    required DateTime now,
  }) {
    return OmniLogEntryEntity(
      dbLevel: level.index,
      title: title,
      message: message?.toString() ?? '',
      stackTraceText: stackTrace?.toString(),
      occurredAt: now,
    );
  }
}
