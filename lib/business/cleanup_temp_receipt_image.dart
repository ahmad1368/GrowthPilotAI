import 'dart:io';

/// Issue #21 AC ("Data Hygiene"): cropped receipt images are sensitive and
/// must be cleared from the temp/cache directory once the OCR data they
/// produced has been saved to ObjectBox. Best-effort - a delete failure must
/// never block a transaction that already saved successfully.
class CleanupTempReceiptImage {
  static Future<void> call(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }
}
