import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_conversion_rates.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/visitor_count_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/conversion_rate_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/visitor_count_dialog.dart';

/// Owns the logged-visitor-count list (Issue #387), refreshing it
/// locally after each quick-add insert — mirrors
/// [DiscountCampaignImpactBody]'s pattern.
class ConversionRateBody extends StatefulWidget {
  final List<VisitorCountEntity> initialCounts;
  final List<TransactionEntity> transactions;

  const ConversionRateBody(
      {super.key, required this.initialCounts, required this.transactions});

  @override
  State<ConversionRateBody> createState() => _ConversionRateBodyState();
}

class _ConversionRateBodyState extends State<ConversionRateBody> {
  late List<VisitorCountEntity> _counts = widget.initialCounts;

  Future<void> _addCount() async {
    final count = await showVisitorCountDialog(context);
    if (count == null) return;
    VisitorCountRepository(Get.find<ObjectBox>().store.box<VisitorCountEntity>())
        .insert(count);
    setState(() => _counts = [..._counts, count]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeConversionRates.call(_counts, widget.transactions);
    return ConversionRateView(results: results, onAddCount: _addCount);
  }
}
