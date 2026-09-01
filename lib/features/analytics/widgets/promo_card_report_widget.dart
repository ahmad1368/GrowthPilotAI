import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promo_card_body.dart';

/// Registers the Native Feed Integration sponsored card (Issue #402) as
/// a pluggable report widget under id `NATIVE_FEED_PROMO_CARD` (#111) —
/// blending into the same feed/grid pipeline every organic card uses.
class PromoCardReportWidget extends BaseReportWidget {
  const PromoCardReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PromoCardBody(
      requests: data['requests'] as List<AdvertisingRequestEntity>,
      sector: data['sector'] as BusinessSector,
    );
  }
}
