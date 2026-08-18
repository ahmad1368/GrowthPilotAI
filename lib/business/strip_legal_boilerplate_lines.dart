/// "Confidentiality notices/Legal footers" (Issue #227) — a keyword
/// heuristic, not a trained classifier: any line containing one of
/// these common legal-boilerplate markers is dropped entirely.
class StripLegalBoilerplateLines {
  static const _markers = [
    'confidential',
    'proprietary and confidential',
    'all rights reserved',
    'copyright ©',
    '© 20', // matches "© 2024", "© 2025", etc.
  ];

  static String call(String text) {
    final lines = text.split('\n');
    final kept = lines.where((line) {
      final lower = line.toLowerCase();
      return !_markers.any((marker) => lower.contains(marker));
    });
    return kept.join('\n');
  }
}
