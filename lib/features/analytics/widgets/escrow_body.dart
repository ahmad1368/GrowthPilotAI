import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_account_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_claim_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_view.dart';

/// Owns escrow account state for the smart escrow engine (Issue #415).
class EscrowBody extends StatefulWidget {
  final List<EscrowAccountEntity> accounts;
  const EscrowBody({super.key, required this.accounts});
  @override
  State<EscrowBody> createState() => _EscrowBodyState();
}

class _EscrowBodyState extends State<EscrowBody> {
  final _repos = EscrowRepos();
  late final _accountActions = EscrowAccountActions(_repos);
  late final _claimActions = EscrowClaimActions(_repos);
  late List<EscrowAccountEntity> _accounts = widget.accounts;

  void _update(EscrowAccountEntity updated) => setState(() =>
      _accounts = [for (final a in _accounts) if (a.id != updated.id) a, updated]);

  Future<void> _create() async {
    final account = await showEscrowDialog(context);
    if (account == null) return;
    setState(() => _accounts = [..._accounts, _accountActions.open(account)]);
  }

  void _confirmDelivery(EscrowAccountEntity account) =>
      _update(_accountActions.confirmDelivery(account));

  void _fileClaim(EscrowAccountEntity account, EscrowClaimReason reason) =>
      _update(_claimActions.fileClaim(account, reason));

  void _resolveDispute(EscrowAccountEntity account, bool approveRefund) =>
      _update(_claimActions.resolveDispute(account, approveRefund: approveRefund));

  @override
  Widget build(BuildContext context) {
    return EscrowView(
      accounts: _accounts,
      onCreate: _create,
      onConfirmDelivery: _confirmDelivery,
      onFileClaim: _fileClaim,
      onResolveDispute: _resolveDispute,
    );
  }
}
