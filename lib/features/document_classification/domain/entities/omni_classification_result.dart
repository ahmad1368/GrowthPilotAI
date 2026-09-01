import 'document_type.dart';

class OmniClassificationResult {
  final DocumentType detectedType;
  final double confidence;
  final bool isValid;

  const OmniClassificationResult({
    required this.detectedType,
    required this.confidence,
    required this.isValid,
  });
}
