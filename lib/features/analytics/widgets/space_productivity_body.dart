import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_space_productivity.dart';
import 'package:growth_pilot_ai/core/data/entities/store_profile_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/store_profile_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/store_square_footage_dialog.dart';

/// Owns the store-profile square footage state (Issue #398), refreshing it
/// locally after each edit. Rendering itself is [SpaceProductivityView]'s
/// job.
class SpaceProductivityBody extends StatefulWidget {
  final List<TransactionEntity> transactions;
  final StoreProfileEntity initialProfile;

  const SpaceProductivityBody(
      {super.key, required this.transactions, required this.initialProfile});

  @override
  State<SpaceProductivityBody> createState() => _SpaceProductivityBodyState();
}

class _SpaceProductivityBodyState extends State<SpaceProductivityBody> {
  late StoreProfileEntity _profile = widget.initialProfile;

  Future<void> _editSquareFootage() async {
    final value = await showStoreSquareFootageDialog(context, _profile.squareFootage);
    if (value == null) return;
    final updated = StoreProfileEntity(id: _profile.id, squareFootage: value);
    StoreProfileRepository(Get.find<ObjectBox>().store.box<StoreProfileEntity>())
        .save(updated);
    setState(() => _profile = updated);
  }

  @override
  Widget build(BuildContext context) => SpaceProductivityView(
        result: ComputeSpaceProductivity.call(widget.transactions, _profile.squareFootage),
        onEditSquareFootage: _editSquareFootage,
      );
}
