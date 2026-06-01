// lib/core/models/classification_request.dart
import 'dart:io';
import 'package:image/image.dart' as img;
import '../utils/tensor_converter.dart';

class ClassificationRequest {
  final File file;

  ClassificationRequest({required this.file});

  /// خروجی تنسور به صورت بایت‌های صحیح 0 تا 255
  Future<List<List<List<List<int>>>>> toTensorInput() async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception("امکان رمزگشایی تصویر وجود ندارد.");
    }

    final resized = img.copyResize(image, width: 224, height: 224);
    return TensorConverter.toUint8FourDimensional(resized);
  }
}
