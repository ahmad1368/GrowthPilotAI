import 'dart:typed_data';

import 'package:growth_pilot_ai/business/generate_image_variants.dart';
import 'package:image_picker/image_picker.dart';

/// Picks a photographed document and compresses it via the #139
/// pipeline (Issue #144 "Document Submission" AC) — returns null if the
/// user cancels.
Future<Uint8List?> pickKycDocument() async {
  final file = await ImagePicker().pickImage(source: ImageSource.camera);
  if (file == null) return null;
  return GenerateImageVariants.call(await file.readAsBytes()).standard;
}
