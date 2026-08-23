# 0001: Local-first persistence with ObjectBox

## Status
Accepted

## Context
GrowthPilotAI's mission (`docs/PRODUCT_VISION.md`) is an offline-first back
office for Canadian SMBs that doesn't require a permanent cloud connection,
and treats cloud/AI services as opt-in rather than a hard dependency
(`docs/compliance/zero-cloud-ai-audit.md`). That rules out a
server-database-as-source-of-truth architecture: every feature — bank
reconciliation, document scanning, chat, analytics — needs to work fully
offline, on-device, with sync (Plaid, Xero/QBO) as an enhancement layered on
top rather than the foundation.

## Decision
Every entity in the app persists through a single shared ObjectBox `Store`
(`lib/core/data/objectbox_provider.dart`), opened once in `main.dart` before
`runApp` and injected via GetX. Repositories are thin wrappers around a
`Box<Entity>` (e.g. `PulseEventRepository`, `UnifiedTransactionRepository`) —
no ORM abstraction layer, no server round-trip for reads/writes. Conflict
resolution for anything that syncs from an external source is Last-Write-Wins
by design, not optimistic locking against a server.

## Consequences
- Every feature works with zero connectivity by default; sync is additive.
- No real-time cross-device sync exists — this is a single-install-scoped
  store, not a distributed database. Multi-device support would need a
  fundamentally different architecture, not an incremental change.
- ObjectBox has no Flutter Web backend, and nothing in this codebase guards
  for that (`kIsWeb`) around the store itself — the entire data layer is a
  known, pre-existing gap on Flutter Web, not something any single feature
  PR can fix in isolation.
- Every new entity requires running the ObjectBox code generator
  (`flutter pub run build_runner build --delete-conflicting-outputs`) and
  committing the generated `lib/objectbox.g.dart` — a real, recurring
  developer-workflow cost that a server-side schema migration wouldn't have.
