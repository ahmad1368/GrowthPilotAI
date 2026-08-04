/// One row in the unified search result list (Issue #404) — sponsored
/// results are tagged so the UI can render the disclosure label
/// (acceptance criterion 2) and telemetry can attribute clicks back to
/// the originating advertising request (acceptance criterion 5).
class SearchResultItem {
  final String name;
  final String category;
  final bool isSponsored;
  final int? advertisingRequestId;

  const SearchResultItem({
    required this.name,
    required this.category,
    required this.isSponsored,
    this.advertisingRequestId,
  });
}
