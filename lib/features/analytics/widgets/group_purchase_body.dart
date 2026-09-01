import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_contribution_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_view.dart';

/// Owns campaign/contribution state for the group-buying coordinator
/// (Issue #414).
class GroupPurchaseBody extends StatefulWidget {
  final List<GroupPurchaseEntity> purchases;
  const GroupPurchaseBody({super.key, required this.purchases});
  @override
  State<GroupPurchaseBody> createState() => _GroupPurchaseBodyState();
}

class _GroupPurchaseBodyState extends State<GroupPurchaseBody> {
  final _repos = GroupPurchaseRepos();
  late final _purchaseActions = GroupPurchaseActions(_repos);
  late final _contributionActions = GroupContributionActions(_repos);
  late List<GroupPurchaseEntity> _purchases = widget.purchases;
  late List<GroupPurchaseContributionEntity> _contributions = _repos.contributions.getAll();

  void _updatePurchase(GroupPurchaseEntity updated) => setState(() =>
      _purchases = [for (final p in _purchases) if (p.id != updated.id) p, updated]);

  Future<void> _create() async {
    final purchase = await showGroupPurchaseDialog(context);
    if (purchase == null) return;
    setState(() => _purchases = [..._purchases, _purchaseActions.create(purchase)]);
  }

  void _contribute(GroupPurchaseEntity purchase, String name, int qty) {
    _contributionActions.contribute(purchase.id, name, qty);
    setState(() => _contributions = _repos.contributions.getAll());
  }

  void _finalize(GroupPurchaseEntity purchase) =>
      _updatePurchase(_purchaseActions.finalizeCampaign(purchase));

  @override
  Widget build(BuildContext context) {
    return GroupPurchaseView(
      purchases: _purchases,
      contributions: _contributions,
      onCreate: _create,
      onContribute: _contribute,
      onFinalize: _finalize,
    );
  }
}
