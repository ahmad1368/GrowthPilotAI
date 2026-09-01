import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/core/enum/vancouver_neighborhood.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful compose form for [showEmergencyBroadcastDialog] (Issue
/// #345): owns the selected neighborhoods and message text.
class EmergencyBroadcastDialogContent extends StatefulWidget {
  const EmergencyBroadcastDialogContent({super.key});

  @override
  State<EmergencyBroadcastDialogContent> createState() =>
      _EmergencyBroadcastDialogContentState();
}

class _EmergencyBroadcastDialogContentState
    extends State<EmergencyBroadcastDialogContent> {
  final _messageController = TextEditingController();
  final _recipientCountController = TextEditingController();
  final _selectedNeighborhoods = <VancouverNeighborhood>{};

  void _submit() {
    final recipientCount = int.tryParse(_recipientCountController.text);
    if (_messageController.text.trim().isEmpty ||
        _selectedNeighborhoods.isEmpty ||
        recipientCount == null ||
        recipientCount < 0) {
      return;
    }
    Navigator.of(context).pop(EmergencyBroadcastEntity(
      messageBody: _messageController.text.trim(),
      targetNeighborhoods: _selectedNeighborhoods.map((n) => n.name).join(', '),
      recipientCount: recipientCount,
      dispatchedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Compose Emergency Broadcast'),
      description: StatefulBuilder(builder: (context, setLocalState) {
        return EmergencyBroadcastFields(
          selectedNeighborhoods: _selectedNeighborhoods,
          messageController: _messageController,
          recipientCountController: _recipientCountController,
          onToggleNeighborhood: (n) => setLocalState(() => _selectedNeighborhoods.contains(n)
              ? _selectedNeighborhoods.remove(n)
              : _selectedNeighborhoods.add(n)),
        );
      }),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Dispatch')),
      ],
    );
  }
}
