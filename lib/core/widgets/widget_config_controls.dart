import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/models/widget_config_option.dart';

/// The toggle rows for one widget's config options (Issue #115). Pure and
/// prop-driven — [values] is an already-resolved snapshot (so GetX's Obx
/// reactivity tracking, which only sees reads made synchronously inside
/// its own builder, stays correct upstream) and this widget needs no GetX
/// lookup of its own, so it stays directly testable.
class WidgetConfigControls extends StatelessWidget {
  final List<WidgetConfigOption> options;
  final Map<String, bool> values;
  final void Function(String key, bool value) onChanged;

  const WidgetConfigControls({
    super.key,
    required this.options,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final option in options)
          SwitchListTile(
            title: Text(option.label),
            value: values[option.key] ?? option.defaultValue,
            onChanged: (value) {
              HapticFeedback.selectionClick();
              onChanged(option.key, value);
            },
          ),
      ],
    );
  }
}
