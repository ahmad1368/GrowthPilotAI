import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/transaction_match_controller.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/transactions/screens/transaction_details_screen.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/transaction_match_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Duplicate Matches screen (Issue #69): every Plaid + accounting record,
/// with high-confidence duplicates auto-merged and flagged. Tap a row to
/// see the merge details / Split action.
class DuplicateMatchesScreen extends StatelessWidget {
  const DuplicateMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<TransactionMatchController>();

    return ShadTheme(
      data: MappingShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Duplicate Matches')),
        body: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.records.length,
              itemBuilder: (context, index) {
                final tx = controller.records[index];
                return TransactionMatchTile(
                  transaction: tx,
                  originSources: controller.viewFor(tx)?.originSources ?? [],
                  onTap: () => Get.to(() => TransactionDetailsScreen(
                        transaction: tx,
                        controller: controller,
                      )),
                );
              },
            )),
      ),
    );
  }
}
