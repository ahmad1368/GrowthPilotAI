/// Reverses [SerializeAmountForEncryption] after decryption (Issue
/// #262).
class DeserializeAmountFromEncryption {
  static double call(String serialized) => double.parse(serialized);
}
