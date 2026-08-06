import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/enum/seasonal_catalog_status.dart';

/// One-sentence read summarizing the seasonal pre-order pipeline
/// (Issue #417), mirroring [BuildGroupPurchaseNarrative]'s summary
/// pattern.
class BuildSeasonalCatalogNarrative {
  static String call(List<SeasonalCatalogItemEntity> items) {
    if (items.isEmpty) {
      return 'No seasonal catalog lines yet.';
    }
    final open = items.where((i) => i.status == SeasonalCatalogStatus.open).length;
    return '${items.length} catalog line(s): $open open for pre-order.';
  }
}
