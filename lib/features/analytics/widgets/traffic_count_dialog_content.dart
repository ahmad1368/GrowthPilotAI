import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_count_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showTrafficCountDialog] (Issue #381): owns
/// the foot/vehicle controllers and picked date.
class TrafficCountDialogContent extends StatefulWidget {
  const TrafficCountDialogContent({super.key});

  @override
  State<TrafficCountDialogContent> createState() =>
      _TrafficCountDialogContentState();
}

class _TrafficCountDialogContentState
    extends State<TrafficCountDialogContent> {
  final _footController = TextEditingController();
  final _vehicleController = TextEditingController();
  DateTime? _date;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final foot = int.tryParse(_footController.text);
    final vehicle = int.tryParse(_vehicleController.text);
    if (foot == null || foot < 0 || vehicle == null || vehicle < 0 || _date == null) {
      return;
    }
    Navigator.of(context).pop(TrafficCountEntity(
      footTraffic: foot,
      vehicleTraffic: vehicle,
      date: _date!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Traffic Count'),
      description: TrafficCountFields(
        footController: _footController,
        vehicleController: _vehicleController,
        date: _date,
        onPickDate: _pickDate,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
