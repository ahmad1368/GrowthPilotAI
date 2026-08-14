import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_cap_expansion_request.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cap_expansion_request_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showCapExpansionRequestDialog] (Issue #344).
class CapExpansionRequestDialogContent extends StatefulWidget {
  const CapExpansionRequestDialogContent({super.key});

  @override
  State<CapExpansionRequestDialogContent> createState() =>
      _CapExpansionRequestDialogContentState();
}

class _CapExpansionRequestDialogContentState
    extends State<CapExpansionRequestDialogContent> {
  final _requestedCapController = TextEditingController();
  final _reasonController = TextEditingController();

  void _submit() {
    final requestedCap = double.tryParse(_requestedCapController.text);
    if (requestedCap == null || requestedCap <= 0 || _reasonController.text.trim().isEmpty) {
      return;
    }
    Navigator.of(context).pop(BuildCapExpansionRequest.call(
      requestedCapAmount: requestedCap,
      reason: _reasonController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Request Cap Increase'),
      description: CapExpansionRequestFields(
        requestedCapController: _requestedCapController,
        reasonController: _reasonController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Submit')),
      ],
    );
  }
}
