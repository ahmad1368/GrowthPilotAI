import 'package:objectbox/objectbox.dart';

/// An admin-editable enable/disable toggle for one application module
/// (Issue #339) — this app has no backend feature-flag service, so an
/// admin lists each module and its gated route locally, persisting via
/// ObjectBox `put` (insert when `id == 0`, update in place otherwise)
/// so the new state is picked up on the next navigation/re-login
/// without an app restart.
@Entity()
class FeatureModuleToggleEntity {
  @Id()
  int id = 0;

  String moduleName;

  String routeName;

  bool isEnabled;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  FeatureModuleToggleEntity({
    this.id = 0,
    required this.moduleName,
    required this.routeName,
    required this.isEnabled,
    required this.updatedAt,
  });
}
