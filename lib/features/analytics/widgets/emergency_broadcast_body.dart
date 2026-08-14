import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_broadcast_read_rates.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/emergency_broadcast_repository.dart';
import 'package:growth_pilot_ai/core/models/broadcast_read_rate.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_view.dart';

/// Owns the broadcast list (Issue #345), persisting new dispatches and
/// read-count updates immediately to local state.
class EmergencyBroadcastBody extends StatefulWidget {
  final List<EmergencyBroadcastEntity> initialBroadcasts;

  const EmergencyBroadcastBody({super.key, required this.initialBroadcasts});

  @override
  State<EmergencyBroadcastBody> createState() => _EmergencyBroadcastBodyState();
}

class _EmergencyBroadcastBodyState extends State<EmergencyBroadcastBody> {
  late List<EmergencyBroadcastEntity> _broadcasts = widget.initialBroadcasts;

  Future<void> _dispatch() async {
    final broadcast = await showEmergencyBroadcastDialog(context);
    if (broadcast == null) return;
    EmergencyBroadcastRepository(
            Get.find<ObjectBox>().store.box<EmergencyBroadcastEntity>())
        .save(broadcast);
    setState(() => _broadcasts = [..._broadcasts, broadcast]);
  }

  void _markRead(BroadcastReadRate result) {
    final repo = EmergencyBroadcastRepository(
        Get.find<ObjectBox>().store.box<EmergencyBroadcastEntity>());
    final updated = EmergencyBroadcastEntity(
      id: result.id,
      messageBody: result.messageBody,
      targetNeighborhoods: result.targetNeighborhoods,
      recipientCount: result.recipientCount,
      readCount: result.readCount + 1,
      dispatchedAt: result.dispatchedAt,
    );
    repo.save(updated);
    setState(() => _broadcasts = [
          for (final b in _broadcasts)
            if (b.id != updated.id) b,
          updated,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeBroadcastReadRates.call(_broadcasts);
    return EmergencyBroadcastView(
      results: results,
      onDispatch: _dispatch,
      onMarkRead: _markRead,
    );
  }
}
