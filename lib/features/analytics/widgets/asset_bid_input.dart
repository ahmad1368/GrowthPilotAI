import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Bidder-name/amount inline input for submitting a new bid on an
/// active listing (Issue #412, acceptance criterion 3) — split out of
/// [AssetRow] to stay under the file line cap.
class AssetBidInput extends StatefulWidget {
  final void Function(String bidderName, double amount) onSubmit;

  const AssetBidInput({super.key, required this.onSubmit});

  @override
  State<AssetBidInput> createState() => _AssetBidInputState();
}

class _AssetBidInputState extends State<AssetBidInput> {
  final _name = TextEditingController();
  final _amount = TextEditingController();

  void _submit() {
    final amount = double.tryParse(_amount.text);
    if (_name.text.trim().isEmpty || amount == null) return;
    widget.onSubmit(_name.text.trim(), amount);
    _name.clear();
    _amount.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ShadInput(placeholder: const Text('Bidder name'), controller: _name)),
      const SizedBox(width: 4),
      SizedBox(
        width: 90,
        child: ShadInput(
            placeholder: const Text('Bid \$'), controller: _amount, keyboardType: TextInputType.number),
      ),
      ShadButton.ghost(onPressed: _submit, child: const Text('Bid')),
    ]);
  }
}
