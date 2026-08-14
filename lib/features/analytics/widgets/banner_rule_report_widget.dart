import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_body.dart';

/// Registers the banner matching rules admin panel (Issue #403,
/// acceptance criterion 4) as a pluggable report widget under id
/// `BANNER_MATCHING_RULES_PANEL` (#111).
class BannerRuleReportWidget extends BaseReportWidget {
  const BannerRuleReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return BannerRuleBody(initialRules: data['rules'] as List<BannerMatchingRuleEntity>);
  }
}
