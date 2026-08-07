import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_dispute_dossier_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';

/// The evidence dossier an admin reviews before ruling on a disputed
/// escrow account (Issue #427, acceptance criterion 5).
class EscrowDisputeDossier extends StatelessWidget {
  final List<DisputeEvidenceEntity> evidence;

  const EscrowDisputeDossier({super.key, required this.evidence});

  @override
  Widget build(BuildContext context) {
    if (evidence.isEmpty) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(BuildDisputeDossierSummary.call(evidence),
              style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
          for (final e in evidence)
            Text('${e.submittedBy} (${e.evidenceType.name}): ${e.description}',
                style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.7))),
        ],
      ),
    );
  }
}
