import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_cra_retention_status.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';

/// One CRA compliance log entry (Issue #428, acceptance criteria 2,
/// 4 and 5) — the counterparty name stays masked until revealed, so
/// the encrypted-at-rest field isn't defeated by always showing it in
/// plaintext on screen.
class CraComplianceLogRow extends StatefulWidget {
  final CraComplianceRow row;
  const CraComplianceLogRow({super.key, required this.row});

  @override
  State<CraComplianceLogRow> createState() => _CraComplianceLogRowState();
}

class _CraComplianceLogRowState extends State<CraComplianceLogRow> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.row;
    final remaining = ComputeCraRetentionStatus.remaining(r.loggedAt, DateTime.now());
    final counterparty = _revealed ? r.counterpartyName : '•' * r.counterpartyName.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Expanded(
          child: Text(
            '$counterparty — ${r.currency} ${r.amount.toStringAsFixed(2)} — '
            '${r.taxCategory.name} — ${r.integrityValid ? "verified" : "TAMPERED"} — '
            'retention ${remaining.inDays}d left',
            style: TextStyle(fontSize: 12, color: r.integrityValid ? null : Colors.red),
          ),
        ),
        IconButton(
          icon: Icon(_revealed ? Icons.visibility_off : Icons.visibility, size: 16),
          onPressed: () => setState(() => _revealed = !_revealed),
        ),
      ]),
    );
  }
}
