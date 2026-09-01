import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_promo_engagement_rate.dart';
import 'package:growth_pilot_ai/business/record_promo_click.dart';
import 'package:growth_pilot_ai/business/record_promo_impression.dart';
import 'package:growth_pilot_ai/business/select_promo_card_for_context.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/promo_card_metrics_repository.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promo_card_view.dart';

/// Selects the sponsored card for the current context and records its
/// impression once mounted (Issue #402) — mounting only happens after
/// the shared [LazyWidgetWrapper] confirms the tile scrolled into view,
/// so this reuses that existing viewport infrastructure instead of a
/// second nested visibility detector.
class PromoCardBody extends StatefulWidget {
  final List<AdvertisingRequestEntity> requests;
  final BusinessSector sector;

  const PromoCardBody({super.key, required this.requests, required this.sector});

  @override
  State<PromoCardBody> createState() => _PromoCardBodyState();
}

class _PromoCardBodyState extends State<PromoCardBody> {
  PromoCardMetricsEntity? _metrics;
  AdvertisingRequestEntity? _selected;

  @override
  void initState() {
    super.initState();
    _selected = SelectPromoCardForContext.call(widget.requests, widget.sector);
    if (_selected != null) _recordImpression(_selected!.id);
  }

  void _recordImpression(int requestId) {
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    final updated =
        RecordPromoImpression.call(repo.forRequest(requestId), requestId, DateTime.now());
    repo.save(updated);
    setState(() => _metrics = updated);
  }

  void _recordClick() {
    if (_metrics == null) return;
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    final updated = RecordPromoClick.call(_metrics!);
    repo.save(updated);
    setState(() => _metrics = updated);
  }

  @override
  Widget build(BuildContext context) {
    return PromoCardView(
      selected: _selected,
      engagementRatePercent: ComputePromoEngagementRate.call(_metrics),
      impressionCount: _metrics?.impressionCount ?? 0,
      onTap: _recordClick,
    );
  }
}
