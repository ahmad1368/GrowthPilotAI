import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_ad_package_price.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

void main() {
  test('the homepage banner is priced higher than a featured slot', () {
    final bannerPrice = ComputeAdPackagePrice.call(AdPackageType.homepageBanner);
    final featuredPrice = ComputeAdPackagePrice.call(AdPackageType.featuredSlot);

    expect(bannerPrice, greaterThan(featuredPrice));
  });

  test('prices are positive for every package type', () {
    for (final type in AdPackageType.values) {
      expect(ComputeAdPackagePrice.call(type), greaterThan(0));
    }
  });
}
