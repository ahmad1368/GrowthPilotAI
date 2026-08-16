/// Lifecycle of the on-device AI model download (Issue #196 scaffolding
/// — see PR notes: no real MediaPipe SDK or downloader is wired up yet).
enum ModelDownloadStatus { notStarted, downloading, paused, completed, failed }
