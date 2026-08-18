import 'package:flutter/foundation.dart';

/// Both the original and the "AI-Ready" cleaned text (Issue #227) — kept
/// side by side so the user can see exactly what was removed if they
/// suspect a false-positive deletion (AC: "Diff View").
@immutable
class SanitizedTextResult {
  final String rawText;
  final String sanitizedText;

  const SanitizedTextResult({required this.rawText, required this.sanitizedText});
}
