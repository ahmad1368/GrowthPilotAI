import 'package:growth_pilot_ai/core/data/entities/action_impact_item_entity.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

/// [ActionImpactItemEntity] <-> [ActionImpactItem] conversions (Issue #260).
extension ActionImpactItemMapper on ActionImpactItemEntity {
  ActionImpactItem toModel() => ActionImpactItem(
        id: id,
        title: title,
        estimatedProfit: estimatedProfit,
        dailyOpportunityCost: dailyOpportunityCost,
        status: status,
        createdAt: createdAt,
        completedAt: completedAt,
      );
}

extension ActionImpactItemEntityMapper on ActionImpactItem {
  ActionImpactItemEntity toEntity() => ActionImpactItemEntity(
        id: id,
        title: title,
        estimatedProfit: estimatedProfit,
        dailyOpportunityCost: dailyOpportunityCost,
        dbStatus: status.index,
        createdAt: createdAt,
        completedAt: completedAt,
      );
}
