import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';

/// One processed image's stored variants (Issue #139, "Triple-Stream
/// Logic") — [thumbnailBytes]/[standardBytes] are genuinely
/// re-encoded, smaller JPEG bytes; the untouched original is
/// represented only by its byte size, since no S3/CDN exists locally
/// to archive the full original in.
@Entity()
class ImageVariantEntity {
  @Id()
  int id = 0;

  String label;
  int originalSizeBytes;
  Uint8List thumbnailBytes;
  int thumbnailSizeBytes;
  Uint8List standardBytes;
  int standardSizeBytes;
  double dataReductionPercent;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  ImageVariantEntity({
    this.id = 0,
    required this.label,
    required this.originalSizeBytes,
    required this.thumbnailBytes,
    required this.thumbnailSizeBytes,
    required this.standardBytes,
    required this.standardSizeBytes,
    required this.dataReductionPercent,
    required this.createdAt,
  });
}
