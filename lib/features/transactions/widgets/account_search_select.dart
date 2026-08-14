import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Searchable Chart-of-Accounts picker (Issue #58) — shows account code +
/// type so a 200+-account business doesn't miscategorize by name alone.
class AccountSearchSelect extends StatefulWidget {
  final List<ChartOfAccount> accounts;
  final String? initialValue;
  final ValueChanged<ChartOfAccount> onSelected;

  const AccountSearchSelect({
    super.key,
    required this.accounts,
    required this.onSelected,
    this.initialValue,
  });

  @override
  State<AccountSearchSelect> createState() => _AccountSearchSelectState();
}

class _AccountSearchSelectState extends State<AccountSearchSelect> {
  String _query = '';

  List<ChartOfAccount> get _filtered => widget.accounts
      .where((a) =>
          a.accountName.toLowerCase().contains(_query.toLowerCase()) ||
          a.accountId.contains(_query))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ShadSelect<String>.withSearch(
      minWidth: 280,
      initialValue: widget.initialValue,
      placeholder: const Text('Select account...'),
      searchPlaceholder: const Text('Search chart of accounts...'),
      onSearchChanged: (q) => setState(() => _query = q),
      options: _filtered.map(
        (a) => ShadOption(
          value: a.accountId,
          child: Text('${a.accountId} — ${a.accountName}'),
        ),
      ),
      selectedOptionBuilder: (context, value) {
        final match = widget.accounts.firstWhere((a) => a.accountId == value);
        return Text('${match.accountId} — ${match.accountName}');
      },
      onChanged: (value) {
        if (value == null) return;
        final match = widget.accounts.firstWhere((a) => a.accountId == value);
        widget.onSelected(match);
      },
    );
  }
}
