import 'package:objectbox/objectbox.dart';

/// A requirement pinned into the traceability graph (Issue #238's
/// `requirements` table) — this repo's Issue #228-#232 extraction
/// pipeline keeps `ExtractedRequirement`s in-memory only (no entity of
/// its own yet; see PR notes), so linking a requirement to a goal/test
/// case here snapshots its [description] text into its own row instead
/// of a live foreign key.
@Entity()
class TraceableRequirementEntity {
  @Id()
  int id = 0;

  String description;

  TraceableRequirementEntity({this.id = 0, required this.description});
}
