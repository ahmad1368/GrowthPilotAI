import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_price_cell.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_admin_table_rows.dart';

/// The scrollable data table itself (Issue #143) — split out of
/// [AdminTableView] to stay under the file line cap.
class AdminTableDataTable extends StatelessWidget {
  final List<AdminRow> rows;
  final Set<int> selectedIds;
  final void Function(int id, bool selected) onSelectRow;
  final void Function(int id, double price) onPriceChanged;

  const AdminTableDataTable({
    super.key,
    required this.rows,
    required this.selectedIds,
    required this.onSelectRow,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('Title')),
        DataColumn(label: Text('Category')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Stock')),
        DataColumn(label: Text('Status')),
      ],
      rows: [
        for (final row in rows)
          DataRow(
            color: row.isLowStock ? WidgetStateProperty.all(Colors.red.withValues(alpha: 0.08)) : null,
            cells: [
              DataCell(Checkbox(
                  value: selectedIds.contains(row.id), onChanged: (v) => onSelectRow(row.id, v ?? false))),
              DataCell(Text(row.title)),
              DataCell(Text(row.category)),
              DataCell(
                  AdminTablePriceCell(price: row.price, onChanged: (price) => onPriceChanged(row.id, price))),
              DataCell(Text(row.stockLevel.toString())),
              DataCell(Text(row.availability)),
            ],
          ),
      ],
    );
  }
}
