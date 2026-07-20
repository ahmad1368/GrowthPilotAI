import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/inbox_category.dart';

/// The Inbox "Filter Bar" (Issue #77): All/Financial/Pending/Support tabs.
/// The Pending chip shows a small badge with [pendingCount] when non-zero,
/// per the issue's "Dynamic Badges" requirement.
class InboxFilterChips extends StatelessWidget {
  final InboxCategory selected;
  final int pendingCount;
  final ValueChanged<InboxCategory> onChanged;

  const InboxFilterChips({
    super.key,
    required this.selected,
    required this.pendingCount,
    required this.onChanged,
  });

  String _label(InboxCategory category) {
    switch (category) {
      case InboxCategory.all:
        return 'All';
      case InboxCategory.financial:
        return 'Financial';
      case InboxCategory.pending:
        return pendingCount > 0 ? 'Pending ($pendingCount)' : 'Pending';
      case InboxCategory.support:
        return 'Support';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final category in InboxCategory.values)
          ChoiceChip(
            label: Text(_label(category)),
            selected: selected == category,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(category);
            },
          ),
      ],
    );
  }
}
