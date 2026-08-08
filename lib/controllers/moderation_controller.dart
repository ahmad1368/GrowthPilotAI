import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/is_profile_suspended.dart';
import 'package:growth_pilot_ai/business/is_user_blocked.dart';
import 'package:growth_pilot_ai/business/register_strike.dart';
import 'package:growth_pilot_ai/business/submit_abuse_report.dart';
import 'package:growth_pilot_ai/core/data/entities/block_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/abuse_report_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/block_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/strike_repository.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// Block/Report/Strike moderation subsystem (Issue #124/#134) — a single
/// controller since both issues describe the same dual-layer engine.
class ModerationController extends GetxController {
  late BlockRepository _blocks;
  late StrikeRepository _strikes;
  late AbuseReportRepository _reports;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _blocks = BlockRepository(store.box());
    _strikes = StrikeRepository(store.box());
    _reports = AbuseReportRepository(store.box());
  }

  bool isBlocked(String userA, String userB) =>
      IsUserBlocked.call(_blocks.getAll(), userA, userB);

  void blockUser(String blockerId, String blockedId) {
    if (isBlocked(blockerId, blockedId)) return;
    _blocks.insert(BlockEntity(blockerId: blockerId, blockedId: blockedId, createdAt: DateTime.now()));
  }

  void unblockUser(String blockerId, String blockedId) => _blocks.remove(blockerId, blockedId);

  bool isSuspended(String userId) =>
      IsProfileSuspended.call(_strikes.getAll(), userId, DateTime.now());

  /// Every submitted report immediately registers a strike (Issue #124:
  /// "a backend-driven Reputation Score that tracks reported violations").
  void submitReport(String reporterId, String targetId, ModerationReason reason,
      List<ChatRoomMessageEntity> evidence) {
    final now = DateTime.now();
    _reports.insert(SubmitAbuseReport.call(
        reporterId: reporterId, targetId: targetId, reason: reason, evidenceMessages: evidence, now: now));
    _strikes.insert(RegisterStrike.call(targetId: targetId, reason: reason, now: now));
  }
}
