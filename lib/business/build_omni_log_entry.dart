import 'package:growth_pilot_ai/business/redact_pii.dart';
import 'package:growth_pilot_ai/business/redact_secrets.dart';
import 'package:growth_pilot_ai/core/data/entities/omni_log_entry_entity.dart';
import 'package:growth_pilot_ai/core/enum/omni_log_level.dart';

/// Packages one [OmniLogger] call into a storable [OmniLogEntryEntity]
/// (Issue #266) — [message] is coerced to a string since [OmniLogger.error]
/// accepts `dynamic`, then run through [RedactPii]/[RedactSecrets] (Issue
/// #206) since a caught exception's message can otherwise carry a SIN,
/// credit card number, email, or leaked API key/password straight into
/// this offline, unencrypted log store.
class BuildOmniLogEntry {
  static OmniLogEntryEntity call({
    required OmniLogLevel level,
    required String title,
    dynamic message,
    StackTrace? stackTrace,
    required DateTime now,
    String userId = 'local-user',
  }) {
    final safeMessage = RedactSecrets.call(RedactPii.call(message?.toString() ?? ''));
    return OmniLogEntryEntity(
      dbLevel: level.index,
      title: RedactSecrets.call(RedactPii.call(title)),
      message: safeMessage,
      stackTraceText: stackTrace?.toString(),
      userId: userId,
      occurredAt: now,
    );
  }
}
