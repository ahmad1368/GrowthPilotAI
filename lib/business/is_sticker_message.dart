import 'package:growth_pilot_ai/core/enum/chat_sticker.dart';

/// Whether a message body is exactly one catalog sticker glyph (Issue
/// #317 feature #23) — used to render it larger/bare in the bubble,
/// matching how mainstream chat apps display single-emoji "stickers".
class IsStickerMessage {
  static bool call(String body) => ChatSticker.values.any((s) => s.emoji == body);
}
