/// Client-side validation for a new OmniPulse report (Issue #267/#268)
/// — each method returns null when valid, or a user-friendly message
/// for the Flutter UI.
class PulseReportValidator {
  static String? title(String? value) {
    final v = value?.trim() ?? '';
    if (v.length < 5) return 'Title must be at least 5 characters';
    if (v.length > 80) return 'Title must be at most 80 characters';
    return null;
  }

  static String? description(String? value) {
    final v = value?.trim() ?? '';
    if (v.length < 10) return 'Description must be at least 10 characters';
    if (v.length > 500) return 'Description must be at most 500 characters';
    return null;
  }

  static String? estimatedImpactCad(double? value) {
    if (value == null) return 'Estimated impact is required';
    if (value < 0) return 'Estimated impact cannot be negative';
    return null;
  }
}
