/// The "hidden prompt" re-sent to the SLM when a hallucination is
/// detected (Issue #203's "Self-Correction Loop"), matching the
/// issue's own worked example format.
class BuildSelfCorrectionPrompt {
  static String call(double mentionedAmount, double? correctAmount) {
    final correction = correctAmount != null
        ? 'the record shows \$${correctAmount.toStringAsFixed(2)}'
        : 'no matching record was found';
    return 'Error: You mentioned \$${mentionedAmount.toStringAsFixed(2)} but $correction. '
        'Please correct your summary.';
  }
}
