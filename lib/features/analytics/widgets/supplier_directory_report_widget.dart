import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_body.dart';

/// Registers the Local Supplier Directory widget (Issue #442) as a
/// pluggable report widget under id `SUPPLIER_DIRECTORY` (#111).
class SupplierDirectoryReportWidget extends BaseReportWidget {
  const SupplierDirectoryReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return SupplierBody(initialVendors: data['vendors'] as List<VendorEntity>);
  }
}
