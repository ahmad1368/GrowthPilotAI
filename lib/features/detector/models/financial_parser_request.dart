class FinancialParserRequest {
  final List<String> lines;
  final String preferredFormat; // "MM/DD" or "DD/MM"

  const FinancialParserRequest(
      {required this.lines, this.preferredFormat = "MM/DD"});
}
