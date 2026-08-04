import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/rewarded_unlock_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_view.dart';

/// Owns the rewarded unlock log (Issue #405), recording each granted
/// unlock immediately.
class RewardedUnlockBody extends StatefulWidget {
  final List<RewardedUnlockEntity> initialUnlocks;

  const RewardedUnlockBody({super.key, required this.initialUnlocks});

  @override
  State<RewardedUnlockBody> createState() => _RewardedUnlockBodyState();
}

class _RewardedUnlockBodyState extends State<RewardedUnlockBody> {
  late List<RewardedUnlockEntity> _unlocks = widget.initialUnlocks;

  Future<void> _trigger() async {
    final unlock = await showRewardedUnlockDialog(context);
    if (unlock == null) return;
    RewardedUnlockRepository(
            Get.find<ObjectBox>().store.box<RewardedUnlockEntity>())
        .record(unlock);
    setState(() => _unlocks = [..._unlocks, unlock]);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return RewardedUnlockView(
      unlocks: _unlocks,
      isActive: (u) => now.isBefore(u.expiresAt),
      onTrigger: _trigger,
    );
  }
}
