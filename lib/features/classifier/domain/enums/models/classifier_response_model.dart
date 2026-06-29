import 'package:growth_pilot_ai/features/classifier/domain/enums/classifier_label.dart';

class ClassifierResponseModel {
  final bool isValidDocument;
  final double confidence;
  final ClassifierLabel detectedLabel;

  const ClassifierResponseModel({
    required this.isValidDocument,
    required this.confidence,
    required this.detectedLabel,
  });
}
