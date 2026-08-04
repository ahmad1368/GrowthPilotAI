import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/contextual_banner.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart_body.dart';

/// Registers the Profit Margin Analysis widget (Issue #350) as a pluggable
/// report widget under id `PROFIT_MARGIN_CHART` (#111). Appends the
/// contextual promotional banner (Issue #403) below the analysis, since
/// "profit margin breakdown" is the exact report type that issue names.
class ProfitMarginReportWidget extends BaseReportWidget {
  const ProfitMarginReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfitMarginChartBody(
            transactions: data['transactions'] as List<TransactionEntity>),
        ContextualBanner(
          reportTopic: 'profit margin',
          rules: data['bannerRules'] as List<BannerMatchingRuleEntity>,
          approvedRequests: data['adRequests'] as List<AdvertisingRequestEntity>,
        ),
      ],
    );
  }
}
