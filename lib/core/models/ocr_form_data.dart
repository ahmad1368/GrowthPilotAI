import 'dart:io';

class OcrFormData {
  final double amount;
  final DateTime date;
  final String vendorName;
  final String description;
  final File receiptImage;

  const OcrFormData({
    required this.amount,
    required this.date,
    required this.vendorName,
    required this.description,
    required this.receiptImage,
  });
}
