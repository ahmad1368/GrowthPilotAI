import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_brand_penetration_index.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/brand_penetration_scorecard.dart';

/// Registers the Regional Brand Penetration Index widget (Issue #359) as a
/// pluggable report widget under id `BRAND_PENETRATION_INDEX` (#111).
class BrandPenetrationReportWidget extends BaseReportWidget {
  const BrandPenetrationReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final index = ComputeBrandPenetrationIndex.call(
      data['transactions'] as List<TransactionEntity>,
      data['sector'] as BusinessSector,
    );
    return BrandPenetrationScorecard(index: index);
  }
}
