import 'package:flutter/material.dart';

/// The up/down icon pair for [FeedbackButtons] (Issue #209) — split out
/// to keep that widget's state logic under the file-size limit.
class ThumbVoteRow extends StatelessWidget {
  final bool? isHelpful;
  final ValueChanged<bool> onVote;
  const ThumbVoteRow({super.key, required this.isHelpful, required this.onVote});

  Widget _button(bool value, IconData filled, IconData outlined, Color color) => IconButton(
        iconSize: 16,
        visualDensity: VisualDensity.compact,
        icon: Icon(isHelpful == value ? filled : outlined, color: isHelpful == value ? color : null),
        onPressed: isHelpful == null ? () => onVote(value) : null,
      );

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      _button(true, Icons.thumb_up, Icons.thumb_up_outlined, Colors.green),
      _button(false, Icons.thumb_down, Icons.thumb_down_outlined, Colors.red),
    ]);
  }
}
