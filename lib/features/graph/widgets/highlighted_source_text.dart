import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders [text] as selectable rich text with the `[start, end)` span
/// highlighted (Issue #231's "Smart Highlighting"), split out of
/// [SourceDocumentHighlightView] to keep it under the 50-line guideline.
class HighlightedSourceText extends StatelessWidget {
  final String text;
  final int? start;
  final int? end;

  const HighlightedSourceText({super.key, required this.text, this.start, this.end});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return SelectableText.rich(TextSpan(children: _buildSpans(colors)));
  }

  List<TextSpan> _buildSpans(ShadColorScheme colors) {
    final base = TextStyle(color: colors.foreground, fontSize: 13);
    if (start == null || end == null) return [TextSpan(text: text, style: base)];

    return [
      TextSpan(text: text.substring(0, start), style: base),
      TextSpan(
        text: text.substring(start!, end),
        style: base.copyWith(
            backgroundColor: colors.primary.withValues(alpha: 0.3), fontWeight: FontWeight.w600),
      ),
      TextSpan(text: text.substring(end!), style: base),
    ];
  }
}
