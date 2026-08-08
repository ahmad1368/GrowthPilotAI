import 'package:growth_pilot_ai/business/build_evidence_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/abuse_report_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// Builds a "Report User/Business" submission (Issue #134) with an
/// attached evidence snapshot of the reported conversation.
class SubmitAbuseReport {
  static AbuseReportEntity call({
    required String reporterId,
    required String targetId,
    required ModerationReason reason,
    required List<ChatRoomMessageEntity> evidenceMessages,
    required DateTime now,
  }) {
    return AbuseReportEntity(
      reporterId: reporterId,
      targetId: targetId,
      dbReason: reason.index,
      evidenceSnapshot: BuildEvidenceSnapshot.call(evidenceMessages),
      createdAt: now,
    );
  }
}
