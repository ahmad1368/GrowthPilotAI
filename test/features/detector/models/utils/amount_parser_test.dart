import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/detector/models/utils/amount_parser.dart';

/// Unit tests for [AmountParser] — the Issue #23 total-amount extractor.
void main() {
  group('AmountParser.extractTotal — labeled total lines', () {
    test('extracts a "Total:" labeled amount', () {
      const text = 'Home Depot\nSubtotal: \$40.00\nTotal: \$45.20\nThank you';
      expect(AmountParser.extractTotal(text), 45.20);
    });

    test('extracts a "Grand Total" labeled amount', () {
      const text = 'Grand Total \$120.00';
      expect(AmountParser.extractTotal(text), 120.00);
    });

    test('extracts an "Amount Due" labeled amount', () {
      const text = 'BC Hydro\nAmount Due: \$88.20\nDue date: 2026-02-01';
      expect(AmountParser.extractTotal(text), 88.20);
    });

    test('extracts a "Balance Due" labeled amount', () {
      const text = 'Balance Due \$15.75';
      expect(AmountParser.extractTotal(text), 15.75);
    });

    test('is case-insensitive', () {
      const text = 'TOTAL: \$9.99';
      expect(AmountParser.extractTotal(text), 9.99);
    });
  });

  group('AmountParser.extractTotal — fallback to largest dollar figure', () {
    test('falls back to the largest bare dollar amount when unlabeled', () {
      const text = 'Coffee \$4.50\nMuffin \$3.25\n\$7.75';
      expect(AmountParser.extractTotal(text), 7.75);
    });

    test('ignores a dated line with no dollar figure', () {
      const text = 'Date: 2026-04-02\nCoffee \$4.50';
      expect(AmountParser.extractTotal(text), 4.50);
    });
  });

  group('AmountParser.extractTotal — comma thousands separator', () {
    test('parses a comma-grouped labeled total as one number', () {
      const text = 'Grand Total: \$1,250.00';
      expect(AmountParser.extractTotal(text), 1250.00);
    });

    test('parses a comma-grouped fallback amount as one number', () {
      const text = 'Item \$45.00\n\$1,250.00';
      expect(AmountParser.extractTotal(text), 1250.00);
    });
  });

  group('AmountParser.extractTotal — trailing currency symbol', () {
    test('extracts the largest amount with the \$ placed after the number',
        () {
      const text = 'Coffee 4.50\$\nMuffin 3.25\$';
      expect(AmountParser.extractTotal(text), 4.50);
    });
  });

  group('AmountParser.extractTotal — no amount present', () {
    test('returns null when no dollar figure exists in the text', () {
      const text = 'Just a note with no pricing information.';
      expect(AmountParser.extractTotal(text), isNull);
    });
  });
}
