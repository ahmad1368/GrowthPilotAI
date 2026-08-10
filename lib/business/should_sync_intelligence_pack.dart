/// "Delta-Update Logic" (Issue #86 scope item 3): sync only when the
/// remote pack is newer than what's stored locally, avoiding a full
/// re-download every check. [localVersion] is null when no pack has
/// ever been synced for this sector.
class ShouldSyncIntelligencePack {
  static bool call(int? localVersion, int remoteVersion) =>
      localVersion == null || remoteVersion > localVersion;
}
