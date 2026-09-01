import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_body.dart';

/// Registers the Business Discovery & Search demo (Issue #121) as a
/// pluggable report widget under id `BUSINESS_DISCOVERY_SEARCH` (#111).
class DiscoveryReportWidget extends BaseReportWidget {
  const DiscoveryReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const DiscoveryBody();
  }
}
