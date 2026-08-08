import 'package:growth_pilot_ai/business/compute_average_procurement_lead_time.dart';
import 'package:growth_pilot_ai/business/compute_b2b_conversion_funnel.dart';
import 'package:growth_pilot_ai/business/compute_market_liquidity_heatmap.dart';
import 'package:growth_pilot_ai/business/compute_regional_price_volatility.dart';
import 'package:growth_pilot_ai/business/compute_sector_saturation.dart';
import 'package:growth_pilot_ai/business/forecast_weekly_b2b_demand.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/b2b_analytics_repos.dart';

/// The full "B2B Intelligence Hub" summary (Issue #129), computed from
/// the #126/#128 procurement data — one call bundles every metric the
/// dashboard needs.
typedef B2bAnalyticsSummary = ({
  List<({String sector, int count})> sectorSaturation,
  Duration averageLeadTime,
  List<({String neighborhood, double stdDev})> priceVolatility,
  ({int broadcast, int negotiating, int matched}) funnel,
  List<({String neighborhood, int active, int completed})> liquidityHeatmap,
  double nextWeekDemandForecast,
});

class BuildB2bAnalyticsSummary {
  static B2bAnalyticsSummary call(B2bAnalyticsRepos repos) {
    final requests = repos.requests.getAll();
    final responses = repos.responses.getAll();
    return (
      sectorSaturation: ComputeSectorSaturation.call(requests),
      averageLeadTime: ComputeAverageProcurementLeadTime.call(requests, responses),
      priceVolatility: ComputeRegionalPriceVolatility.call(requests),
      funnel: ComputeB2BConversionFunnel.call(requests, responses),
      liquidityHeatmap: ComputeMarketLiquidityHeatmap.call(requests),
      nextWeekDemandForecast: ForecastWeeklyB2BDemand.call(requests),
    );
  }
}
