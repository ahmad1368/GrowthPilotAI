import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_request.dart';
import 'package:growth_pilot_ai/features/detector/models/services/financial_parser.dart';

/// Covers the Issue #23 addition of a parsed [amount] to
/// [FinancialParser]'s result — previously only date/currency were parsed,
/// and the Amount field shown on the confirmation screen came from the OCR
/// confidence score instead (see ScannerWorkflow._navigateToConfirmation).
void main() {
  test('parses a labeled total alongside the date and currency', () async {
    final response = await FinancialParser().parse(const FinancialParserRequest(
      lines: ['Home Depot', '2026-01-05', 'Total: \$45.20'],
    ));

    expect(response.success, isTrue);
    expect(response.data!.amount, 45.20);
    expect(response.data!.currency, 'CAD');
  });

  test('detects USD from the receipt text', () async {
    final response = await FinancialParser().parse(const FinancialParserRequest(
      lines: ['2026-01-05', 'Total: \$10.00 USD'],
    ));

    expect(response.data!.currency, 'USD');
  });

  test('amount is null when no dollar figure is present', () async {
    final response = await FinancialParser()
        .parse(const FinancialParserRequest(lines: ['2026-01-05', 'no pricing here']));

    expect(response.data!.amount, isNull);
  });
}
