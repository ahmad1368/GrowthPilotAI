import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_bulk_bar.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_data_table.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_admin_table_rows.dart';

/// Renders the admin product table: bulk-action bar + data table
/// (Issue #143). Purely presentational.
class AdminTableView extends StatelessWidget {
  final List<AdminRow> rows;
  final Set<int> selectedIds;
  final void Function(int id, bool selected) onSelectRow;
  final void Function(int id, double price) onPriceChanged;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;
  final void Function(String category) onChangeCategory;

  const AdminTableView({
    super.key,
    required this.rows,
    required this.selectedIds,
    required this.onSelectRow,
    required this.onPriceChanged,
    required this.onDeactivate,
    required this.onDelete,
    required this.onChangeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AdminTableBulkBar(
          selectedCount: selectedIds.length,
          onDeactivate: onDeactivate,
          onDelete: onDelete,
          onChangeCategory: onChangeCategory,
        ),
        AdminTableDataTable(
            rows: rows, selectedIds: selectedIds, onSelectRow: onSelectRow, onPriceChanged: onPriceChanged),
      ]),
    );
  }
}
