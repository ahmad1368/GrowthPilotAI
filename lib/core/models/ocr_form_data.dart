import 'dart:io';

class OcrFormData {
  final double amount;
  final DateTime date;
  final String vendorName;
  final String description;
  final File receiptImage;

  /// Detected receipt currency (Issue #24), e.g. "CAD" or "USD".
  final String currency;

  const OcrFormData({
    required this.amount,
    required this.date,
    required this.vendorName,
    required this.description,
    required this.receiptImage,
    this.currency = 'CAD',
  });
}
