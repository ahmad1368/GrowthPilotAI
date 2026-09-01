import 'package:growth_pilot_ai/business/contribute_to_group_purchase.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_repos.dart';

/// Contribution submission (Issue #414, acceptance criterion 1) —
/// split out of [GroupPurchaseBody].
class GroupContributionActions {
  final GroupPurchaseRepos repos;

  GroupContributionActions(this.repos);

  void contribute(int groupPurchaseId, String merchantName, int quantity) {
    repos.contributions
        .save(ContributeToGroupPurchase.call(groupPurchaseId, merchantName, quantity, DateTime.now()));
  }
}
