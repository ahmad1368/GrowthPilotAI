import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';

/// Submitter (buyer/seller) and evidence-type pickers for
/// [EscrowEvidenceInput] (Issue #427, acceptance criterion 2).
class EscrowEvidenceSelector extends StatelessWidget {
  final bool asBuyer;
  final DisputeEvidenceType type;
  final void Function(bool) onAsBuyerChanged;
  final void Function(DisputeEvidenceType) onTypeChanged;

  const EscrowEvidenceSelector({
    super.key,
    required this.asBuyer,
    required this.type,
    required this.onAsBuyerChanged,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ChoiceChip(label: const Text('Buyer'), selected: asBuyer, onSelected: (_) => onAsBuyerChanged(true)),
      const SizedBox(width: 4),
      ChoiceChip(label: const Text('Seller'), selected: !asBuyer, onSelected: (_) => onAsBuyerChanged(false)),
      const SizedBox(width: 8),
      DropdownButton<DisputeEvidenceType>(
        value: type,
        items: [
          for (final t in DisputeEvidenceType.values) DropdownMenuItem(value: t, child: Text(t.name)),
        ],
        onChanged: (t) => onTypeChanged(t!),
      ),
    ]);
  }
}
