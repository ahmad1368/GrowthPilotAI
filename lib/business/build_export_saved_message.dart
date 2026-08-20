/// "Completion Notification: Once the file is moved to the final
/// directory, trigger... a SnackBar" (Issue #255) — the message text
/// depends on whether [SaveExportBytesToDownloads] actually persisted
/// a copy (Android) or the platform has no public Downloads concept
/// (Web/iOS, where the OS share sheet remains the only save path).
class BuildExportSavedMessage {
  static String call(String filename, {required bool savedToDownloads}) {
    return savedToDownloads ? 'Saved to Downloads/$filename' : 'Ready to share: $filename';
  }
}
