import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One campaign row (Issue #407) — shows engagement metrics once sent
/// (acceptance criterion 5), and a Clone action that reuses the
/// campaign as a template (acceptance criterion 4).
class MarketingCampaignRow extends StatelessWidget {
  final MarketingCampaignEntity campaign;
  final VoidCallback onClone;
  final VoidCallback onSend;

  const MarketingCampaignRow(
      {super.key, required this.campaign, required this.onClone, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sent = campaign.status == EmailCampaignStatus.sent;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              sent
                  ? '${campaign.subject} (${campaign.requiredTier.name}) — '
                      '${(campaign.openRate * 100).toStringAsFixed(1)}% open, '
                      '${(campaign.clickRate * 100).toStringAsFixed(1)}% click'
                  : '${campaign.subject} (${campaign.requiredTier.name}) — '
                      '${campaign.status.name}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ShadButton.ghost(onPressed: onClone, child: const Text('Clone')),
          if (!sent)
            ShadButton.ghost(onPressed: onSend, child: const Text('Send'))
          else
            Text('Sent', style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
        ],
      ),
    );
  }
}
