import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_form_draft_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_fields.dart';

void main() {
  test('loadFromDraft populates all fields including parsed image ids', () {
    final fields = ProductFormFields();
    final draft = ProductFormDraftEntity(
      editingListingId: 7,
      title: 'Widget',
      industry: 'Manufacturing',
      category: 'Tools',
      dbListingType: CatalogListingType.service.index,
      price: 42.5,
      imageVariantIdsCsv: '1,2,3',
      updatedAt: DateTime(2026),
    );
    fields.loadFromDraft(draft);
    expect(fields.editingListingId, 7);
    expect(fields.title.text, 'Widget');
    expect(fields.type, CatalogListingType.service);
    expect(fields.price.text, '42.5');
    expect(fields.imageIds, [1, 2, 3]);
  });

  test('loadFromListing populates fields from a saved listing', () {
    final fields = ProductFormFields();
    final listing = CatalogListingEntity(
      id: 9,
      ownerId: 'you',
      title: 'Chair',
      industry: 'Furniture',
      category: 'Seating',
      imageVariantIdsCsv: '5',
      createdAt: DateTime(2026),
    );
    fields.loadFromListing(listing);
    expect(fields.editingListingId, 9);
    expect(fields.title.text, 'Chair');
    expect(fields.imageIds, [5]);
  });

  test('reset clears every field back to defaults', () {
    final fields = ProductFormFields()
      ..editingListingId = 3
      ..imageIds = [1];
    fields.title.text = 'x';
    fields.reset();
    expect(fields.editingListingId, 0);
    expect(fields.title.text, '');
    expect(fields.imageIds, isEmpty);
  });
}
