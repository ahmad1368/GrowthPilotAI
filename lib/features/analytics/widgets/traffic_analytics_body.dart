import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_traffic_analytics.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/traffic_count_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_analytics_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_count_dialog.dart';

/// Owns the logged-traffic-count list (Issue #381), refreshing it
/// locally after each quick-add insert — mirrors [ConversionRateBody]'s
/// pattern.
class TrafficAnalyticsBody extends StatefulWidget {
  final List<TrafficCountEntity> initialCounts;
  final List<TransactionEntity> transactions;

  const TrafficAnalyticsBody(
      {super.key, required this.initialCounts, required this.transactions});

  @override
  State<TrafficAnalyticsBody> createState() => _TrafficAnalyticsBodyState();
}

class _TrafficAnalyticsBodyState extends State<TrafficAnalyticsBody> {
  late List<TrafficCountEntity> _counts = widget.initialCounts;

  Future<void> _addCount() async {
    final count = await showTrafficCountDialog(context);
    if (count == null) return;
    TrafficCountRepository(Get.find<ObjectBox>().store.box<TrafficCountEntity>())
        .insert(count);
    setState(() => _counts = [..._counts, count]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeTrafficAnalytics.call(_counts, widget.transactions);
    return TrafficAnalyticsView(results: results, onAddCount: _addCount);
  }
}
