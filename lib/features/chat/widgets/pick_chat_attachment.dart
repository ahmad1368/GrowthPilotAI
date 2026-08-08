import 'dart:typed_data';

import 'package:growth_pilot_ai/business/generate_image_variants.dart';
import 'package:image_picker/image_picker.dart';

typedef PickedChatAttachment = ({String fileName, String mimeType, Uint8List bytes});

/// Picks a gallery image and runs it through the client-side compression
/// pipeline from #139 (Issue #133 "Storage Optimization" AC) — returns
/// null if the user cancels. Only images are supported; PDF/DWG/XLSX
/// picking needs the `file_picker` package, a future dependency.
Future<PickedChatAttachment?> pickChatAttachment() async {
  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (file == null) return null;

  final variants = GenerateImageVariants.call(await file.readAsBytes());
  return (fileName: file.name, mimeType: 'image/jpeg', bytes: variants.standard);
}
