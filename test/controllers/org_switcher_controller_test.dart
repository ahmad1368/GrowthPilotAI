import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/org_switcher_controller.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

Membership _m(String biz, MembershipStatus status) => Membership(
    userId: 'u1', businessId: biz, role: MembershipRole.owner, status: status);

void main() {
  test('loadMemberships auto-selects the first accessible business', () {
    final controller = OrgSwitcherController();
    controller.loadMemberships([
      _m('biz-a', MembershipStatus.active),
      _m('biz-b', MembershipStatus.pending),
    ]);

    expect(controller.activeBusinessId.value, 'biz-a');
    expect(controller.accessibleBusinessIds, ['biz-a']);
  });

  test('switchTo moves between accessible businesses without re-auth', () {
    final controller = OrgSwitcherController();
    controller.loadMemberships([
      _m('biz-a', MembershipStatus.active),
      _m('biz-b', MembershipStatus.active),
    ]);

    expect(controller.switchTo('biz-b'), isTrue);
    expect(controller.activeBusinessId.value, 'biz-b');
  });

  test('switchTo rejects a business the user has no active membership in', () {
    final controller = OrgSwitcherController();
    controller.loadMemberships([_m('biz-a', MembershipStatus.active)]);

    expect(controller.switchTo('biz-x'), isFalse);
    expect(controller.activeBusinessId.value, 'biz-a');
  });
}
