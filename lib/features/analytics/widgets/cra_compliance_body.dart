import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_view.dart';

/// Owns the CRA compliance ledger state (Issue #428) — decryption and
/// integrity checks are async, so this is the app's first
/// dashboard widget that loads its data after the first frame rather
/// than synchronously in the constructor.
class CraComplianceBody extends StatefulWidget {
  const CraComplianceBody({super.key});
  @override
  State<CraComplianceBody> createState() => _CraComplianceBodyState();
}

class _CraComplianceBodyState extends State<CraComplianceBody> {
  final _repos = CraComplianceRepos();
  late final _actions = CraComplianceActions(_repos);
  bool _loading = true;
  List<CraComplianceRow> _rows = const [];

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    final rows = await _actions.loadRows();
    if (mounted) {
      setState(() {
        _rows = rows;
        _loading = false;
      });
    }
  }

  Future<void> _sync() async {
    await _actions.syncSettledTransactions();
    await _reload();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return CraComplianceView(rows: _rows, onSync: _sync);
  }
}
