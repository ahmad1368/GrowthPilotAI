import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Bulk-action toolbar shown when rows are selected (Issue #143,
/// "Bulk Actions").
class AdminTableBulkBar extends StatefulWidget {
  final int selectedCount;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;
  final void Function(String category) onChangeCategory;

  const AdminTableBulkBar({
    super.key,
    required this.selectedCount,
    required this.onDeactivate,
    required this.onDelete,
    required this.onChangeCategory,
  });

  @override
  State<AdminTableBulkBar> createState() => _AdminTableBulkBarState();
}

class _AdminTableBulkBarState extends State<AdminTableBulkBar> {
  final _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.selectedCount == 0) return const SizedBox.shrink();
    return Row(children: [
      Text('${widget.selectedCount} selected', style: const TextStyle(fontSize: 12)),
      ShadButton.ghost(onPressed: widget.onDeactivate, child: const Text('Deactivate')),
      ShadButton.ghost(onPressed: widget.onDelete, child: const Text('Delete')),
      SizedBox(width: 100, child: TextField(controller: _category, style: const TextStyle(fontSize: 12))),
      ShadButton.ghost(
          onPressed: () => widget.onChangeCategory(_category.text), child: const Text('Set Category')),
    ]);
  }
}
