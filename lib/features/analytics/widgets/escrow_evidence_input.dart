import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_evidence_selector.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Lets either party attach a piece of evidence to a disputed escrow
/// account (Issue #427, acceptance criterion 2).
class EscrowEvidenceInput extends StatefulWidget {
  final EscrowAccountEntity account;
  final void Function(String submittedBy, DisputeEvidenceType type, String description) onSubmit;

  const EscrowEvidenceInput({super.key, required this.account, required this.onSubmit});

  @override
  State<EscrowEvidenceInput> createState() => _EscrowEvidenceInputState();
}

class _EscrowEvidenceInputState extends State<EscrowEvidenceInput> {
  final _controller = TextEditingController();
  DisputeEvidenceType _type = DisputeEvidenceType.other;
  bool _asBuyer = true;

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final submittedBy = _asBuyer ? widget.account.buyerName : widget.account.sellerName;
    widget.onSubmit(submittedBy, _type, text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      EscrowEvidenceSelector(
        asBuyer: _asBuyer,
        type: _type,
        onAsBuyerChanged: (v) => setState(() => _asBuyer = v),
        onTypeChanged: (t) => setState(() => _type = t),
      ),
      TextField(
        controller: _controller,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(hintText: 'Describe the evidence...'),
      ),
      ShadButton.ghost(onPressed: _submit, child: const Text('Submit Evidence')),
    ]);
  }
}
