/// Lifecycle of a marketing email campaign (Issue #407) — drafts are
/// reusable as templates (acceptance criterion 4) until scheduled/sent.
enum EmailCampaignStatus { draft, scheduled, sent }
