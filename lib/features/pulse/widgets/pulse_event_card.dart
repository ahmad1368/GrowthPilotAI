import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/data/entities/pulse_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart'; // PulseCategoryX.label

/// One OmniPulse report card (Issue #267/#268) — flat, no
/// glassmorphism/BackdropFilter.
class PulseEventCard extends StatelessWidget {
  final PulseEventEntity event;
  final VoidCallback onHelpful;

  const PulseEventCard({super.key, required this.event, required this.onHelpful});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(event.category.label,
            style: TextStyle(fontSize: 11, color: colors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(event.title, style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(event.description,
            style: TextStyle(fontSize: 12, color: colors.mutedForeground), maxLines: 3, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(event.region, style: TextStyle(fontSize: 11, color: colors.mutedForeground)),
          TextButton.icon(
            onPressed: onHelpful,
            icon: const Icon(Icons.bolt_rounded, size: 16),
            label: Text('Helpful (${event.helpfulCount})'),
          ),
        ]),
      ]),
    );
  }
}
