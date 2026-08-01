import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The foot/vehicle traffic count fields plus date picker for a new
/// logged day (Issue #381).
class TrafficCountFields extends StatelessWidget {
  final TextEditingController footController;
  final TextEditingController vehicleController;
  final DateTime? date;
  final VoidCallback onPickDate;

  const TrafficCountFields({
    super.key,
    required this.footController,
    required this.vehicleController,
    required this.date,
    required this.onPickDate,
  });

  String _label(DateTime? d, String placeholder) => d == null
      ? placeholder
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Foot traffic count'),
            controller: footController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Vehicle traffic count'),
            controller: vehicleController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(date, 'Pick date'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
