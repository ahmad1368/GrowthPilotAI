/// Coarse hour-of-day band for the Store Traffic Heatmap (Issue #354) —
/// keeps the day x hour grid compact instead of 24 raw hour columns.
enum TrafficDayPart {
  morning,
  afternoon,
  evening,
  night;

  String get label => switch (this) {
        TrafficDayPart.morning => 'Morning',
        TrafficDayPart.afternoon => 'Afternoon',
        TrafficDayPart.evening => 'Evening',
        TrafficDayPart.night => 'Night',
      };

  /// Maps a 0-23 hour-of-day to its band; night wraps past midnight.
  static TrafficDayPart fromHour(int hour) {
    if (hour >= 6 && hour < 12) return TrafficDayPart.morning;
    if (hour >= 12 && hour < 17) return TrafficDayPart.afternoon;
    if (hour >= 17 && hour < 21) return TrafficDayPart.evening;
    return TrafficDayPart.night;
  }
}
