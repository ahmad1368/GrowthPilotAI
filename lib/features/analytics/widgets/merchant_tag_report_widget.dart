import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_body.dart';

/// Registers the Advanced Tagging & Categorization Tool (Issue #342) as
/// a pluggable report widget under id `MERCHANT_TAG_TOOL` (#111).
class MerchantTagReportWidget extends BaseReportWidget {
  const MerchantTagReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MerchantTagBody(
      merchantConfigs: data['configs'] as List<MerchantConfigEntity>,
      initialTags: data['tags'] as List<MerchantTagEntity>,
    );
  }
}
