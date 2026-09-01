import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/b2b_analytics_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/b2b_analytics_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/build_b2b_analytics_summary.dart';

/// Loads procurement data and computes the B2B analytics summary
/// (Issue #129); rendering itself lives in [B2bAnalyticsView].
class B2bAnalyticsBody extends StatefulWidget {
  const B2bAnalyticsBody({super.key});

  @override
  State<B2bAnalyticsBody> createState() => _B2bAnalyticsBodyState();
}

class _B2bAnalyticsBodyState extends State<B2bAnalyticsBody> {
  final _repos = B2bAnalyticsRepos();

  @override
  Widget build(BuildContext context) {
    if (_repos.requests.getAll().isEmpty) {
      return const Text('No procurement requests yet', style: TextStyle(fontSize: 12));
    }
    return B2bAnalyticsView(summary: BuildB2bAnalyticsSummary.call(_repos));
  }
}
