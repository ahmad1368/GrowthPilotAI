import 'package:flutter/material.dart';

/// Aggregated category counts for faceted navigation (Issue #121,
/// referencing the side-panel filters in #115).
class DiscoveryFacets extends StatelessWidget {
  final Map<String, int> facets;
  const DiscoveryFacets({super.key, required this.facets});

  @override
  Widget build(BuildContext context) {
    if (facets.isEmpty) return const SizedBox.shrink();
    final label = facets.entries.map((e) => '${e.key} (${e.value})').join(', ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text('Categories: $label', style: const TextStyle(fontSize: 11)),
    );
  }
}
