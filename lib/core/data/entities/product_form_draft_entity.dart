import 'package:objectbox/objectbox.dart';

/// The single in-progress "Add/Edit Product" form draft (Issue #140,
/// acceptance criterion "Resume capability") — one row, upserted in
/// place, so closing the app mid-entry doesn't lose typed fields.
/// This app has no SQLCipher; ObjectBox already has no at-rest
/// encryption (disclosed honestly elsewhere in the dashboard).
@Entity()
class ProductFormDraftEntity {
  @Id()
  int id = 0;

  int editingListingId;
  String title, industry, category;
  int dbListingType;
  double price;
  String imageVariantIdsCsv;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  ProductFormDraftEntity({
    this.id = 0,
    this.editingListingId = 0,
    this.title = '',
    this.industry = '',
    this.category = '',
    this.dbListingType = 0,
    this.price = 0,
    this.imageVariantIdsCsv = '',
    required this.updatedAt,
  });
}
