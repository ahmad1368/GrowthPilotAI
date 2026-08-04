import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/record_promo_click.dart';
import 'package:growth_pilot_ai/business/record_promo_impression.dart';
import 'package:growth_pilot_ai/business/recommend_banner_for_topic.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/promo_card_metrics_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/contextual_banner_content.dart';

/// Appends a contextual promotional banner to the bottom of an
/// analytical report (Issue #403) — reuses the same aggregate
/// impression/click telemetry [PromoCardMetricsEntity] the native feed
/// promo card (#402) writes to, since both are the same underlying
/// advertising request being surfaced through a different placement.
/// Renders nothing when no rule/request matches the report's topic.
class ContextualBanner extends StatefulWidget {
  final String reportTopic;
  final List<BannerMatchingRuleEntity> rules;
  final List<AdvertisingRequestEntity> approvedRequests;

  const ContextualBanner({
    super.key,
    required this.reportTopic,
    required this.rules,
    required this.approvedRequests,
  });

  @override
  State<ContextualBanner> createState() => _ContextualBannerState();
}

class _ContextualBannerState extends State<ContextualBanner> {
  AdvertisingRequestEntity? _matched;

  @override
  void initState() {
    super.initState();
    _matched = RecommendBannerForTopic.call(
        widget.rules, widget.approvedRequests, widget.reportTopic);
    if (_matched != null) _recordImpression(_matched!.id);
  }

  void _recordImpression(int requestId) {
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    repo.save(RecordPromoImpression.call(repo.forRequest(requestId), requestId, DateTime.now()));
  }

  void _recordClick() {
    if (_matched == null) return;
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    final existing = repo.forRequest(_matched!.id);
    if (existing != null) repo.save(RecordPromoClick.call(existing));
  }

  @override
  Widget build(BuildContext context) {
    if (_matched == null) return const SizedBox.shrink();
    return ContextualBannerContent(request: _matched!, onTap: _recordClick);
  }
}
