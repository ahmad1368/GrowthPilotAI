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

    test('defaults userId to local-user, not a hardcoded real name (Issue #165)', () {
      final entry = BuildOmniLogEntry.call(level: OmniLogLevel.error, title: 't', now: now);
      expect(entry.userId, 'local-user');
    });

    test('stores a caller-provided userId as a real structured field', () {
      final entry =
          BuildOmniLogEntry.call(level: OmniLogLevel.error, title: 't', now: now, userId: 'biz-42');
      expect(entry.userId, 'biz-42');
    });

    test('redacts a SIN and a leaked API key before persisting (Issue #206)', () {
      final entry = BuildOmniLogEntry.call(
        level: OmniLogLevel.error,
        title: 'Sync failed',
        message: 'user SIN 123-456-789, apiKey=abc123xyz',
        now: now,
      );

      expect(entry.message, isNot(contains('123-456-789')));
      expect(entry.message, isNot(contains('abc123xyz')));
    });
  });
}
