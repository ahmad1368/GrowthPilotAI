import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_omni_log_entry.dart';
import 'package:growth_pilot_ai/core/enum/omni_log_level.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  group('BuildOmniLogEntry', () {
    test('packages a level, title, and message (Issue #266)', () {
      final entry = BuildOmniLogEntry.call(
        level: OmniLogLevel.error,
        title: 'ObjectBox Store Failed to Open',
        message: 'disk full',
        now: now,
      );

      expect(entry.dbLevel, OmniLogLevel.error.index);
      expect(entry.title, 'ObjectBox Store Failed to Open');
      expect(entry.message, 'disk full');
      expect(entry.occurredAt, now);
    });

    test('stringifies a non-String message, defaults a null one to empty', () {
      expect(BuildOmniLogEntry.call(level: OmniLogLevel.warning, title: 't', message: 404, now: now)
          .message, '404');
      expect(BuildOmniLogEntry.call(level: OmniLogLevel.info, title: 't', now: now).stackTraceText,
          isNull);
    });

    test('stores the stack trace as text when provided', () {
      final trace = StackTrace.current;
      final entry = BuildOmniLogEntry.call(
          level: OmniLogLevel.error, title: 't', stackTrace: trace, now: now);

      expect(entry.stackTraceText, trace.toString());
    });
  });
}
