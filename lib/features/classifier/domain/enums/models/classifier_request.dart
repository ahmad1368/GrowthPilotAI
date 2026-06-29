import 'dart:io';

class ClassifierRequest {
  final File imageFile;
  final double confidenceThreshold;

  const ClassifierRequest({
    required this.imageFile,
    this.confidenceThreshold = 0.70,
  });
}
