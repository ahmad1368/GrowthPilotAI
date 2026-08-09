import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/membership_resolver.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

/// "Switching Contexts" (Issue #156 AC): lets a user with memberships in
/// several businesses swap the active org without re-authenticating, while
/// [MembershipResolver] keeps the switch confined to businesses they still
/// have active access to.
class OrgSwitcherController extends GetxController {
  final memberships = <Membership>[].obs;
  final activeBusinessId = RxnString();

  void loadMemberships(List<Membership> value) {
    memberships.assignAll(value);
    final accessible = MembershipResolver.accessibleBusinessIds(value);
    if (activeBusinessId.value == null && accessible.isNotEmpty) {
      activeBusinessId.value = accessible.first;
    }
  }

  bool switchTo(String businessId) {
    if (!MembershipResolver.hasAccess(memberships, businessId)) return false;
    activeBusinessId.value = businessId;
    return true;
  }

  List<String> get accessibleBusinessIds =>
      MembershipResolver.accessibleBusinessIds(memberships);
}
