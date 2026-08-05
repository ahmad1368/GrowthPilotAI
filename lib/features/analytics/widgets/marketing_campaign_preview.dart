import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/parse_campaign_markup.dart';

/// Live-rendered preview of the campaign body markup (Issue #407,
/// acceptance criterion 1), split out of
/// [MarketingCampaignComposerField] to stay under the file line cap.
class MarketingCampaignPreview extends StatelessWidget {
  final String markup;

  const MarketingCampaignPreview({super.key, required this.markup});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      for (final segment in ParseCampaignMarkup.call(markup))
        TextSpan(
          text: segment.text,
          style: TextStyle(
            fontWeight: segment.bold ? FontWeight.bold : FontWeight.normal,
            fontStyle: segment.italic ? FontStyle.italic : FontStyle.normal,
          ),
        ),
    ]));
  }
}
