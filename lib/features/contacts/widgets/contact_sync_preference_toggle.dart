import 'package:flutter/material.dart';

/// Enable/disable switch (Issue #541, acceptance criterion 5) —
/// disabling also purges the stored hashed match history, handled in
/// [ContactSyncActions.setEnabled].
class ContactSyncPreferenceToggle extends StatelessWidget {
  final bool isEnabled;
  final void Function(bool) onChanged;

  const ContactSyncPreferenceToggle({super.key, required this.isEnabled, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text('Contact syncing', style: Theme.of(context).textTheme.labelMedium)),
      Switch(value: isEnabled, onChanged: onChanged),
    ]);
  }
}
