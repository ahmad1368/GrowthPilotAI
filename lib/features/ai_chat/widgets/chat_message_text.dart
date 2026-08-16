import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/parse_bold_spans.dart';

/// Renders `**bold**` spans and table-looking lines (starting with `|`)
/// in monospace (Issue #200's "Markdown Support" AC) — a lightweight
/// renderer, not full CommonMark (see PR notes).
class ChatMessageText extends StatelessWidget {
  final String text;
  final Color color;
  const ChatMessageText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text.split('\n').map((line) {
        if (line.trim().startsWith('|')) {
          return Text(line, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12));
        }
        return Text.rich(TextSpan(
          children: ParseBoldSpans.call(line)
              .map((s) => TextSpan(
                  text: s.text,
                  style: TextStyle(color: color, fontWeight: s.isBold ? FontWeight.bold : FontWeight.normal)))
              .toList(),
        ));
      }).toList(),
    );
  }
}
