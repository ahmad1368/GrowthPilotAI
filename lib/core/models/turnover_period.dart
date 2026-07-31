/// Customizable lookback window for turnover-ratio calculations (Issue #447).
enum TurnoverPeriod {
  last30,
  last90,
  last180;

  Duration get duration => switch (this) {
        TurnoverPeriod.last30 => const Duration(days: 30),
        TurnoverPeriod.last90 => const Duration(days: 90),
        TurnoverPeriod.last180 => const Duration(days: 180),
      };

  String get label => switch (this) {
        TurnoverPeriod.last30 => '30 days',
        TurnoverPeriod.last90 => '90 days',
        TurnoverPeriod.last180 => '180 days',
      };
}
