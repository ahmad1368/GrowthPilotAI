import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/org_switcher_controller.dart';
import 'package:growth_pilot_ai/features/organization/widgets/org_switcher_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Team Switcher" (Issue #156 AC) — a flat list, not the issue's literal
/// glass-morphic drawer (architecture forbids Glassmorphism/BackdropFilter;
/// same precedent as #128/#152/#154's flat panels). [businessNames] maps a
/// businessId to its display label.
class OrgSwitcherPanel extends StatelessWidget {
  final OrgSwitcherController controller;
  final Map<String, String> businessNames;

  const OrgSwitcherPanel({
    super.key,
    required this.controller,
    required this.businessNames,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() => Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Organizations',
                  style: TextStyle(color: colors.foreground, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...controller.accessibleBusinessIds.map((id) => OrgSwitcherTile(
                    label: businessNames[id] ?? id,
                    isActive: controller.activeBusinessId.value == id,
                    onTap: () => controller.switchTo(id),
                  )),
            ],
          ),
        ));
  }
}
