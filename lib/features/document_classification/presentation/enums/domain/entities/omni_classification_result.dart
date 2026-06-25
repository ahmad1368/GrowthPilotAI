import 'package:growth_pilot_ai/core/models/document_type.dart';

class OmniClassificationResult {
  final DocumentTypeEntity detectedType;
  final double confidence;
  final bool isValid;

  const OmniClassificationResult({
    required this.detectedType,
    required this.confidence,
    required this.isValid,
  });
}
