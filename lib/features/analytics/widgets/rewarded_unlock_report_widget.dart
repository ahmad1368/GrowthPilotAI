import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_body.dart';

/// Registers the Value-Exchange Rewarded Promos unlock log (Issue
/// #405) as a pluggable report widget under id `REWARDED_UNLOCK_LOG`
/// (#111).
class RewardedUnlockReportWidget extends BaseReportWidget {
  const RewardedUnlockReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return RewardedUnlockBody(
        initialUnlocks: data['unlocks'] as List<RewardedUnlockEntity>);
  }
}
