import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:growth_pilot_ai/core/models/classification_request.dart';
import 'package:growth_pilot_ai/core/constants/app_assets.dart';
import '../../domain/repositories/abstract_classifier_service.dart';
import '../../domain/entities/omni_classification_result.dart';
import '../../domain/entities/document_type.dart';
import '../models/classification_response.dart';

class TFliteClassifierService implements AbstractClassifierService {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset(AppAssets.receiptClassifierModel);
    } catch (e, stack) {
      _handleLocalError('Model Load Failed: $e', stack);
    }
  }

  @override
  Future<OmniClassificationResult> classifyDocument(File imageFile) async {
    if (_interpreter == null) await loadModel();
    try {
      final req = ClassificationRequest(file: imageFile);
      final input = await req.toTensorInput();
      var output = List.filled(1001, 0).reshape([1, 1001]);

      _interpreter!.run(input, output);
      return ClassificationResponse.fromMatrix(output);
    } catch (e, stack) {
      _handleLocalError('Inference Error: $e', stack);
      return const OmniClassificationResult(
        detectedType: DocumentType.background,
        confidence: 0.0,
        isValid: false,
      );
    }
  }

  void _handleLocalError(String msg, StackTrace stack) {
    assert(() {
      print(
          "[Ahmad_Salem_Pour] [2026-06-02] [TFliteClassifierService]: $msg\n$stack");
      return true;
    }());
  }

  @override
  void dispose() => _interpreter?.close();
}
