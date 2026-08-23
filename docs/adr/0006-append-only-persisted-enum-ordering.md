# 0006: Append-only ordering for enums backed by a persisted int index

## Status
Accepted

## Context
Issue #180 asks for cross-repo type synchronization (NestJS Swagger schema
-> generated TypeScript/Dart types) so a backend field rename or an enum
change can't silently desync a frontend. No NestJS backend exists in this
repo (ADR 0004), so that specific mechanism doesn't apply — but this
codebase has its own real, unmitigated version of the same underlying
risk: type drift causing silent data corruption.

`grep`-ing `lib/core/data/entities/` for `int db[A-Z]` turns up 100+
ObjectBox entity fields of the shape `int dbStatus; // SomeEnum index`
(e.g. `PulseEventEntity.dbCategory`, `UnifiedTransactionEntity.dbSource`,
`SubscriptionTier` used for tier-weight comparisons). ObjectBox stores the
raw integer, not the enum name — `SomeEnum.values[dbStatus]` only
resolves correctly if the enum's *declaration order* on read exactly
matches whatever order it was in when that row was written. Reordering an
enum, inserting a new value anywhere but the end, or deleting a value all
silently reinterpret every already-stored row as the wrong value — no
compile error, no runtime exception, just wrong data. This is a real type-
safety hazard, just triggered by time (a future edit) instead of by a
second repository.

## Decision
Any enum referenced by an ObjectBox entity's `int db*` field is append-only
for the lifetime of that field: new values are always added at the end,
existing values are never reordered, renamed (renaming shifts nothing
numerically but breaks the `// SomeEnum index` doc-comment contract and
any code matching by name), or removed. If a value is genuinely retired,
leave it in place (optionally marked `@Deprecated`) rather than deleting
it, so existing indices stay valid.

New persisted enums — and the ones already identified as most
consequential — get an explicit ordering-pinned test
(`test/core/enum/persisted_enum_ordering_test.dart` asserts `.name` order
for `TransactionSource`, `PulseCategory`, `BusinessCategory`,
`ChatSticker`, and `SubscriptionTier`) so an accidental reorder fails a
test immediately instead of surfacing as a support ticket about wrong
data. This is the local equivalent of #180's "Build Safety: ...  build
must fail" AC, applied to this app's real drift risk.

## Consequences
- Only 5 of the 100+ persisted enums have a pinning test today — this is
  a pattern established, not exhaustive coverage. Extending it to more
  enums (or all of them) is straightforward, mechanical follow-up work,
  not a design problem.
- This convention has a real cost: an enum that genuinely needs
  reordering for readability, or a value that should logically be
  removed, can't be — the fix has to be additive (a new value at the
  end, deprecation, or a one-time data migration script), which is more
  work than a plain rename would be.
- This doesn't replace real ObjectBox migration tooling — it only
  protects the specific "enum backing an int index" case flagged here,
  not schema changes in general (renamed fields, changed types, etc.).
