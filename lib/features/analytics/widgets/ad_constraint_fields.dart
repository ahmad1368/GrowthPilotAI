import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Request picker and numeric cap fields for the constraint form (Issue #409).
class AdConstraintFields extends StatelessWidget {
  final AdConstraintFormController form;
  final VoidCallback onChanged;

  const AdConstraintFields({super.key, required this.form, required this.onChanged});

  void _select(AdvertisingRequestEntity r) {
    form.selected = r;
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    if (form.unconstrained.isEmpty) {
      return const Text('No approved, unconstrained campaigns to configure.');
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 8, children: [
          for (final r in form.unconstrained)
            if (form.selected?.id == r.id)
              ShadButton(onPressed: () => _select(r), child: Text(r.merchantName))
            else
              ShadButton.outline(onPressed: () => _select(r), child: Text(r.merchantName)),
        ]),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Max days'), controller: form.days, keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Max impressions'),
            controller: form.impressions,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Max clicks'),
            controller: form.clicks,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
