import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// "What-if" window toggles (e.g. Next 3 vs Next 7 days). Selecting a chip
/// fires light haptic feedback. Web-safe: HapticFeedback is a no-op there.
class WindowSelectorChips extends StatelessWidget {
  final int selected;
  final List<int> options;
  final ValueChanged<int> onChanged;

  const WindowSelectorChips({
    super.key,
    required this.selected,
    required this.onChanged,
    this.options = const [3, 7],
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final d in options)
          ChoiceChip(
            label: Text('Next $d days'),
            selected: selected == d,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(d);
            },
          ),
      ],
    );
  }
}
