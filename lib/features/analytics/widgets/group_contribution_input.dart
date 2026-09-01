import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Merchant-name/quantity inline input for pledging toward an open
/// campaign (Issue #414, acceptance criterion 1) — split out of
/// [GroupPurchaseRow] to stay under the file line cap.
class GroupContributionInput extends StatefulWidget {
  final void Function(String merchantName, int quantity) onSubmit;

  const GroupContributionInput({super.key, required this.onSubmit});

  @override
  State<GroupContributionInput> createState() => _GroupContributionInputState();
}

class _GroupContributionInputState extends State<GroupContributionInput> {
  final _name = TextEditingController();
  final _quantity = TextEditingController();

  void _submit() {
    final quantity = int.tryParse(_quantity.text);
    if (_name.text.trim().isEmpty || quantity == null || quantity <= 0) return;
    widget.onSubmit(_name.text.trim(), quantity);
    _name.clear();
    _quantity.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ShadInput(placeholder: const Text('Merchant name'), controller: _name)),
      const SizedBox(width: 4),
      SizedBox(
        width: 90,
        child: ShadInput(
            placeholder: const Text('Qty'), controller: _quantity, keyboardType: TextInputType.number),
      ),
      ShadButton.ghost(onPressed: _submit, child: const Text('Pledge')),
    ]);
  }
}
