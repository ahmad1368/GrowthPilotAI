import 'package:objectbox/objectbox.dart';

/// One cross-language chat message (Issue #430) — stores both the
/// original text and the on-device translation so either can be
/// shown depending on the "view original" toggle (acceptance
/// criterion 4).
@Entity()
class ChatMessageEntity {
  @Id()
  int id = 0;

  String senderName;
  String originalText;
  String originalLanguageCode;
  String translatedText;
  String translatedLanguageCode;
  double translationConfidence;

  @Index()
  @Property(type: PropertyType.date)
  DateTime sentAt;

  ChatMessageEntity({
    this.id = 0,
    required this.senderName,
    required this.originalText,
    required this.originalLanguageCode,
    required this.translatedText,
    required this.translatedLanguageCode,
    required this.translationConfidence,
    required this.sentAt,
  });
}
