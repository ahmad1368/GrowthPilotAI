import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_grid_body.dart';

/// Registers the Product Catalog grid demo (Issue #142) as a
/// pluggable report widget under id `PRODUCT_CATALOG_GRID` (#111).
class CatalogGridReportWidget extends BaseReportWidget {
  const CatalogGridReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const CatalogGridBody();
  }
}
