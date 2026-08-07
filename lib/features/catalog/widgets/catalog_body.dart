import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/models/catalog_listing_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_actions.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_view.dart';

/// Owns catalog listing state (Issue #138) — a self-contained demo of
/// the Product/Service entity model; the marketplace search/discovery
/// UI that would consume it is a separate, unbuilt issue (#121).
class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});
  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  // Demo listings anchor near Coquitlam so the acceptance criteria's
  // "50km of Surrey/Coquitlam" scenario has something to match.
  static const _demoLat = 49.2838, _demoLng = -122.7932;

  final _repos = CatalogRepos();
  late final _actions = CatalogActions(_repos);
  late List<CatalogListingSummary> _summaries = _actions.loadSummaries();
  List<String> _errors = [];

  void _create({
    required String title,
    required String industry,
    required String category,
    required CatalogListingType type,
    required double price,
  }) {
    final errors = _actions.createListing(
      ownerId: 'You',
      title: title,
      industry: industry,
      category: category,
      type: type,
      fixedPrice: price,
      lat: _demoLat,
      lng: _demoLng,
    );
    setState(() {
      _errors = errors;
      if (errors.isEmpty) _summaries = _actions.loadSummaries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CatalogView(summaries: _summaries, errors: _errors, onCreate: _create);
  }
}
