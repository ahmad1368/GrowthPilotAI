import 'package:objectbox/objectbox.dart';

/// One persisted [OmniLogger] call (Issue #266 "Offline Logging" —
/// local-first stand-in for a cloud log stream, since no Sentry/
/// Crashlytics/Logtail account exists in this repo). [dbLevel] stores
/// [OmniLogLevel.index] since ObjectBox doesn't box Dart enums directly.
@Entity()
class OmniLogEntryEntity {
  @Id()
  int id = 0;

  int dbLevel;
  String title;
  String message;
  String? stackTraceText;

  // Issue #165: a real, queryable tag instead of the free-text "User: X"
  // string this used to only appear inside [message] as.
  @Index()
  String userId;

  @Index()
  @Property(type: PropertyType.date)
  DateTime occurredAt;

  OmniLogEntryEntity({
    this.id = 0,
    required this.dbLevel,
    required this.title,
    required this.message,
    this.stackTraceText,
    this.userId = 'local-user',
    required this.occurredAt,
  });
}
