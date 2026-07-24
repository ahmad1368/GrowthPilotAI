import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_apply_bar.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_controls.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_selector.dart';

/// The dropdown + toggle list + Apply/Reset for one selected widget in the
/// config side-panel (Issues #115/#116), split out of [WidgetConfigPanel]
/// to keep it under the file-size budget.
class WidgetConfigEditor extends StatelessWidget {
  final List<ReportWidgetSpec> configurable;
  final String selectedId;
  final ValueChanged<String?> onSelect;
  final WidgetPreviewController preview;

  const WidgetConfigEditor({
    super.key,
    required this.configurable,
    required this.selectedId,
    required this.onSelect,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetConfigSelector(
          options: configurable,
          selectedId: selectedId,
          onChanged: onSelect,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Obx(() {
            final options = WidgetConfigRegistry.optionsFor(selectedId);
            return WidgetConfigControls(
              options: options,
              values: {
                for (final o in options)
                  o.key: preview.valueFor(selectedId, o.key, o.defaultValue)
              },
              onChanged: (key, value) =>
                  preview.updatePreview(selectedId, key, value),
            );
          }),
        ),
        Obx(() => WidgetConfigApplyBar(
              isPreviewing: preview.isPreviewing(selectedId),
              onApply: () => preview.apply(selectedId),
              onReset: () => preview.discard(selectedId),
            )),
      ],
    );
  }
}
