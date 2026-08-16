import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/lookup_help_definition.dart';
import 'package:growth_pilot_ai/core/data/datasources/help_terms_catalog.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Reusable "(i)" info icon + tooltip (Issue #164) — flat, high-contrast
/// styling, not the issue's literal Glassmorphism ask (this app's
/// architecture forbids BackdropFilter), which also satisfies the
/// AODA/WCAG contrast AC better than a blurred background would.
/// Renders nothing when [termKey] isn't in the dictionary, so a missing
/// definition never breaks the header it's attached to.
class InfoTooltip extends StatelessWidget {
  final String termKey;

  const InfoTooltip({super.key, required this.termKey});

  @override
  Widget build(BuildContext context) {
    final definition = LookupHelpDefinition.call(HelpTermsCatalog.definitions, termKey);
    if (definition == null) return const SizedBox.shrink();

    return Tooltip(
      message: definition,
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 5),
      textStyle: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => OmniLogger.info('tooltip_opened: $termKey'),
        child: Icon(Icons.info_outline_rounded, size: 16, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
