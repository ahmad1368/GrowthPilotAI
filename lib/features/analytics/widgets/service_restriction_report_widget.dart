import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_body.dart';

/// Registers the Granular Service Lockdown and Restriction Engine (Issue
/// #337) as a pluggable report widget under id `SERVICE_LOCKDOWN_ENGINE`
/// (#111).
class ServiceRestrictionReportWidget extends BaseReportWidget {
  const ServiceRestrictionReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ServiceRestrictionBody(
      initialRestrictions: data['restrictions'] as List<ServiceRestrictionEntity>,
    );
  }
}
