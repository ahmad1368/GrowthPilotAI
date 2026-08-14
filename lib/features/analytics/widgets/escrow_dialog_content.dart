import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_basic_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful escrow composer form for [showEscrowDialog] (Issue #415).
class EscrowDialogContent extends StatefulWidget {
  const EscrowDialogContent({super.key});

  @override
  State<EscrowDialogContent> createState() => _EscrowDialogContentState();
}

class _EscrowDialogContentState extends State<EscrowDialogContent> {
  final _form = EscrowFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Open Escrow Account'),
      description: SingleChildScrollView(
        child: EscrowBasicFields(form: _form),
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Deposit to Escrow')),
      ],
    );
  }
}
