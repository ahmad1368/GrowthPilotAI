import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_catalog_grid_cards.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_grid_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_grid_view.dart';

/// Owns the Product Catalog grid demo's state (Issue #142) — a flat
/// [ShadCard] grid, not the issue's literal Glassmorphism ask (this
/// project's architecture explicitly forbids Glassmorphism/
/// BackdropFilter).
class CatalogGridBody extends StatefulWidget {
  const CatalogGridBody({super.key});
  @override
  State<CatalogGridBody> createState() => _CatalogGridBodyState();
}

class _CatalogGridBodyState extends State<CatalogGridBody> {
  final _repos = CatalogGridRepos();
  late final _cards = buildCatalogGridCards(_repos);

  @override
  Widget build(BuildContext context) => CatalogGridView(cards: _cards);
}
