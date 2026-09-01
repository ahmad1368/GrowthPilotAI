import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_history_entity.dart';

/// "History Timeline: full change history of a requirement, similar
/// to Jira's Activity panel" (Issue #238).
class RequirementHistoryTimeline extends StatelessWidget {
  final List<RequirementHistoryEntity> entries;

  const RequirementHistoryTimeline({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Requirement history'),
      content: SizedBox(
        width: double.maxFinite,
        child: entries.isEmpty
            ? const Text('No history yet.')
            : ListView(
                shrinkWrap: true,
                children: [for (final entry in entries) _entryTile(entry)],
              ),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
    );
  }

  Widget _entryTile(RequirementHistoryEntity entry) {
    return ListTile(
      title: Text('${entry.changeType.name} · ${entry.reasonForChange}'),
      subtitle: Text('${entry.changedBy} — ${entry.changedAt}\n${entry.newValue ?? ''}'),
      isThreeLine: true,
    );
  }
}
