/// The client-local stand-in for Issue #251's server-side async PDF
/// job (`queued` -> Puppeteer worker -> `export_ready` Socket.io event)
/// — no Node.js/BullMQ/Puppeteer backend exists in this repo, so the
/// "job" is really just this in-app state machine around a local
/// `pdf`-package render (see PR notes).
enum PdfExportJobStatus { idle, preparing, ready, failed }
