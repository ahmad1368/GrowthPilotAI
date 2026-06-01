import 'dart:io';
import '../entities/omni_classification_result.dart';

abstract class AbstractClassifierService {
  Future<void> loadModel();
  Future<OmniClassificationResult> classifyDocument(File imageFile);
  void dispose();
}
