import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/search_catalog_listings.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_facets.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_row.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_search_input.dart';

/// Renders the search box, facet counts, and ranked results (Issue
/// #121). Purely presentational.
class DiscoveryView extends StatelessWidget {
  final List<ScoredListing> results;
  final Map<String, int> facets;
  final void Function(String) onSearchChanged;

  const DiscoveryView({
    super.key,
    required this.results,
    required this.facets,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DiscoverySearchInput(onChanged: onSearchChanged),
      DiscoveryFacets(facets: facets),
      if (results.isEmpty)
        const Text('No matching businesses.', style: TextStyle(fontSize: 12))
      else
        for (final result in results) DiscoveryRow(result: result),
    ]);
  }
}
