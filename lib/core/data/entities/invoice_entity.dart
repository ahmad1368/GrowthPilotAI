import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';

/// One generated GST/PST invoice (Issue #146) — the PDF is stored
/// directly (like #139's `ImageVariantEntity`), not behind an S3/GCS
/// "Strict Access" bucket, since no cloud storage exists locally.
@Entity()
class InvoiceEntity {
  @Id()
  int id = 0;

  @Index()
  int requestId;

  String sellerId;
  String buyerId;
  String? sellerBusinessNumber;

  double subtotal;
  double gst;
  double pst;
  double total;

  Uint8List pdfBytes;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  InvoiceEntity({
    this.id = 0,
    required this.requestId,
    required this.sellerId,
    required this.buyerId,
    this.sellerBusinessNumber,
    required this.subtotal,
    required this.gst,
    required this.pst,
    required this.total,
    required this.pdfBytes,
    required this.createdAt,
  });

  String get invoiceNumber => 'INV-${createdAt.year}-${id.toString().padLeft(5, '0')}';
}
