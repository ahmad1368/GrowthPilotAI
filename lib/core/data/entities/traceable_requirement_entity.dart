import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';

/// A requirement pinned into the traceability graph (Issue #238's
/// `requirements` table, extended by #242 with [reqCode]/[devStatus]
/// and #239 with [moscowPriority]) — this repo's Issue #228-#232
/// extraction pipeline keeps `ExtractedRequirement`s in-memory only (no
/// entity of its own yet; see PR notes), so linking a requirement to a
/// goal/test case here snapshots its [description] text into its own
/// row instead of a live foreign key. [sourceStartIndex]/
/// [sourceEndIndex] carry over Issue #228's document offsets when the
/// link came from the Triage screen (Issue #242's "link `req_code`
/// back to `start_index`").
@Entity()
class TraceableRequirementEntity {
  @Id()
  int id = 0;

  String reqCode;
  String description;
  int dbDevStatus; // RequirementDevStatus index

  int? sourceStartIndex;
  int? sourceEndIndex;

  /// Snapshotted from Issue #229's MoSCoW override at link time; null
  /// when linked as free-typed text (no priority to snapshot).
  int? dbMoscowPriority;

  TraceableRequirementEntity({
    this.id = 0,
    required this.reqCode,
    required this.description,
    this.dbDevStatus = 0,
    this.sourceStartIndex,
    this.sourceEndIndex,
    this.dbMoscowPriority,
  });

  RequirementDevStatus get devStatus => RequirementDevStatus.values[dbDevStatus];
  set devStatus(RequirementDevStatus value) => dbDevStatus = value.index;

  RequirementMoscowPriority? get moscowPriority =>
      dbMoscowPriority == null ? null : RequirementMoscowPriority.values[dbMoscowPriority!];
  set moscowPriority(RequirementMoscowPriority? value) => dbMoscowPriority = value?.index;
}
