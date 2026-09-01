/// A configured server-side pepper for [GenerateDeterministicHash] (Issue
/// #89). Fails fast at construction rather than silently hashing with an
/// empty/missing value — the exact "input + undefined" bug the issue's
/// review flagged in the original `input + salt` concatenation approach.
class HashPepper {
  final String value;

  HashPepper(this.value) {
    if (value.isEmpty) {
      throw StateError('HASH_SALT/pepper must be configured before hashing.');
    }
  }
}
