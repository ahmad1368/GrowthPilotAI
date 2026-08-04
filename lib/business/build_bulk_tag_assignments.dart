import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';

/// Builds one tag assignment per selected merchant for a bulk-tagging
/// action (Issue #342, acceptance criterion 3) — pure construction, the
/// caller persists the results via [MerchantTagRepository.insertAll].
class BuildBulkTagAssignments {
  static List<MerchantTagEntity> call(
      List<String> businessIds, String tagLabel, DateTime taggedAt) {
    return businessIds
        .map((id) => MerchantTagEntity(
              merchantBusinessId: id,
              tagLabel: tagLabel,
              taggedAt: taggedAt,
            ))
        .toList();
  }
}
