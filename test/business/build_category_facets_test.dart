import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_category_facets.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

CatalogListingEntity _listing(String category) => CatalogListingEntity(
      ownerId: 'owner',
      title: 't',
      industry: 'test',
      category: category,
      createdAt: DateTime(2026),
    );

void main() {
  test('counts listings per category', () {
    final facets = BuildCategoryFacets.call([_listing('Bakery'), _listing('Bakery'), _listing('Cafe')]);
    expect(facets, {'Bakery': 2, 'Cafe': 1});
  });

  test('groups empty categories under Uncategorized', () {
    final facets = BuildCategoryFacets.call([_listing('')]);
    expect(facets, {'Uncategorized': 1});
  });
}
