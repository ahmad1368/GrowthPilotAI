/// "Prompts users for feedback after their 3rd successful invoice
/// scan or 1st marketplace match" (Issue #191) — a pure trigger check.
class ShouldPromptBetaFeedback {
  static bool call({required int invoiceScanCount, required int marketplaceMatchCount}) =>
      invoiceScanCount >= 3 || marketplaceMatchCount >= 1;
}
