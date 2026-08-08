import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/fuzzy_match_listing.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

CatalogListingEntity _listing({String title = '', String category = '', String tags = ''}) =>
    CatalogListingEntity(
      ownerId: 'owner',
      title: title,
      industry: 'test',
      category: category,
      tagsCsv: tags,
      createdAt: DateTime(2026),
    );

void main() {
  test('empty search term matches everything', () {
    expect(FuzzyMatchListing.call(_listing(title: 'Anything'), ''), 1.0);
  });

  test('handles spacing typos like "Nest JS" vs "NestJS"', () {
    final score = FuzzyMatchListing.call(_listing(tags: 'NestJS,backend'), 'Nest JS');
    expect(score, 1.0);
  });

  test('exact substring match scores 1.0', () {
    expect(FuzzyMatchListing.call(_listing(title: 'Surrey Bakery'), 'Surrey'), 1.0);
  });

  test('unrelated term scores low', () {
    final score = FuzzyMatchListing.call(_listing(title: 'Surrey Bakery'), 'zzzxyq');
    expect(score, lessThan(0.3));
  });
}
