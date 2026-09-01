/// A merchant's response to one restocking recommendation (Issue
/// #418, acceptance criterion 4) — feeds [ComputeRecommendationConfidence]
/// so future recommendations for the same item can weigh how often
/// past suggestions were actually acted on.
enum RecommendationFeedbackStatus { accepted, dismissed }
