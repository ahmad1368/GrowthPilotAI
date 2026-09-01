import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_basic_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_value_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful listing composer form for [showBarterDialog] (Issue
/// #413) — includes the plain-language accounting note required by
/// acceptance criterion 5, since barter trades are taxable income at
/// fair market value under CRA rules and this app has no legal team
/// to draft a full policy document.
class BarterDialogContent extends StatefulWidget {
  const BarterDialogContent({super.key});

  @override
  State<BarterDialogContent> createState() => _BarterDialogContentState();
}

class _BarterDialogContentState extends State<BarterDialogContent> {
  final _form = BarterFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    return ShadDialog.alert(
      title: const Text('List Item for Barter'),
      description: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BarterBasicFields(form: _form),
            const SizedBox(height: 8),
            BarterValueFields(form: _form),
            const SizedBox(height: 8),
            Text(
              'Barter trades must be recorded at fair market value and reported '
              'as income for CRA tax purposes; consult your accountant.',
              style: TextStyle(fontSize: 11, color: muted),
            ),
          ],
        ),
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('List Item')),
      ],
    );
  }
}
