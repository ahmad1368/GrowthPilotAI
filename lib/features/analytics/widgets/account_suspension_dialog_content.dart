import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showAccountSuspensionDialog] (Issue #341).
class AccountSuspensionDialogContent extends StatefulWidget {
  const AccountSuspensionDialogContent({super.key});

  @override
  State<AccountSuspensionDialogContent> createState() =>
      _AccountSuspensionDialogContentState();
}

class _AccountSuspensionDialogContentState
    extends State<AccountSuspensionDialogContent> {
  final _merchantNameController = TextEditingController();
  final _reasonController = TextEditingController();
  int _durationHours = 24;

  void _submit() {
    if (_merchantNameController.text.trim().isEmpty ||
        _reasonController.text.trim().isEmpty) {
      return;
    }
    final now = DateTime.now();
    Navigator.of(context).pop(AccountSuspensionEntity(
      merchantName: _merchantNameController.text.trim(),
      reason: _reasonController.text.trim(),
      suspendedAt: now,
      expiresAt: now.add(Duration(hours: _durationHours)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Suspend Merchant Account'),
      description: AccountSuspensionFields(
        merchantNameController: _merchantNameController,
        reasonController: _reasonController,
        selectedDurationHours: _durationHours,
        onDurationChanged: (h) => setState(() => _durationHours = h),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Suspend')),
      ],
    );
  }
}
