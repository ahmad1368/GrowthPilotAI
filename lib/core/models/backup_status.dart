import 'package:flutter/foundation.dart';

/// Client-visible state of the latest cloud backup (the backend runs the actual
/// dump/upload). Lets the UI reassure the user their data is protected.
@immutable
class BackupStatus {
  final DateTime? lastBackupAt;
  final bool succeeded;
  final String? storageKey;

  const BackupStatus({
    this.lastBackupAt,
    this.succeeded = false,
    this.storageKey,
  });

  bool get hasBackup => lastBackupAt != null && succeeded;
}
