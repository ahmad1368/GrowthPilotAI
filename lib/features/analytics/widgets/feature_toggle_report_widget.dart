import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_body.dart';

/// Registers the Modular Feature Toggle Engine (Issue #339) as a
/// pluggable report widget under id `FEATURE_TOGGLE_ENGINE` (#111).
class FeatureToggleReportWidget extends BaseReportWidget {
  const FeatureToggleReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return FeatureToggleBody(
      initialToggles: data['toggles'] as List<FeatureModuleToggleEntity>,
    );
  }
}
