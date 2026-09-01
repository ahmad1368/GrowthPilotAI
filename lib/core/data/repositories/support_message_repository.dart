import '../../../../objectbox.g.dart';
import '../entities/support_message_entity.dart';
import '../../enum/support_message_sender.dart';

/// ObjectBox wrapper for the local mock support chat (Issue #193).
class SupportMessageRepository {
  final Box<SupportMessageEntity> _box;

  SupportMessageRepository(this._box);

  /// Oldest first (chat order).
  List<SupportMessageEntity> getForBusiness(String businessId) =>
      _box.getAll().where((m) => m.businessId == businessId).toList()
        ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

  void append(SupportMessageEntity message) => _box.put(message);

  int unreadCount(String businessId) => getForBusiness(businessId)
      .where((m) => m.sender == SupportMessageSender.agent && !m.isRead)
      .length;

  void markAllRead(String businessId) {
    for (final message in getForBusiness(businessId).where((m) => !m.isRead)) {
      message.isRead = true;
      _box.put(message);
    }
  }
}
