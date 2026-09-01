/// Per-amount verification result (Issue #203) — [exact] means the
/// AI's figure matches a real record exactly, [fuzzy] means it's
/// within a small rounding tolerance, [mismatch] means it has no
/// correlation with local data ("Hallucination").
enum MatchConfidence { exact, fuzzy, mismatch }
