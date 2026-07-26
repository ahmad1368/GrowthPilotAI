import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/store_profile_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_body.dart';

/// Registers the Commercial Space Productivity Index widget (Issue #398)
/// as a pluggable report widget under id `SPACE_PRODUCTIVITY` (#111).
class SpaceProductivityReportWidget extends BaseReportWidget {
  const SpaceProductivityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return SpaceProductivityBody(
      transactions: data['transactions'] as List<TransactionEntity>,
      initialProfile: data['storeProfile'] as StoreProfileEntity,
    );
  }
}
