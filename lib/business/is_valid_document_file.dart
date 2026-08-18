import 'package:growth_pilot_ai/core/models/picked_document.dart';

/// "Validate file types (MIME types) and set a size limit (e.g., 20MB)
/// to prevent DoS attacks" (Issue #225) — a client-side pre-check
/// before the file ever leaves the device, since this repo has no
/// backend to enforce it server-side (see PR notes).
class IsValidDocumentFile {
  static const allowedExtensions = {'pdf', 'docx'};
  static const maxSizeBytes = 20 * 1024 * 1024; // 20MB, per the issue's own limit

  static bool call(PickedDocument document) {
    return allowedExtensions.contains(document.extension) &&
        document.sizeBytes > 0 &&
        document.sizeBytes <= maxSizeBytes;
  }
}
