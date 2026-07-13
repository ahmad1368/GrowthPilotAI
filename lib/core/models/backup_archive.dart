import 'package:flutter/foundation.dart';

/// A restorable cloud backup listed from storage — one point-in-time recovery
/// choice. [checksum] is the expected SHA-256 used to verify integrity before
/// a restore.
@immutable
class BackupArchive {
  final String storageKey;
  final DateTime createdAt;
  final int sizeBytes;
  final String checksum;

  const BackupArchive({
    required this.storageKey,
    required this.createdAt,
    required this.sizeBytes,
    required this.checksum,
  });
}
