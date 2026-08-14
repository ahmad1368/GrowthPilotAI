import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_bulk_actions.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_view.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_admin_table_rows.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/update_listing_price.dart';

/// Owns the Admin Product Table demo's state (Issue #143) — a flat
/// Flutter [DataTable], not React/TanStack Table (this app is
/// Flutter-only end-to-end, including its web build).
class AdminTableBody extends StatefulWidget {
  const AdminTableBody({super.key});
  @override
  State<AdminTableBody> createState() => _AdminTableBodyState();
}

class _AdminTableBodyState extends State<AdminTableBody> {
  final _repos = AdminTableRepos();
  late List<AdminRow> _rows = buildAdminTableRows(_repos);
  final _selectedIds = <int>{};
  late final _bulkActions = AdminTableBulkActions(_repos, _selectedIds, _refresh);

  void _refresh() => setState(() {
        _rows = buildAdminTableRows(_repos);
        _selectedIds.clear();
      });

  void _toggleRow(int id, bool selected) => setState(() {
        selected ? _selectedIds.add(id) : _selectedIds.remove(id);
      });

  void _changePrice(int id, double price) {
    updateListingPrice(_repos, id, price);
    setState(() => _rows = buildAdminTableRows(_repos));
  }

  @override
  Widget build(BuildContext context) => AdminTableView(
        rows: _rows,
        selectedIds: _selectedIds,
        onSelectRow: _toggleRow,
        onPriceChanged: _changePrice,
        onDeactivate: _bulkActions.deactivate,
        onDelete: _bulkActions.delete,
        onChangeCategory: _bulkActions.changeCategory,
      );
}
