import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_repos.dart';

/// Catalog line creation (Issue #417, acceptance criterion 1) —
/// split out of [SeasonalCatalogBody].
class SeasonalCatalogActions {
  final PreOrderRepos repos;

  SeasonalCatalogActions(this.repos);

  SeasonalCatalogItemEntity create(SeasonalCatalogItemEntity item) {
    repos.catalog.save(item);
    return item;
  }
}
