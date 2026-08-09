import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_asset_custody_transfer.dart';
import 'package:growth_pilot_ai/core/enum/asset_custody_status.dart';

void main() {
  test('active assets can change custody', () {
    final check = ComputeAssetCustodyTransfer.call(AssetCustodyStatus.active);
    expect(check.isValid, isTrue);
    expect(check.error, isNull);
  });

  test('retired assets can still change custody', () {
    final check = ComputeAssetCustodyTransfer.call(AssetCustodyStatus.retired);
    expect(check.isValid, isTrue);
  });

  test('assets under maintenance reject custody transfer', () {
    final check = ComputeAssetCustodyTransfer.call(AssetCustodyStatus.underMaintenance);
    expect(check.isValid, isFalse);
    expect(check.error, contains('under maintenance'));
  });
}
