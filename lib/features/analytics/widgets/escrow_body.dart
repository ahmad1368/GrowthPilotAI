import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_body_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_view_state.dart';

/// Owns escrow account state for the smart escrow engine (Issue #415)
/// and the dispute evidence dossier (Issue #427) — mutation logic
/// lives in [EscrowBodyActions].
class EscrowBody extends StatefulWidget {
  final List<EscrowAccountEntity> accounts;
  const EscrowBody({super.key, required this.accounts});
  @override
  State<EscrowBody> createState() => _EscrowBodyState();
}

class _EscrowBodyState extends State<EscrowBody> {
  final _repos = EscrowRepos();
  late final _actions = EscrowBodyActions(_repos);
  late EscrowViewState _state = EscrowViewState.load(widget.accounts, _repos.evidence.getAll());

  Future<void> _create() async {
    final account = await showEscrowDialog(context);
    if (account == null) return;
    setState(() => _state = _actions.create(_state, account));
  }

  @override
  Widget build(BuildContext context) {
    return EscrowView(
      state: _state,
      onCreate: _create,
      onConfirmDelivery: (a) => setState(() => _state = _actions.confirmDelivery(_state, a)),
      onFileClaim: (a, r) => setState(() => _state = _actions.fileClaim(_state, a, r)),
      onResolveDispute: (a, ok) => setState(() => _state = _actions.resolveDispute(_state, a, ok)),
      onSubmitEvidence: (a, by, t, d) =>
          setState(() => _state = _actions.submitEvidence(_state, a, by, t, d)),
    );
  }
}
