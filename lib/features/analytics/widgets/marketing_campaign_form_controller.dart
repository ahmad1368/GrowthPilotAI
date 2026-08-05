import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/estimate_audience_segment_size.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

/// Holds the new-campaign form's text controllers and derives the
/// submitted entity (Issue #407) — split out of
/// [MarketingCampaignDialogContent] to stay under the file line cap.
class MarketingCampaignFormController {
  final subject = TextEditingController();
  final category = TextEditingController();
  final region = TextEditingController();
  final body = TextEditingController();
  final reliability = TextEditingController(text: '50');
  final scheduleHours = TextEditingController(text: '24');
  AdPackageType tier = AdPackageType.featuredSlot;

  int get reliabilityValue =>
      int.tryParse(reliability.text)?.clamp(0, 100) ?? 50;
  int get scheduleHoursValue =>
      int.tryParse(scheduleHours.text)?.clamp(1, 24 * 30) ?? 24;

  int get estimatedAudience => EstimateAudienceSegmentSize.call(
        category: category.text,
        region: region.text,
        minPaymentReliability: reliabilityValue,
        requiredTier: tier,
      );

  bool get isValid =>
      subject.text.trim().isNotEmpty && category.text.trim().isNotEmpty;

  MarketingCampaignEntity build() {
    final now = DateTime.now();
    return MarketingCampaignEntity(
      subject: subject.text.trim(),
      bodyMarkup: body.text,
      segmentCategory: category.text.trim(),
      segmentRegion: region.text.trim(),
      minPaymentReliability: reliabilityValue,
      dbRequiredTier: tier.index,
      scheduledAt: now.add(Duration(hours: scheduleHoursValue)),
      createdAt: now,
    );
  }
}
