import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_view_state.dart';

/// Owns settlement tracking dashboard state (Issue #426) — this app
/// has no live event stream, so a manual refresh stands in for the
/// "real-time" push the issue's architecture describes, the same
/// simplification every other simulated-backend feature here takes.
class SettlementTrackingBody extends StatefulWidget {
  const SettlementTrackingBody({super.key});
  @override
  State<SettlementTrackingBody> createState() => _SettlementTrackingBodyState();
}

class _SettlementTrackingBodyState extends State<SettlementTrackingBody> {
  final _repos = SettlementTrackingRepos();
  late SettlementTrackingViewState _state = SettlementTrackingViewState.load(_repos);

  void _refresh() => setState(() => _state = SettlementTrackingViewState.load(_repos));

  @override
  Widget build(BuildContext context) {
    return SettlementTrackingView(state: _state, onRefresh: _refresh);
  }
}
