/// Result of a Last-Write-Wins comparison between a local and a cloud record.
enum ConflictOutcome {
  takeCloud, // cloud is newer -> overwrite local
  pushLocal, // local is newer -> upsert to cloud
  deleteBoth, // newer side is soft-deleted -> remove everywhere
  inSync, // identical timestamps -> nothing to do (idempotent)
}
