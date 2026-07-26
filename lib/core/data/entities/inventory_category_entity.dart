import 'package:objectbox/objectbox.dart';

/// A hierarchical inventory category (Issue #436): parent/child structure
/// so merchants can organize items (e.g. "Bakery > Bread > Sourdough").
@Entity()
class InventoryCategoryEntity {
  @Id()
  int id = 0;

  String name;

  final parent = ToOne<InventoryCategoryEntity>();

  InventoryCategoryEntity({this.id = 0, required this.name});
}
