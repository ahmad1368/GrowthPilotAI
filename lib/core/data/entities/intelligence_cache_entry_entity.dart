import 'package:objectbox/objectbox.dart';

/// One item's encrypted [DistilledContext] snapshot (Issue #105's cache,
/// encrypted at rest per #106 "Secure Local Storage for Intelligence
/// Packs") — the local "Intelligence Node" storage the Edge Downloader
/// writes to so the Radar Chart (#99) and Efficiency Gap (#100) render
/// offline. [encryptedSnapshot] is AES-256 ciphertext (see
/// [FieldCipher]), never plaintext; [contentHash] is a SHA-256 of the
/// plaintext snapshot so a delta comparison never needs the decryption
/// key; [checksum] is a SHA-256 of the ciphertext so tampering can be
/// detected after the fact (AC: "Privacy Integrity").
@Entity()
class IntelligenceCacheEntryEntity {
  @Id()
  int id = 0;

  @Unique()
  @Index()
  String itemId;

  String sectorId;
  String contentHash;
  String encryptedSnapshot;
  String checksum;

  @Property(type: PropertyType.date)
  DateTime syncedAt;

  IntelligenceCacheEntryEntity({
    this.id = 0,
    required this.itemId,
    required this.sectorId,
    required this.contentHash,
    required this.encryptedSnapshot,
    required this.checksum,
    required this.syncedAt,
  });
}
