import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// "Structured Reporting Flow" reason step (Issue #134 AC: Spam/Fraud/
/// Harassment categories).
void showChatReportReasonPicker(BuildContext context, void Function(ModerationReason) onSelect) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final reason in ModerationReason.values)
          ListTile(
            title: Text(reason.name),
            onTap: () {
              Navigator.pop(context);
              onSelect(reason);
            },
          ),
      ]),
    ),
  );
}
