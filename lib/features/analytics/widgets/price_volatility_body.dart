import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_price_volatility_alerts.dart';
import 'package:growth_pilot_ai/business/dispatch_price_volatility_alerts.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/price_alert_threshold_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/price_alert_threshold_repository.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_view.dart';

/// Owns the threshold value and dispatches Inbox notifications for
/// newly-breached alerts on each build (Issue #340) — this app has no
/// push/email backend, so breach dispatch happens locally through
/// [DispatchPriceVolatilityAlerts]/[InboxNotificationRepository].
class PriceVolatilityBody extends StatefulWidget {
  final List<CompetitorPriceObservationEntity> observations;
  final double initialThresholdPercent;

  const PriceVolatilityBody(
      {super.key, required this.observations, required this.initialThresholdPercent});

  @override
  State<PriceVolatilityBody> createState() => _PriceVolatilityBodyState();
}

class _PriceVolatilityBodyState extends State<PriceVolatilityBody> {
  late double _thresholdPercent = widget.initialThresholdPercent;

  void _saveThreshold(double value) {
    PriceAlertThresholdRepository(
            Get.find<ObjectBox>().store.box<PriceAlertThresholdEntity>())
        .save(PriceAlertThresholdEntity(thresholdPercent: value));
    setState(() => _thresholdPercent = value);
  }

  void _dispatchNewBreaches(List<PriceVolatilityAlert> results) {
    final store = Get.find<ObjectBox>().store;
    final inbox = InboxNotificationRepository(store.box<InboxNotificationEntity>());
    final existingIds = inbox
        .getAll()
        .where((n) => n.metadataRefType == 'PriceVolatility')
        .map((n) => n.metadataRefId ?? '')
        .toSet();
    for (final n in DispatchPriceVolatilityAlerts.call(results, existingIds)) {
      inbox.upsert(n);
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputePriceVolatilityAlerts.call(widget.observations, _thresholdPercent);
    WidgetsBinding.instance.addPostFrameCallback((_) => _dispatchNewBreaches(results));
    return PriceVolatilityView(
      results: results,
      thresholdPercent: _thresholdPercent,
      onThresholdSaved: _saveThreshold,
    );
  }
}
