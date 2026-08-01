import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showTrafficSteeringDialog] (Issue #334): owns
/// the text controllers for the new directive.
class TrafficSteeringDialogContent extends StatefulWidget {
  const TrafficSteeringDialogContent({super.key});

  @override
  State<TrafficSteeringDialogContent> createState() =>
      _TrafficSteeringDialogContentState();
}

class _TrafficSteeringDialogContentState
    extends State<TrafficSteeringDialogContent> {
  final _targetNameController = TextEditingController();
  final _destinationLabelController = TextEditingController();
  final _redirectCountController = TextEditingController();

  void _submit() {
    final redirectCount = int.tryParse(_redirectCountController.text);
    if (_targetNameController.text.trim().isEmpty ||
        _destinationLabelController.text.trim().isEmpty ||
        redirectCount == null ||
        redirectCount < 0) {
      return;
    }
    Navigator.of(context).pop(TrafficSteeringDirectiveEntity(
      targetName: _targetNameController.text.trim(),
      destinationLabel: _destinationLabelController.text.trim(),
      redirectCount: redirectCount,
      createdAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Steering Directive'),
      description: TrafficSteeringFields(
        targetNameController: _targetNameController,
        destinationLabelController: _destinationLabelController,
        redirectCountController: _redirectCountController,
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
