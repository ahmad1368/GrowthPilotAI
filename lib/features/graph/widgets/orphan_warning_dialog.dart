import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Consistency Middleware: warns the user when deleting a goal that
/// would leave orphan requirements" (Issue #238) — returns `true` (via
/// [Navigator.pop]) if the user confirms the deletion anyway.
class OrphanWarningDialog extends StatelessWidget {
  final List<TraceableRequirementEntity> orphaned;

  const OrphanWarningDialog({super.key, required this.orphaned});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('This will orphan requirements'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text('These requirements have no other linked goal:'),
            for (final r in orphaned) ListTile(title: Text(r.description)),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        ShadButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete anyway'),
        ),
      ],
    );
  }
}
