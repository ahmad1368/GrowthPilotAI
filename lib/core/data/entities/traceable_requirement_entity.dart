import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';

/// A requirement pinned into the traceability graph (Issue #238's
/// `requirements` table, extended by #242 with [reqCode]/[devStatus])
/// — this repo's Issue #228-#232 extraction pipeline keeps
/// `ExtractedRequirement`s in-memory only (no entity of its own yet;
/// see PR notes), so linking a requirement to a goal/test case here
/// snapshots its [description] text into its own row instead of a
/// live foreign key. [sourceStartIndex]/[sourceEndIndex] carry over
/// Issue #228's document offsets when the link came from the Triage
/// screen (Issue #242's "link `req_code` back to `start_index`").
@Entity()
class TraceableRequirementEntity {
  @Id()
  int id = 0;

  String reqCode;
  String description;
  int dbDevStatus; // RequirementDevStatus index

  int? sourceStartIndex;
  int? sourceEndIndex;

  TraceableRequirementEntity({
    this.id = 0,
    required this.reqCode,
    required this.description,
    this.dbDevStatus = 0,
    this.sourceStartIndex,
    this.sourceEndIndex,
  });

  RequirementDevStatus get devStatus => RequirementDevStatus.values[dbDevStatus];
  set devStatus(RequirementDevStatus value) => dbDevStatus = value.index;
}
