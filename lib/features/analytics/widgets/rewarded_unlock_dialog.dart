import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Value-exchange rewarded promo flow (Issue #405). Returns the granted
/// unlock (not yet persisted) or null if cancelled/invalid.
Future<RewardedUnlockEntity?> showRewardedUnlockDialog(BuildContext context) {
  return showShadDialog<RewardedUnlockEntity>(
    context: context,
    builder: (context) => const RewardedUnlockDialogContent(),
  );
}
