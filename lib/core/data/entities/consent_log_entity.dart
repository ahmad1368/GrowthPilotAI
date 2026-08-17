import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/consent_action.dart';

/// One append-only "non-repudiable" consent record (Issue #215's
/// `ConsentLogs` collection) — [ConsentLogRepository] exposes no
/// update/delete, so nothing in this app's own code path can mutate a
/// row once written (AC: "Create-Only"). [platform] replaces the
/// issue's IP-address/User-Agent fields: this app has no server to
/// observe a request's IP, so the honest local equivalent is which
/// client platform recorded the action.
@Entity()
class ConsentLogEntity {
  @Id()
  int id = 0;

  int dbAction; // ConsentAction index
  String version;

  @Property(type: PropertyType.date)
  DateTime occurredAt;

  String platform;

  ConsentLogEntity({
    this.id = 0,
    required this.dbAction,
    required this.version,
    required this.occurredAt,
    required this.platform,
  });

  ConsentAction get action => ConsentAction.values[dbAction];
}
