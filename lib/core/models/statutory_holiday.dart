import 'package:flutter/foundation.dart';

/// A fixed-date Canadian statutory holiday (Issue #388) — month/day only,
/// since it recurs on the same calendar date every year.
@immutable
class StatutoryHoliday {
  final String name;
  final int month;
  final int day;

  const StatutoryHoliday(this.name, this.month, this.day);
}
