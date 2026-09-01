import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_merchant_tag_summaries.dart';
import 'package:growth_pilot_ai/business/filter_merchants_by_tag.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_tag_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_view.dart';

/// Owns the tag list and filter query (Issue #342), persisting bulk-tag
/// submissions immediately to local state.
class MerchantTagBody extends StatefulWidget {
  final List<MerchantConfigEntity> merchantConfigs;
  final List<MerchantTagEntity> initialTags;

  const MerchantTagBody(
      {super.key, required this.merchantConfigs, required this.initialTags});

  @override
  State<MerchantTagBody> createState() => _MerchantTagBodyState();
}

class _MerchantTagBodyState extends State<MerchantTagBody> {
  late List<MerchantTagEntity> _tags = widget.initialTags;
  String _filterTag = '';

  Future<void> _bulkTag() async {
    final summaries = ComputeMerchantTagSummaries.call(widget.merchantConfigs, _tags);
    final newTags = await showMerchantTagDialog(context, summaries);
    if (newTags == null || newTags.isEmpty) return;
    MerchantTagRepository(Get.find<ObjectBox>().store.box<MerchantTagEntity>())
        .insertAll(newTags);
    setState(() => _tags = [..._tags, ...newTags]);
  }

  @override
  Widget build(BuildContext context) {
    final allResults = ComputeMerchantTagSummaries.call(widget.merchantConfigs, _tags);
    final filteredResults = FilterMerchantsByTag.call(allResults, _filterTag);
    return MerchantTagView(
      filteredResults: filteredResults,
      allResults: allResults,
      onFilterChanged: (q) => setState(() => _filterTag = q),
      onBulkTag: _bulkTag,
    );
  }
}
