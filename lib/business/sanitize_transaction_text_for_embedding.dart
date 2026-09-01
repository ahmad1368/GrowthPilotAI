/// Cleans transaction text before it's turned into an embedding (Issue
/// #198's "Data Sanitization" requirement) — strips excess whitespace
/// and normalizes so near-duplicate phrasing embeds consistently.
class SanitizeTransactionTextForEmbedding {
  static String call({
    required String merchantName,
    required DateTime date,
    required List<String> lineItems,
    double? gstHst,
  }) {
    final parts = <String>[
      merchantName.trim(),
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      ...lineItems.map((item) => item.trim()).where((item) => item.isNotEmpty),
      if (gstHst != null) 'GST/HST: \$${gstHst.toStringAsFixed(2)}',
    ];
    return parts.join(', ').replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
