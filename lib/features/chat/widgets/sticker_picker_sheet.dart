import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/chat_sticker.dart';

/// "Custom Stickers and Vector Emojis" (Issue #317 feature #23) picker
/// — a grid of native emoji glyphs; tapping one sends it as a normal
/// chat message, rendered larger by [ChatMessageBubble].
void showStickerPickerSheet(BuildContext context, {required void Function(String) onSelect}) {
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ChatSticker.values.map((sticker) {
            return GestureDetector(
              onTap: () {
                Navigator.of(sheetContext).pop();
                onSelect(sticker.emoji);
              },
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(sticker.emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 4),
                Text(sticker.label, style: const TextStyle(fontSize: 10)),
              ]),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
