import 'package:growth_pilot_ai/core/models/statutory_holiday.dart';

/// Fixed-date Canadian statutory holidays (Issue #388) — a documented
/// static reference list, not a live calendar/events API integration,
/// which this app has no data source for. Deliberately excludes
/// floating-date holidays (e.g. Family Day, Victoria Day) to avoid
/// nth-weekday-of-month calculation complexity.
const canadianStatutoryHolidays = [
  StatutoryHoliday("New Year's Day", 1, 1),
  StatutoryHoliday('Canada Day', 7, 1),
  StatutoryHoliday('Remembrance Day', 11, 11),
  StatutoryHoliday('Christmas Day', 12, 25),
  StatutoryHoliday('Boxing Day', 12, 26),
];
