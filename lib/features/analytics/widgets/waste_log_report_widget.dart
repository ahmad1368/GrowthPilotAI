import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_log_body.dart';

/// Registers the Food Waste & Spoilage Tracking widget (Issue #377) as a
/// pluggable report widget under id `WASTE_LOG` (#111): total loss +
/// reason breakdown, with a quick-add entry button.
class WasteLogReportWidget extends BaseReportWidget {
  const WasteLogReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return WasteLogBody(
      initialEntries: data['wasteEntries'] as List<WasteLogEntity>,
    );
  }
}
