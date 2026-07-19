// lib/features/document_classification/data/services/tflite_classifier_service.dart
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
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
      _logError('Model Load Failed', 'خطا در لود مدل: $e', stack);
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
      _logError('Classifier Inference Error', 'خطا در پردازش تصویر: $e', stack);
      return const OmniClassificationResult(
        detectedType: DocumentType.background,
        confidence: 0.0,
        isValid: false,
      );
    }
  }

  void _logError(String title, String message, StackTrace stack) {
    OmniLogger.error(
      title: title,
      message: '$message | کاربر: Ahmad_Salem_Pour',
      stackTrace: stack,
      widgetName: 'TFliteClassifierService',
    );
  }

  @override
  void dispose() => _interpreter?.close();
}
