import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/channel_sales_snapshot.dart';

/// One-sentence read on which channel is pulling ahead (Issue #384).
class BuildChannelSalesNarrative {
  static String call(List<ChannelSalesSnapshot> snapshots) {
    final totalRevenue =
        snapshots.fold<double>(0, (sum, s) => sum + s.estimatedRevenue);
    if (totalRevenue <= 0) {
      return 'Not enough sale history yet to compare channels.';
    }

    final leader = snapshots.reduce(
        (a, b) => b.estimatedRevenue > a.estimatedRevenue ? b : a);
    final leaderLabel = leader.channel == SalesChannel.pos ? 'In-store' : 'Online';
    final pct = (leader.estimatedRevenue / totalRevenue * 100).toStringAsFixed(0);
    return '$leaderLabel sales drive $pct% of estimated revenue — '
        'shift promotional focus toward the channel your customers prefer.';
  }
}
