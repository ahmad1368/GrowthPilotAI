import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_body.dart';

/// Registers the Targeted Offer and Promotional Dispatcher (Issue #335)
/// as a pluggable report widget under id `PROMOTIONAL_OFFER_DISPATCHER`
/// (#111).
class PromotionalOfferReportWidget extends BaseReportWidget {
  const PromotionalOfferReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PromotionalOfferBody(
      initialOffers: data['offers'] as List<PromotionalOfferEntity>,
    );
  }
}
