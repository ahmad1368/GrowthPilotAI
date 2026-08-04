import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/banner_matching_rule_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_view.dart';

/// Owns the banner matching rule list (Issue #403), saving add/edit
/// changes immediately.
class BannerRuleBody extends StatefulWidget {
  final List<BannerMatchingRuleEntity> initialRules;

  const BannerRuleBody({super.key, required this.initialRules});

  @override
  State<BannerRuleBody> createState() => _BannerRuleBodyState();
}

class _BannerRuleBodyState extends State<BannerRuleBody> {
  late List<BannerMatchingRuleEntity> _rules = widget.initialRules;

  Future<void> _save({BannerMatchingRuleEntity? existing}) async {
    final rule = await showBannerRuleDialog(context, existing: existing);
    if (rule == null) return;
    final savedId = BannerMatchingRuleRepository(
            Get.find<ObjectBox>().store.box<BannerMatchingRuleEntity>())
        .save(rule);
    setState(() {
      _rules = [
        for (final r in _rules)
          if (r.id != savedId) r,
        BannerMatchingRuleEntity(
            id: savedId,
            reportTopic: rule.reportTopic,
            category: rule.category,
            priorityWeight: rule.priorityWeight,
            updatedAt: rule.updatedAt),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BannerRuleView(
      rules: _rules,
      onAddRule: () => _save(),
      onEditRule: (rule) => _save(existing: rule),
    );
  }
}
