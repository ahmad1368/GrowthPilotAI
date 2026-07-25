import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/waste_log_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_entry_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_summary_view.dart';

/// Owns the waste-log entry list (Issue #377), refreshing it locally after
/// each quick-add insert. Rendering itself is [WasteSummaryView]'s job.
class WasteLogBody extends StatefulWidget {
  final List<WasteLogEntity> initialEntries;

  const WasteLogBody({super.key, required this.initialEntries});

  @override
  State<WasteLogBody> createState() => _WasteLogBodyState();
}

class _WasteLogBodyState extends State<WasteLogBody> {
  late List<WasteLogEntity> _entries = widget.initialEntries;

  Future<void> _addEntry() async {
    final entry = await showWasteEntryDialog(context);
    if (entry == null) return;
    WasteLogRepository(Get.find<ObjectBox>().store.box<WasteLogEntity>()).insert(entry);
    setState(() => _entries = [..._entries, entry]);
  }

  @override
  Widget build(BuildContext context) =>
      WasteSummaryView(entries: _entries, onAddEntry: _addEntry);
}
