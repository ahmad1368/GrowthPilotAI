import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful checkout financing form for [showMicroCreditDialog]
/// (Issue #419, acceptance criterion 2).
class MicroCreditDialogContent extends StatefulWidget {
  const MicroCreditDialogContent({super.key});

  @override
  State<MicroCreditDialogContent> createState() => _MicroCreditDialogContentState();
}

class _MicroCreditDialogContentState extends State<MicroCreditDialogContent> {
  final _form = MicroCreditFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop((
      sellerName: _form.sellerName.text.trim(),
      itemDescription: _form.itemDescription.text.trim(),
      principal: double.tryParse(_form.principal.text) ?? 0,
      termDays: _form.termDays.value,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Finance This Purchase'),
      description: SingleChildScrollView(child: MicroCreditFields(form: _form)),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Confirm Financing')),
      ],
    );
  }
}
