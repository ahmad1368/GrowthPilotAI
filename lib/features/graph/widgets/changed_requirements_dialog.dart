import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Interactive Tooltips: long-press on the 'Volatility' chart, show a
/// pop-up list of the specific requirements that changed" (Issue #236)
/// — lists every requirement moved off `pending`. No per-edit
/// timestamp history is persisted here, so this can't sort by "most
/// recently changed" (see PR notes).
class ChangedRequirementsDialog extends StatelessWidget {
  final List<ExtractedRequirement> requirements;

  const ChangedRequirementsDialog({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    final changed =
        requirements.where((r) => r.status != RequirementTriageStatus.pending).toList();
    return AlertDialog(
      title: const Text('Changed requirements'),
      content: SizedBox(
        width: double.maxFinite,
        child: changed.isEmpty
            ? const Text('No requirements have been touched yet.')
            : ListView(
                shrinkWrap: true,
                children: [
                  for (final r in changed) ListTile(title: Text(r.description), subtitle: Text(r.status.name)),
                ],
              ),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
    );
  }
}
