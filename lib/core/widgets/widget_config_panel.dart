import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_controls.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';

/// Sliding config side-panel (Issue #115): a flat, native [Drawer] — not
/// the original issue's Glassmorphism/BackdropFilter ask — that lets the
/// user pick a configurable widget from [specs] and tune its options.
class WidgetConfigPanel extends StatefulWidget {
  final List<ReportWidgetSpec> specs;

  const WidgetConfigPanel({super.key, required this.specs});

  @override
  State<WidgetConfigPanel> createState() => _WidgetConfigPanelState();
}

class _WidgetConfigPanelState extends State<WidgetConfigPanel> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final config = Get.find<WidgetConfigController>();
    final configurable = widget.specs
        .where((s) => WidgetConfigRegistry.optionsFor(s.id).isNotEmpty)
        .toList();
    _selectedId ??= configurable.isNotEmpty ? configurable.first.id : null;
    final selectedId = _selectedId;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Configure Widget',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              if (selectedId == null)
                const Text('No configurable widgets on this dashboard.')
              else ...[
                DropdownButton<String>(
                  value: selectedId,
                  isExpanded: true,
                  items: [
                    for (final s in configurable)
                      DropdownMenuItem(value: s.id, child: Text(s.title)),
                  ],
                  onChanged: (id) => setState(() => _selectedId = id),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    final options =
                        WidgetConfigRegistry.optionsFor(selectedId);
                    return WidgetConfigControls(
                      options: options,
                      values: {
                        for (final o in options)
                          o.key: config.valueFor(
                              selectedId, o.key, o.defaultValue)
                      },
                      onChanged: (key, value) =>
                          config.setValue(selectedId, key, value),
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
