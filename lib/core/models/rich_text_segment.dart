/// One styled run of text parsed from campaign body markup (Issue
/// #407) — deliberately Flutter-free so [ParseCampaignMarkup] stays
/// unit-testable without a widget tree.
class RichTextSegment {
  final String text;
  final bool bold;
  final bool italic;

  const RichTextSegment(this.text, {this.bold = false, this.italic = false});

  @override
  bool operator ==(Object other) =>
      other is RichTextSegment &&
      other.text == text &&
      other.bold == bold &&
      other.italic == italic;

  @override
  int get hashCode => Object.hash(text, bold, italic);
}
