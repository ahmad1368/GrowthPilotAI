import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_asset_service_alert.dart';
import 'package:growth_pilot_ai/core/models/asset_maintenance_input.dart';

void main() {
  final now = DateTime(2026, 6, 1);

  test('flags an asset with no service history', () {
    final alert =
        BuildAssetServiceAlert.call(const AssetMaintenanceInput(itemName: 'Forklift A'), now);

    expect(alert, isNotNull);
    expect(alert!.title, contains('Forklift A'));
  });

  test('flags an asset past its service interval', () {
    final overdue = AssetMaintenanceInput(
        itemName: 'Van B',
        lastServiceDate: now.subtract(const Duration(days: 200)),
        serviceIntervalDays: 180);

    expect(BuildAssetServiceAlert.call(overdue, now), isNotNull);
  });

  test('does not flag an asset serviced within its interval', () {
    final fresh = AssetMaintenanceInput(
        itemName: 'Van C',
        lastServiceDate: now.subtract(const Duration(days: 10)),
        serviceIntervalDays: 180);

    expect(BuildAssetServiceAlert.call(fresh, now), isNull);
  });
}
