import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/estimate_audience_segment_size.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

void main() {
  test('high-traffic category with no filters gives the largest pool', () {
    final result = EstimateAudienceSegmentSize.call(
      category: 'Grocery',
      region: '',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.featuredSlot,
    );

    expect(result, 400); // 500 base * 1.0 region * 1.0 reliability * 0.8 tier
  });

  test('a region filter narrows the audience', () {
    final withoutRegion = EstimateAudienceSegmentSize.call(
      category: 'Bakery',
      region: '',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.featuredSlot,
    );
    final withRegion = EstimateAudienceSegmentSize.call(
      category: 'Bakery',
      region: 'Downtown Vancouver',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.featuredSlot,
    );

    expect(withRegion, lessThan(withoutRegion));
  });

  test('homepageBanner tier is narrower than featuredSlot for the same segment', () {
    final banner = EstimateAudienceSegmentSize.call(
      category: 'Retail',
      region: '',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.homepageBanner,
    );
    final featured = EstimateAudienceSegmentSize.call(
      category: 'Retail',
      region: '',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.featuredSlot,
    );

    expect(banner, lessThan(featured));
  });

  test('a higher minimum payment reliability narrows the audience', () {
    final lenient = EstimateAudienceSegmentSize.call(
      category: 'Other',
      region: '',
      minPaymentReliability: 0,
      requiredTier: AdPackageType.featuredSlot,
    );
    final strict = EstimateAudienceSegmentSize.call(
      category: 'Other',
      region: '',
      minPaymentReliability: 90,
      requiredTier: AdPackageType.featuredSlot,
    );

    expect(strict, lessThan(lenient));
  });
}
