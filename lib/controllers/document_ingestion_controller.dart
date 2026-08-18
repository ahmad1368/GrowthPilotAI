import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/is_valid_document_file.dart';
import 'package:growth_pilot_ai/business/pick_document_file.dart';
import 'package:growth_pilot_ai/business/record_document_upload.dart';
import 'package:growth_pilot_ai/core/models/picked_document.dart';

/// Drives the "File Picker" step (Issue #225) — picking, validating,
/// and audit-logging a document. Actual text extraction (PyMuPDF/
/// python-docx) doesn't happen here; there's no backend to run it (see
/// PR notes).
class DocumentIngestionController extends GetxController {
  final selectedDocument = Rxn<PickedDocument>();
  final isValid = false.obs;

  Future<void> pick() async {
    final document = await PickDocumentFile.call();
    if (document == null) return;

    selectedDocument.value = document;
    isValid.value = RecordDocumentUpload.call(document, DateTime.now());
  }

  String? get validationMessage =>
      selectedDocument.value == null || isValid.value
          ? null
          : 'Only PDF/DOCX files up to ${IsValidDocumentFile.maxSizeBytes ~/ (1024 * 1024)}MB are supported.';
}
