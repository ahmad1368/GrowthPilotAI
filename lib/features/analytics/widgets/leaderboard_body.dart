import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_leaderboard.dart';
import 'package:growth_pilot_ai/business/verify_sponsored_placement.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/leaderboard_view.dart';

/// Owns the leaderboard's filter query and sponsored-placement
/// verification action (Issue #408); the ranking itself is derived
/// from the merchant directory and approved ad requests.
class LeaderboardBody extends StatefulWidget {
  final List<MerchantConfigEntity> configs;
  final List<AdvertisingRequestEntity> requests;

  const LeaderboardBody({super.key, required this.configs, required this.requests});

  @override
  State<LeaderboardBody> createState() => _LeaderboardBodyState();
}

class _LeaderboardBodyState extends State<LeaderboardBody> {
  String _query = '';
  final _verified = <int>{};

  void _verify(LeaderboardEntry entry) {
    final result = VerifySponsoredPlacement.call(entry, widget.requests);
    AuditLogRepository(Get.find<ObjectBox>().store.box<AuditLogEntity>())
        .record(result.log);
    setState(() => _verified.add(entry.rank));
  }

  @override
  Widget build(BuildContext context) {
    final entries = BuildLeaderboard.call(widget.configs, widget.requests)
        .where((e) => e.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return LeaderboardView(
      entries: entries,
      verifiedRanks: _verified,
      onQueryChanged: (q) => setState(() => _query = q),
      onVerify: _verify,
    );
  }
}
