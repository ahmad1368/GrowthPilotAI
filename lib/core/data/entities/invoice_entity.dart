import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';

/// One generated GST/PST invoice (Issue #146; PDF stored directly, no
/// cloud storage locally). [agreedExchangeRate] freezes the rate at
/// generation time (#153 AC) so the invoice stays historically accurate.
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

  String currencyCode; // Currency.code, e.g. "CAD"
  double? agreedExchangeRate;
  bool isExport;
  double? dutyEstimate;

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
    this.currencyCode = 'CAD',
    this.agreedExchangeRate,
    this.isExport = false,
    this.dutyEstimate,
    required this.pdfBytes,
    required this.createdAt,
  });

  String get invoiceNumber => 'INV-${createdAt.year}-${id.toString().padLeft(5, '0')}';
}
