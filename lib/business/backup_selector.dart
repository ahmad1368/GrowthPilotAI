import 'package:growth_pilot_ai/core/models/backup_archive.dart';

/// Chooses which cloud backups an admin can restore from — the most recent
/// [count], newest first (point-in-time recovery choices).
class BackupSelector {
  static List<BackupArchive> recent(
    List<BackupArchive> archives, {
    int count = 5,
  }) {
    final sorted = [...archives]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(count).toList();
  }
}
