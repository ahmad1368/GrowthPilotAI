import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_import_body.dart';

/// Registers the Bulk CSV Import demo (Issue #141) as a pluggable
/// report widget under id `BULK_PRODUCT_IMPORT` (#111).
class BulkImportReportWidget extends BaseReportWidget {
  const BulkImportReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const BulkImportBody();
  }
}
