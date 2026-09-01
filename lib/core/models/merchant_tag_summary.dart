/// One merchant profile and every distinct tag assigned to it (Issue
/// #342) — joins [MerchantConfigEntity] with its logged
/// [MerchantTagEntity] assignments.
class MerchantTagSummary {
  final String businessName;
  final String businessId;
  final List<String> tags;

  const MerchantTagSummary({
    required this.businessName,
    required this.businessId,
    required this.tags,
  });
}
