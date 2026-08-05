import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_telemetry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_view.dart';

/// Owns the constraint dashboard's snapshots, auto-enforcing on every refresh (Issue #409).
class AdConstraintBody extends StatefulWidget {
  final List<AdvertisingRequestEntity> requests;

  const AdConstraintBody({super.key, required this.requests});

  @override
  State<AdConstraintBody> createState() => _AdConstraintBodyState();
}

class _AdConstraintBodyState extends State<AdConstraintBody> {
  final _repos = AdConstraintRepos();
  late final _actions = AdConstraintActions(_repos);
  late final _telemetry = AdConstraintTelemetry(_repos);
  late List<CampaignConstraintSnapshot> _snapshots =
      _actions.buildAndEnforceSnapshots(widget.requests);
  void _act(void Function() action) {
    action();
    setState(() => _snapshots = _actions.buildAndEnforceSnapshots(widget.requests));
  }

  Future<void> _configure() async {
    final unconstrained = _actions.unconstrainedRequests(widget.requests, _snapshots);
    final picked = await showAdConstraintDialog(context, unconstrained);
    if (picked == null) return;
    _act(() => _actions.configure(picked.requestId, picked.days, picked.impressions, picked.clicks));
  }

  void _simulateImpression(int id) => _act(() => _telemetry.simulateImpression(id));
  void _simulateClick(int id) => _act(() => _telemetry.simulateClick(id));

  @override
  Widget build(BuildContext context) {
    return AdConstraintView(
      snapshots: _snapshots,
      onConfigure: _configure,
      onSimulateImpression: _simulateImpression,
      onSimulateClick: _simulateClick,
    );
  }
}
