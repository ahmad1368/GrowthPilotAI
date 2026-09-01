import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';

/// Snapshot of everything [EscrowView] needs to render (Issue #427) —
/// accounts plus their evidence dossiers, grouped in one pass.
class EscrowViewState {
  final List<EscrowAccountEntity> accounts;
  final Map<int, List<DisputeEvidenceEntity>> evidenceByAccount;

  const EscrowViewState({required this.accounts, required this.evidenceByAccount});

  factory EscrowViewState.load(
    List<EscrowAccountEntity> accounts,
    List<DisputeEvidenceEntity> allEvidence,
  ) {
    return EscrowViewState(
      accounts: accounts,
      evidenceByAccount: {
        for (final a in accounts) a.id: allEvidence.where((e) => e.escrowAccountId == a.id).toList(),
      },
    );
  }
}
