import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_body.dart';

/// Registers the Add/Edit Product form demo (Issue #140) as a
/// pluggable report widget under id `PRODUCT_FORM_WITH_IMAGES` (#111).
class ProductFormReportWidget extends BaseReportWidget {
  const ProductFormReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const ProductFormBody();
  }
}
