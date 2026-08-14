import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful constraint composer form for [showAdConstraintDialog]
/// (Issue #409).
class AdConstraintDialogContent extends StatefulWidget {
  final List<AdvertisingRequestEntity> unconstrained;

  const AdConstraintDialogContent({super.key, required this.unconstrained});

  @override
  State<AdConstraintDialogContent> createState() =>
      _AdConstraintDialogContentState();
}

class _AdConstraintDialogContentState extends State<AdConstraintDialogContent> {
  late final _form = AdConstraintFormController(widget.unconstrained);

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Configure Campaign Limits'),
      description: AdConstraintFields(form: _form, onChanged: () => setState(() {})),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Save Limits')),
      ],
    );
  }
}
