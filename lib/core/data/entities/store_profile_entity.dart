import 'package:objectbox/objectbox.dart';

/// Single-row store profile (Issue #398) holding the physical floor space
/// size needed for revenue-per-square-foot productivity metrics — no such
/// setting exists elsewhere in this app.
@Entity()
class StoreProfileEntity {
  @Id()
  int id = 0;

  double squareFootage;

  StoreProfileEntity({this.id = 0, this.squareFootage = 0});
}
