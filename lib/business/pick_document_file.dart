import 'package:file_picker/file_picker.dart';
import 'package:growth_pilot_ai/business/is_valid_document_file.dart';
import 'package:growth_pilot_ai/core/models/picked_document.dart';

/// "File Picker: Integrate the file_picker package to allow users to
/// select documents" (Issue #225) — restricts the OS picker to PDF/DOCX
/// up front via [IsValidDocumentFile.allowedExtensions], so most
/// invalid selections never reach [IsValidDocumentFile] at all.
class PickDocumentFile {
  static Future<PickedDocument?> call() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: IsValidDocumentFile.allowedExtensions.toList(),
      withData: true,
    );
    final file = result?.files.single;
    if (file == null) return null;

    return PickedDocument(fileName: file.name, sizeBytes: file.size, path: file.path, bytes: file.bytes);
  }
}
