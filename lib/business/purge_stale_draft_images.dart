typedef StaleCheckImage = ({int id, DateTime createdAt});

/// Finds image variants older than 24h that aren't referenced by any
/// saved listing or the in-progress draft, so they're eligible for
/// cleanup (Issue #140, acceptance criterion "Privacy Integrity" —
/// this app has no cloud storage/Cleanup Worker, so this is the local
/// equivalent: unreferenced local rows past the same 24h window).
class PurgeStaleDraftImages {
  static const staleAfter = Duration(hours: 24);

  static List<int> call({
    required List<StaleCheckImage> images,
    required Set<int> referencedIds,
    required DateTime now,
  }) {
    return images
        .where((v) => !referencedIds.contains(v.id) && now.difference(v.createdAt) > staleAfter)
        .map((v) => v.id)
        .toList();
  }
}
