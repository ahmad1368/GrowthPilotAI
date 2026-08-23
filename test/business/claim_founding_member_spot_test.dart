import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/claim_founding_member_spot.dart';
import 'package:growth_pilot_ai/core/data/entities/founding_member_counter_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/founding_member_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/founding_member_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

class _FakeFoundingMemberRepository implements FoundingMemberRepository {
  FoundingMemberCounterEntity counter = FoundingMemberCounterEntity(capacity: 100);
  final members = <String, FoundingMemberEntity>{};

  @override
  FoundingMemberCounterEntity getCounter() => counter;

  @override
  void incrementCounter() => counter.claimedCount += 1;

  @override
  FoundingMemberEntity? getForBusiness(String businessId) => members[businessId];

  @override
  void saveMember(FoundingMemberEntity member) => members[member.businessId] = member;
}

class _FakeSubscriptionRepository implements SubscriptionRepository {
  final subscriptions = <String, SubscriptionEntity>{};

  @override
  SubscriptionEntity? getForBusiness(String businessId) => subscriptions[businessId];

  @override
  int upsert(SubscriptionEntity subscription) {
    subscriptions[subscription.businessId] = subscription;
    return 1;
  }
}

void main() {
  group('ClaimFoundingMemberSpot', () {
    test('grants a spot and upgrades the subscription to Pro for 6 months', () {
      final foundingRepo = _FakeFoundingMemberRepository();
      final subscriptionRepo = _FakeSubscriptionRepository();
      final now = DateTime(2026, 1, 1);

      final spot = ClaimFoundingMemberSpot.call(
        foundingRepo: foundingRepo,
        subscriptionRepo: subscriptionRepo,
        businessId: 'b1',
        now: now,
      );

      expect(spot, isNotNull);
      expect(spot!.spotNumber, 1);
      expect(foundingRepo.counter.claimedCount, 1);
      expect(subscriptionRepo.subscriptions['b1']!.tier, SubscriptionTier.pro);
    });

    test('returns the existing spot on a second claim without double-counting', () {
      final foundingRepo = _FakeFoundingMemberRepository();
      final subscriptionRepo = _FakeSubscriptionRepository();
      final now = DateTime(2026, 1, 1);

      final first = ClaimFoundingMemberSpot.call(
          foundingRepo: foundingRepo, subscriptionRepo: subscriptionRepo, businessId: 'b1', now: now);
      final second = ClaimFoundingMemberSpot.call(
          foundingRepo: foundingRepo, subscriptionRepo: subscriptionRepo, businessId: 'b1', now: now);

      expect(second!.spotNumber, first!.spotNumber);
      expect(foundingRepo.counter.claimedCount, 1);
    });

    test('stores acquisition source/campaign when provided (Issue #192)', () {
      final foundingRepo = _FakeFoundingMemberRepository();
      final subscriptionRepo = _FakeSubscriptionRepository();

      final spot = ClaimFoundingMemberSpot.call(
        foundingRepo: foundingRepo,
        subscriptionRepo: subscriptionRepo,
        businessId: 'b1',
        now: DateTime(2026, 1, 1),
        acquisitionSource: 'linkedin',
        acquisitionCampaign: 'bc_outreach',
      );

      expect(spot!.acquisitionSource, 'linkedin');
      expect(spot.acquisitionCampaign, 'bc_outreach');
    });

    test('acquisition source/campaign are optional (organic signup)', () {
      final foundingRepo = _FakeFoundingMemberRepository();
      final subscriptionRepo = _FakeSubscriptionRepository();

      final spot = ClaimFoundingMemberSpot.call(
        foundingRepo: foundingRepo,
        subscriptionRepo: subscriptionRepo,
        businessId: 'b1',
        now: DateTime(2026, 1, 1),
      );

      expect(spot!.acquisitionSource, isNull);
      expect(spot.acquisitionCampaign, isNull);
    });

    test('returns null once the program is full (Issue #191 AC: 101st user)', () {
      final foundingRepo = _FakeFoundingMemberRepository()..counter = FoundingMemberCounterEntity(claimedCount: 100, capacity: 100);
      final subscriptionRepo = _FakeSubscriptionRepository();

      final spot = ClaimFoundingMemberSpot.call(
        foundingRepo: foundingRepo,
        subscriptionRepo: subscriptionRepo,
        businessId: 'b101',
        now: DateTime(2026, 1, 1),
      );

      expect(spot, isNull);
      expect(subscriptionRepo.subscriptions.containsKey('b101'), isFalse);
    });
  });
}
