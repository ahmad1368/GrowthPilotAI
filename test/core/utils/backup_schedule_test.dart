import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/backup_status.dart';
import 'package:growth_pilot_ai/core/utils/backup_schedule.dart';

void main() {
  const schedule = BackupSchedule();

  group('BackupSchedule.nextRunAfter', () {
    test('returns today at 3 AM when before the window', () {
      final next = schedule.nextRunAfter(DateTime(2027, 1, 10, 1));
      expect(next, DateTime(2027, 1, 10, 3));
    });

    test('rolls to the next day when after the window', () {
      final next = schedule.nextRunAfter(DateTime(2027, 1, 10, 5));
      expect(next, DateTime(2027, 1, 11, 3));
    });

    test('rolls forward when exactly at the scheduled time', () {
      final next = schedule.nextRunAfter(DateTime(2027, 1, 10, 3));
      expect(next, DateTime(2027, 1, 11, 3));
    });
  });

  group('BackupSchedule.isOverdue', () {
    final now = DateTime(2027, 1, 10, 12);

    test('is overdue when there is no backup yet', () {
      expect(schedule.isOverdue(null, now), isTrue);
    });

    test('is not overdue within a day plus grace', () {
      expect(schedule.isOverdue(DateTime(2027, 1, 9, 15), now), isFalse);
    });

    test('is overdue once past a day plus grace', () {
      expect(schedule.isOverdue(DateTime(2027, 1, 9, 9), now), isTrue);
    });
  });

  group('BackupStatus', () {
    test('hasBackup requires a timestamp and success', () {
      expect(const BackupStatus().hasBackup, isFalse);
      expect(
        BackupStatus(lastBackupAt: DateTime(2027), succeeded: true).hasBackup,
        isTrue,
      );
    });
  });
}
