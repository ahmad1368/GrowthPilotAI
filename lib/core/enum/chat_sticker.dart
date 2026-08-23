/// "Custom Stickers and Vector Emojis" (Issue #317 feature #23) —
/// native platform emoji glyphs used as stickers (no external art
/// asset pipeline exists in this repo; see PR notes on why animated
/// TGS stickers are out of scope). Curated for this app's buyer/
/// vendor negotiation chat context.
enum ChatSticker { deal, handshake, check, fire, clock, star, warning, question }

extension ChatStickerX on ChatSticker {
  String get emoji => switch (this) {
        ChatSticker.deal => '👍',
        ChatSticker.handshake => '🤝',
        ChatSticker.check => '✅',
        ChatSticker.fire => '🔥',
        ChatSticker.clock => '⏰',
        ChatSticker.star => '⭐',
        ChatSticker.warning => '⚠️',
        ChatSticker.question => '❓',
      };

  String get label => switch (this) {
        ChatSticker.deal => 'Deal',
        ChatSticker.handshake => 'Handshake',
        ChatSticker.check => 'Confirmed',
        ChatSticker.fire => 'Hot',
        ChatSticker.clock => 'Time-sensitive',
        ChatSticker.star => 'Favorite',
        ChatSticker.warning => 'Warning',
        ChatSticker.question => 'Question',
      };
}
