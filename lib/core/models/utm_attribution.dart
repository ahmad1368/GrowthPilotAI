/// Which marketing channel/campaign brought a visitor in (Issue #192's
/// "Lead Tracking & Analytics": `utm_source`/`utm_campaign`), e.g.
/// `utm_source=linkedin&utm_campaign=bc_outreach`.
class UtmAttribution {
  final String source;
  final String? campaign;

  const UtmAttribution({required this.source, this.campaign});
}
