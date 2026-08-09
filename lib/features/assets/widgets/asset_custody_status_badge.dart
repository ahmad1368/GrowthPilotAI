import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/asset_custody_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat status indicator for an asset's custody state (Issue #157) — no
/// glassmorphism, same flat-badge precedent as TrustScoreBadge (#135).
class AssetCustodyStatusBadge extends StatelessWidget {
  final AssetCustodyStatus status;

  const AssetCustodyStatusBadge({super.key, required this.status});

  String get _label => switch (status) {
        AssetCustodyStatus.active => 'Active',
        AssetCustodyStatus.underMaintenance => 'Under maintenance',
        AssetCustodyStatus.retired => 'Retired',
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final accent =
        status == AssetCustodyStatus.underMaintenance ? colors.destructive : colors.border;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: accent), borderRadius: BorderRadius.circular(20)),
      child: Text(_label, style: TextStyle(color: colors.foreground, fontSize: 12)),
    );
  }
}
