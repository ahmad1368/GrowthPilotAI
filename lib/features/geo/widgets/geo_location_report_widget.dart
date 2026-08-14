import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_body.dart';

/// Registers the Geo-Location & Map demo (Issue #213) as a pluggable
/// report widget under id `NEARBY_VENDOR_MAP` (#111).
class GeoLocationReportWidget extends BaseReportWidget {
  const GeoLocationReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const GeoLocationBody();
  }
}
