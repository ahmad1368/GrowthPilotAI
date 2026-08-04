import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_body.dart';

/// Registers the Merchant Self-Service Advertising Request Dashboard
/// (Issue #401) as a pluggable report widget under id
/// `AD_REQUEST_DASHBOARD` (#111).
class AdRequestReportWidget extends BaseReportWidget {
  const AdRequestReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AdRequestBody(
      initialRequests: data['requests'] as List<AdvertisingRequestEntity>,
    );
  }
}
