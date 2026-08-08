/// Flags a SKU as a duplicate against already-imported/existing SKUs
/// (Issue #141, acceptance criterion "Duplicate SKUs ... are flagged
/// as errors rather than creating duplicates").
class DetectDuplicateSku {
  static bool call(String sku, Set<String> existingSkus) => existingSkus.contains(sku);
}
