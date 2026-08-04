import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/grant_rewarded_unlock.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Value-exchange consent form for [showRewardedUnlockDialog] (Issue
/// #405): the terms are shown before "Watch Now" simulates ad
/// completion — this app has no ad-network SDK to play a real video.
class RewardedUnlockDialogContent extends StatefulWidget {
  const RewardedUnlockDialogContent({super.key});

  @override
  State<RewardedUnlockDialogContent> createState() =>
      _RewardedUnlockDialogContentState();
}

class _RewardedUnlockDialogContentState
    extends State<RewardedUnlockDialogContent> {
  final _moduleNameController = TextEditingController();
  final _merchantNameController = TextEditingController();
  int _durationMinutes = 15;

  void _watchNow() {
    if (_moduleNameController.text.trim().isEmpty ||
        _merchantNameController.text.trim().isEmpty) {
      return;
    }
    Navigator.of(context).pop(GrantRewardedUnlock.call(
      moduleName: _moduleNameController.text.trim(),
      merchantName: _merchantNameController.text.trim(),
      duration: Duration(minutes: _durationMinutes),
      now: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Unlock with a Rewarded Promo'),
      description: RewardedUnlockFields(
        moduleNameController: _moduleNameController,
        merchantNameController: _merchantNameController,
        selectedDurationMinutes: _durationMinutes,
        onDurationChanged: (m) => setState(() => _durationMinutes = m),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _watchNow, child: const Text('Watch Now')),
      ],
    );
  }
}
