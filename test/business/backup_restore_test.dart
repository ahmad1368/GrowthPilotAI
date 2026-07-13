import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/backup_selector.dart';
import 'package:growth_pilot_ai/core/models/backup_archive.dart';
import 'package:growth_pilot_ai/core/utils/backup_integrity.dart';

BackupArchive _archive(String key, DateTime at) => BackupArchive(
    storageKey: key, createdAt: at, sizeBytes: 100, checksum: 'x');

void main() {
  group('BackupIntegrity', () {
    final bytes = utf8.encode('backup-contents');

    test('verify accepts the matching checksum', () {
      final hash = BackupIntegrity.sha256Of(bytes);
      expect(BackupIntegrity.verify(bytes, hash), isTrue);
      expect(BackupIntegrity.verify(bytes, hash.toUpperCase()), isTrue);
    });

    test('verify rejects a corrupted blob', () {
      final hash = BackupIntegrity.sha256Of(bytes);
      final tampered = utf8.encode('backup-contents!');
      expect(BackupIntegrity.verify(tampered, hash), isFalse);
    });
  });

  group('BackupSelector.recent', () {
    final archives = [
      _archive('a', DateTime(2027, 1, 1)),
      _archive('b', DateTime(2027, 1, 5)),
      _archive('c', DateTime(2027, 1, 3)),
    ];

    test('returns newest first', () {
      final recent = BackupSelector.recent(archives);
      expect(recent.map((a) => a.storageKey), ['b', 'c', 'a']);
    });

    test('caps to the requested count', () {
      final recent = BackupSelector.recent(archives, count: 2);
      expect(recent.map((a) => a.storageKey), ['b', 'c']);
    });
  });
}
