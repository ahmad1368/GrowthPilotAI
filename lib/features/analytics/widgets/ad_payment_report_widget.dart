import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_body.dart';

/// Registers the Automated Payment Detection and Instant Campaign
/// Activation dashboard (Issue #410) as a pluggable report widget
/// under id `AD_PAYMENT_ACTIVATION_ENGINE` (#111).
class AdPaymentReportWidget extends BaseReportWidget {
  const AdPaymentReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AdPaymentBody(requests: data['requests'] as List<AdvertisingRequestEntity>);
  }
}
