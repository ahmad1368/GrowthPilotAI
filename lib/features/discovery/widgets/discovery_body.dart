import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/search_catalog_listings.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_actions.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_repos.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_view.dart';

/// Owns the business discovery search state (Issue #121) — a local
/// stand-in for the NestJS/MongoDB Atlas Search engine the issue
/// describes, since this app has no server or search cluster.
class DiscoveryBody extends StatefulWidget {
  const DiscoveryBody({super.key});
  @override
  State<DiscoveryBody> createState() => _DiscoveryBodyState();
}

class _DiscoveryBodyState extends State<DiscoveryBody> {
  final _actions = DiscoveryActions(DiscoveryRepos());
  late List<ScoredListing> _results = _actions.search('');

  void _onSearchChanged(String term) {
    setState(() => _results = _actions.search(term));
  }

  @override
  Widget build(BuildContext context) {
    return DiscoveryView(
      results: _results,
      facets: _actions.facets(),
      onSearchChanged: _onSearchChanged,
    );
  }
}
