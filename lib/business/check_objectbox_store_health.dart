import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';

/// Checks the local ObjectBox [Store] used for every entity in the app
/// (Issue #166's "Database" indicator, reinterpreted — this app has no
/// MongoDB Atlas connection to ping).
class CheckObjectBoxStoreHealth {
  static ServiceHealthIndicator call(ObjectBox objectBox) {
    final isClosed = objectBox.store.isClosed();
    return ServiceHealthIndicator(
      name: 'ObjectBox Database',
      status: isClosed ? ServiceHealthStatus.down : ServiceHealthStatus.up,
      message: isClosed ? 'Store is closed' : 'Connected',
    );
  }
}
