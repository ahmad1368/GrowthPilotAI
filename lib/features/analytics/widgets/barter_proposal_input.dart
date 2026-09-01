import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_proposal_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Counter-offer input for proposing a trade on an active listing
/// (Issue #413, acceptance criterion 2) — split out of [BarterRow]
/// to stay under the file line cap.
class BarterProposalInput extends StatefulWidget {
  final void Function(String proposerName, String itemName, String itemDescription,
      String category, double value, String zone) onSubmit;

  const BarterProposalInput({super.key, required this.onSubmit});

  @override
  State<BarterProposalInput> createState() => _BarterProposalInputState();
}

class _BarterProposalInputState extends State<BarterProposalInput> {
  final _form = BarterProposalFormController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(child: ShadInput(placeholder: const Text('Your name'), controller: _form.name)),
        const SizedBox(width: 4),
        Expanded(
            child: ShadInput(placeholder: const Text('Item offered'), controller: _form.item)),
      ]),
      const SizedBox(height: 4),
      Row(children: [
        Expanded(
            child: ShadInput(placeholder: const Text('Category'), controller: _form.category)),
        const SizedBox(width: 4),
        SizedBox(
          width: 80,
          child: ShadInput(
              placeholder: const Text('Value \$'),
              controller: _form.value,
              keyboardType: TextInputType.number),
        ),
        const SizedBox(width: 4),
        Expanded(child: ShadInput(placeholder: const Text('Zone'), controller: _form.zone)),
        ShadButton.ghost(
            onPressed: () => _form.submit(widget.onSubmit), child: const Text('Propose')),
      ]),
    ]);
  }
}
