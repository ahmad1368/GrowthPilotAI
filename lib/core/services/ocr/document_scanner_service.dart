import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// "Document Scanner: use the phone camera to scan a physical paper,
/// crop it" (Issue #226/#227) — the real Google ML Kit Document Scanner
/// API only ships an Android implementation (no iOS/Web support), so
/// this is guarded to a clear, non-crashing fallback message on those
/// platforms, per architecture rules.
class DocumentScannerService {
  Future<OmniResponse<File>> scan() async {
    if (kIsWeb) {
      return OmniResponse<File>.error(
          "Document scanning isn't available on web yet — please use the mobile app.");
    }
    if (defaultTargetPlatform != TargetPlatform.android) {
      return OmniResponse<File>.error(
          "Document scanning is currently Android-only. On iOS, pick a photo instead.");
    }

    final scanner = DocumentScanner(
      options: DocumentScannerOptions(documentFormats: const {DocumentFormat.jpeg}),
    );
    try {
      final result = await scanner.scanDocument();
      final images = result.images;
      final imagePath = images == null || images.isEmpty ? null : images.first;
      if (imagePath == null) {
        return OmniResponse<File>.error('No page was scanned.');
      }
      return OmniResponse<File>.success(File(imagePath));
    } finally {
      await scanner.close();
    }
  }
}
