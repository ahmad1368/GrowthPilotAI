/// [Issue #826] Keeps the profile display-name field non-empty and within
/// a sane length before ProfileController persists it.
class ProfileNameValidator {
  static String? call(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Name is required';
    if (trimmed.length > 60) return 'Name is too long';
    return null;
  }
}
