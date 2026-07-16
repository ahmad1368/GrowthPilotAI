import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/category_mapping_controller.dart';
import 'package:growth_pilot_ai/core/data/chart_of_accounts_seed.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/account_search_select.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/mapping_card_footer.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/mapping_status_chip.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's uncategorized-transaction batch on the Category Mapping
/// screen (Issue #58): confidence chip, searchable account picker, and the
/// confirm/rule-creation footer.
class MappingCard extends StatefulWidget {
  final MerchantMappingGroup group;
  final CategoryMappingController controller;

  const MappingCard({super.key, required this.group, required this.controller});

  @override
  State<MappingCard> createState() => _MappingCardState();
}

class _MappingCardState extends State<MappingCard> {
  ChartOfAccount? _selected;

  @override
  void initState() {
    super.initState();
    final suggestedId = widget.group.mapping.suggestedAccountId;
    if (suggestedId != null) {
      for (final a in ChartOfAccountsSeed.accounts) {
        if (a.accountId == suggestedId) {
          _selected = a;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(widget.group.merchantName)),
          const SizedBox(width: 8),
          MappingStatusChip(mapping: widget.group.mapping),
        ],
      ),
      description: Text(
          '${widget.group.transactionCount} transactions · \$${widget.group.totalAmount.toStringAsFixed(2)}'),
      footer: MappingCardFooter(
        group: widget.group,
        selected: _selected,
        controller: widget.controller,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: AccountSearchSelect(
          accounts: ChartOfAccountsSeed.accounts,
          initialValue: _selected?.accountId,
          onSelected: (account) {
            setState(() => _selected = account);
            widget.controller.selectAccount(widget.group.merchantName, account.accountId);
          },
        ),
      ),
    );
  }
}
