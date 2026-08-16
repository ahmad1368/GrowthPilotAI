/// Contextual quick-prompt suggestions for the current screen (Issue
/// #200 AC: "Quick Prompts... based on the current screen, e.g. if on
/// the Invoice screen, show 'Summarize this month's taxes'"). An
/// unrecognized [screenId] falls back to general prompts instead of
/// showing nothing.
class BuildQuickPrompts {
  static List<String> call(String screenId) => switch (screenId) {
        'invoices' => const [
            "Summarize this month's taxes",
            'What did I spend the most on?',
          ],
        'marketplace' => const [
            'How are my listings performing?',
            'Which category sells best?',
          ],
        'analytics' => const [
            'Explain my efficiency score',
            'Compare this month to last month',
          ],
        _ => const [
            'What is my total balance?',
            'Summarize my recent activity',
          ],
      };
}
