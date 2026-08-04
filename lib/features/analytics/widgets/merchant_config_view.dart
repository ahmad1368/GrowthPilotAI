import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_merchant_config_narrative.dart';
import 'package:growth_pilot_ai/business/build_trust_score_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_trust_score.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_search_field.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the search box, add button, filtered profile rows (each with
/// its trust score badge, Issue #347), and summary narratives (Issue
/// #338). Purely presentational — the profile list and search state are
/// owned by [MerchantConfigBody].
class MerchantConfigView extends StatelessWidget {
  final List<MerchantConfigEntity> filteredResults;
  final List<MerchantConfigEntity> allResults;
  final List<MerchantTrustScore> trustScores;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onAddProfile;
  final ValueChanged<MerchantConfigEntity> onEditProfile;

  const MerchantConfigView({
    super.key,
    required this.filteredResults,
    required this.allResults,
    required this.trustScores,
    required this.onSearchChanged,
    required this.onAddProfile,
    required this.onEditProfile,
  });

  MerchantTrustScore? _scoreFor(MerchantConfigEntity config) {
    final matches = trustScores.where((s) => s.businessId == config.businessId);
    return matches.isEmpty ? null : matches.first;
  }

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: MerchantConfigSearchField(onChanged: onSearchChanged)),
            const SizedBox(width: 8),
            ShadButton.outline(
              onPressed: onAddProfile,
              child: Text('+ Add', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final config in filteredResults)
          MerchantConfigRow(
              config: config,
              trustScore: _scoreFor(config),
              onTap: () => onEditProfile(config)),
        const SizedBox(height: 8),
        Text(BuildMerchantConfigNarrative.call(allResults)),
        Text(BuildTrustScoreNarrative.call(trustScores)),
      ],
    );
  }
}
