/// Deterministic string form of [data] for [GenerateDeterministicHash]
/// (Issue #89) — the issue's own review flagged that `JSON.stringify`
/// hashes by insertion order, so semantically identical maps built in a
/// different order (ORM hydration, spread/merge order, ...) silently
/// diverge. This sorts map keys recursively so key order never matters:
/// `call({a: 1, b: 2}) == call({b: 2, a: 1})`.
class CanonicalizeForHash {
  static String call(Object? data) => data is String ? data : _encode(data);

  static String _encode(Object? value) {
    if (value == null) return 'null';
    if (value is Map) {
      final keys = value.keys.map((k) => k.toString()).toList()..sort();
      final parts = keys.map((k) => '"$k":${_encode(value[k])}');
      return '{${parts.join(',')}}';
    }
    if (value is List) return '[${value.map(_encode).join(',')}]';
    if (value is String) return '"$value"';
    return value.toString();
  }
}
