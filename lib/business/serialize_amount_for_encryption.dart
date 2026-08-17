/// Converts a transaction amount to a fixed-precision string before AES
/// encryption (Issue #262) — [FieldCipher] only encrypts strings, and a
/// fixed 2-decimal format keeps round-tripping exact for currency values.
class SerializeAmountForEncryption {
  static String call(double amount) => amount.toStringAsFixed(2);
}
