/// Local stand-in for Issue #232's Postgres `DocumentStatus` state
/// machine (`PENDING/UPLOADING/PRE_PROCESSING/AI_ANALYZING/COMPLETED/
/// FAILED`) — driven entirely client-side (no Node/Python/Redis/S3
/// backend exists in this repo; see PR notes).
enum DocumentProcessingStage { pending, uploading, cleaning, extracting, completed, failed }
