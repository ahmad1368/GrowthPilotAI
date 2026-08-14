import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_account_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_claim_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_evidence_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_view_state.dart';

/// Coordinates escrow (#415) and dispute-evidence (#427) mutations,
/// each returning the next [EscrowViewState] so [EscrowBody] stays a
/// thin setState wrapper.
class EscrowBodyActions {
  final EscrowRepos repos;
  late final accounts = EscrowAccountActions(repos);
  late final claims = EscrowClaimActions(repos);
  late final evidence = EscrowEvidenceActions(repos);

  EscrowBodyActions(this.repos);

  EscrowViewState create(EscrowViewState state, EscrowAccountEntity account) =>
      _reload([...state.accounts, accounts.open(account)]);

  EscrowViewState confirmDelivery(EscrowViewState state, EscrowAccountEntity account) =>
      _replace(state, accounts.confirmDelivery(account));

  EscrowViewState fileClaim(
          EscrowViewState state, EscrowAccountEntity account, EscrowClaimReason reason) =>
      _replace(state, claims.fileClaim(account, reason));

  EscrowViewState resolveDispute(
          EscrowViewState state, EscrowAccountEntity account, bool approveRefund) =>
      _replace(state, claims.resolveDispute(account, approveRefund: approveRefund));

  EscrowViewState submitEvidence(EscrowViewState state, EscrowAccountEntity account,
      String submittedBy, DisputeEvidenceType type, String description) {
    evidence.submit(account, submittedBy, type, description);
    return _reload(state.accounts);
  }

  EscrowViewState _replace(EscrowViewState state, EscrowAccountEntity updated) =>
      _reload([for (final a in state.accounts) if (a.id != updated.id) a, updated]);

  EscrowViewState _reload(List<EscrowAccountEntity> list) =>
      EscrowViewState.load(list, repos.evidence.getAll());
}
