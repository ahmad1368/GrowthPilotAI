/// Caps the dynamic sector-specific attribute map to 20 keys (Issue
/// #138, technical constraint: "specs object must be capped at 20
/// keys to prevent Document Bloat").
class CapAttributeKeys {
  static const maxKeys = 20;

  static Map<String, String> call(Map<String, String> attributes) {
    if (attributes.length <= maxKeys) return attributes;
    return Map.fromEntries(attributes.entries.take(maxKeys));
  }
}
