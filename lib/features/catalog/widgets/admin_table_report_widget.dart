import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_body.dart';

/// Registers the Admin Product Table demo (Issue #143) as a
/// pluggable report widget under id `PRODUCT_ADMIN_DATA_TABLE`
/// (#111).
class AdminTableReportWidget extends BaseReportWidget {
  const AdminTableReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const AdminTableBody();
  }
}
