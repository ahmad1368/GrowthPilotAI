import 'package:growth_pilot_ai/core/enum/traffic_view.dart';

/// Human-readable label for one traffic bucket (Issue #365): "2PM" for
/// hours, "Mon" for weekdays.
class TrafficBucketLabel {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static String call(int bucket, TrafficView view) {
    if (view == TrafficView.byDayOfWeek) return _days[bucket];
    final period = bucket < 12 ? 'AM' : 'PM';
    final hour12 = bucket % 12 == 0 ? 12 : bucket % 12;
    return '$hour12$period';
  }
}
