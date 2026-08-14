import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_body.dart';

/// Registers the Complementary Neighborhood Merchant Partnership Analyzer
/// (Issue #393) as a pluggable report widget under id
/// `MERCHANT_PARTNERSHIP_ANALYZER` (#111).
class MerchantPartnershipReportWidget extends BaseReportWidget {
  const MerchantPartnershipReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MerchantPartnershipBody(
      initialPartnerships:
          data['partnerships'] as List<MerchantPartnershipEntity>,
    );
  }
}
