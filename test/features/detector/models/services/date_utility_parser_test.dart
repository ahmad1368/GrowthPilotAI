import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/detector/models/services/date_utility_parser.dart';

/// Covers Issue #24's date-normalization requirements. Regression focus:
/// `DateTime.tryParse` has no notion of month names, so "Apr 02, 2026" used
/// to silently fail and fall back to today's date — DateUtilityParser now
/// resolves it manually via MonthNameResolver.
void main() {
  group('DateUtilityParser.findAndNormalizeDate', () {
    test('parses an ISO YYYY-MM-DD date', () {
      final date =
          DateUtilityParser.findAndNormalizeDate(['Home Depot', '2026-04-02']);
      expect(date, DateTime(2026, 4, 2));
    });

    test('parses a North American MM-DD-YYYY date', () {
      final date = DateUtilityParser.findAndNormalizeDate(['04/02/2026']);
      expect(date, DateTime(2026, 4, 2));
    });

    test('parses a short MM-DD-YY date, expanding the year to 20YY', () {
      final date = DateUtilityParser.findAndNormalizeDate(['04/02/26']);
      expect(date, DateTime(2026, 4, 2));
    });

    test('parses a month-name date with an explicit year', () {
      final date = DateUtilityParser.findAndNormalizeDate(['Apr 02, 2026']);
      expect(date, DateTime(2026, 4, 2));
    });

    test('defaults to the current year when a month-name date omits it', () {
      final date = DateUtilityParser.findAndNormalizeDate(['Apr 02']);
      expect(date, DateTime(DateTime.now().year, 4, 2));
    });

    test('returns null when no date pattern matches', () {
      final date = DateUtilityParser.findAndNormalizeDate(['no dates here']);
      expect(date, isNull);
    });
  });
}
