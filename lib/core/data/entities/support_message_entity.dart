import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/support_message_sender.dart';

/// One message in the local mock support chat (Issue #193) — the
/// on-device stand-in for an Intercom/Zendesk conversation thread (no
/// third-party SDK/account exists in this repo; see PR notes).
@Entity()
class SupportMessageEntity {
  @Id()
  int id = 0;

  String businessId;
  int dbSender; // SupportMessageSender index
  String body;

  @Property(type: PropertyType.date)
  @Index()
  DateTime sentAt;

  bool isRead;

  SupportMessageEntity({
    this.id = 0,
    required this.businessId,
    this.dbSender = 0,
    required this.body,
    required this.sentAt,
    this.isRead = false,
  });

  SupportMessageSender get sender => SupportMessageSender.values[dbSender];
  set sender(SupportMessageSender value) => dbSender = value.index;
}
