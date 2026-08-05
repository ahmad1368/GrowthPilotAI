import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_body.dart';

/// Registers the Ad Campaign Constraint Enforcement dashboard (Issue
/// #409) as a pluggable report widget under id
/// `AD_CAMPAIGN_CONSTRAINT_ENGINE` (#111).
class AdConstraintReportWidget extends BaseReportWidget {
  const AdConstraintReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AdConstraintBody(
      requests: data['requests'] as List<AdvertisingRequestEntity>,
    );
  }
}
