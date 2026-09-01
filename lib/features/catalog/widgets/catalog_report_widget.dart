import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_body.dart';

/// Registers the Product & Service Entity Model demo (Issue #138) as
/// a pluggable report widget under id `CATALOG_LISTING_MODEL` (#111).
class CatalogReportWidget extends BaseReportWidget {
  const CatalogReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const CatalogBody();
  }
}
