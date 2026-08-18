import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_search_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Citations" list (Issue #230, AC: 'Found on Page 12 of Document A')
/// — [chunkIndex] stands in for a real page number (see PR notes).
class DocumentSearchResultsList extends StatelessWidget {
  final DocumentSearchController controller;

  const DocumentSearchResultsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.isSearching.value) {
        return Text('Searching...', style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      if (controller.results.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final result in controller.results)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.sourceText, style: TextStyle(color: colors.foreground, fontSize: 13)),
                  Text('Found in chunk ${result.chunkIndex} of ${result.documentId}',
                      style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
                ],
              ),
            ),
        ],
      );
    });
  }
}
