import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/scan_asset_maintenance_alerts.dart';
import 'package:growth_pilot_ai/core/models/asset_maintenance_input.dart';

void main() {
  final now = DateTime(2026, 6, 1);

  test('flags an asset with no service history', () async {
    final result = await ScanAssetMaintenanceAlerts.call(
        [const AssetMaintenanceInput(itemName: 'Forklift A')], now);

    expect(result.data, hasLength(1));
    expect(result.data!.first.title, contains('Forklift A'));
  });

  test('flags an asset past its service interval', () async {
    final overdue = AssetMaintenanceInput(
        itemName: 'Van B',
        lastServiceDate: now.subtract(const Duration(days: 200)),
        serviceIntervalDays: 180);

    final result = await ScanAssetMaintenanceAlerts.call([overdue], now);
    expect(result.data, hasLength(1));
  });

  test('does not flag an asset serviced within its interval', () async {
    final fresh = AssetMaintenanceInput(
        itemName: 'Van C',
        lastServiceDate: now.subtract(const Duration(days: 10)),
        serviceIntervalDays: 180);

    final result = await ScanAssetMaintenanceAlerts.call([fresh], now);
    expect(result.data, isEmpty);
  });
}
