import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';

/// One application module's toggle row (Issue #339). Tapping opens its
/// edit dialog for direct enable/disable editing.
class FeatureToggleRow extends StatelessWidget {
  final FeatureModuleToggleEntity toggle;
  final VoidCallback onTap;

  const FeatureToggleRow({super.key, required this.toggle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text('${toggle.moduleName} — ${toggle.routeName}',
                    overflow: TextOverflow.ellipsis)),
            Text(toggle.isEnabled ? 'Enabled' : 'Disabled',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: toggle.isEnabled
                        ? scheme.primary
                        : scheme.onSurface.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}
