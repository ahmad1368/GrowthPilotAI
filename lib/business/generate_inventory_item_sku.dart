/// Suggests a unique SKU from a category name + a running count of items
/// already using that prefix (Issue #437). Purely a local naming
/// convention — no barcode-standard (UPC/EAN) registry involved, since
/// this app assigns its own internal identifiers.
class GenerateInventoryItemSku {
  static String call(String? categoryName, List<String> existingSkus) {
    final prefix = _prefixFor(categoryName);
    var sequence = existingSkus.where((sku) => sku.startsWith('$prefix-')).length + 1;
    var candidate = '$prefix-${sequence.toString().padLeft(4, '0')}';
    while (existingSkus.contains(candidate)) {
      sequence++;
      candidate = '$prefix-${sequence.toString().padLeft(4, '0')}';
    }
    return candidate;
  }

  static String _prefixFor(String? categoryName) {
    final letters =
        (categoryName ?? '').toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    if (letters.isEmpty) return 'GEN';
    return letters.length >= 3 ? letters.substring(0, 3) : letters.padRight(3, 'X');
  }
}
