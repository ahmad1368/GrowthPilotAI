import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_basic_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_terms_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful campaign composer form for [showGroupPurchaseDialog]
/// (Issue #414).
class GroupPurchaseDialogContent extends StatefulWidget {
  const GroupPurchaseDialogContent({super.key});

  @override
  State<GroupPurchaseDialogContent> createState() => _GroupPurchaseDialogContentState();
}

class _GroupPurchaseDialogContentState extends State<GroupPurchaseDialogContent> {
  final _form = GroupPurchaseFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Start Group Purchase'),
      description: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupPurchaseBasicFields(form: _form),
            const SizedBox(height: 8),
            GroupPurchaseTermsFields(form: _form),
          ],
        ),
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Publish Campaign')),
      ],
    );
  }
}
