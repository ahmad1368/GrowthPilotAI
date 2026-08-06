import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Wanted-item, valuation, category, and zone fields for the
/// new-listing form (Issue #413, acceptance criterion 1) — these
/// feed [MatchBarterProposal]'s value/category/proximity scoring.
class BarterValueFields extends StatelessWidget {
  final BarterFormController form;

  const BarterValueFields({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Wanted in exchange (e.g. Bar Stools)'),
            controller: form.wantedItemName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Category (e.g. Furniture)'), controller: form.category),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Estimated value (\$)'),
            controller: form.estimatedValue,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Commercial zone (e.g. Downtown Vancouver)'),
            controller: form.geoZone),
      ],
    );
  }
}
