import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/business/scan_low_stock_alerts.dart';
import 'package:growth_pilot_ai/business/should_run_low_stock_scan.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_item_repository.dart';

/// "Automated background worker" for low-stock alerts (Issue #440 AC 2)
/// — mirrors [InsightTriggerService]'s throttle-gated shape. Every
/// inventory-screen visit calls [scanIfDue], but a scan (and any
/// resulting push/in-app dispatch via [DispatchNotificationUseCase],
/// which already applies #71's rate limiting) only actually runs once
/// per [ShouldRunLowStockScan.interval].
class LowStockScanTriggerService {
  final InventoryItemRepository _items;
  final InboxNotificationRepository _notificationRepo;
  final DispatchNotificationUseCase _dispatcher;
  DateTime? _lastScanAt;

  LowStockScanTriggerService(this._items, this._notificationRepo, this._dispatcher);

  Future<void> scanIfDue({DateTime? now}) async {
    final at = now ?? DateTime.now();
    if (!ShouldRunLowStockScan.call(_lastScanAt, at)) return;
    _lastScanAt = at;

    final result = await ScanLowStockAlerts.call(_items.getAll(), at);
    final history = _notificationRepo.getAll();
    for (final notification in result.data ?? const []) {
      final dispatched = await _dispatcher.dispatch(notification, history);
      if (dispatched != null) _notificationRepo.upsert(dispatched);
    }
  }
}
