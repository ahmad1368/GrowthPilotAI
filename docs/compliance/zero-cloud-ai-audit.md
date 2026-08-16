# Zero-Cloud AI Verification Audit (Issue #202)

## Methodology

This is a **static code audit**, not a live network capture. The issue's
own tooling (Proxyman/Charles Proxy sniffing, physical Airplane Mode
testing) needs a real device and a running app — outside what this
pipeline can do (no emulator/device access here; see `/emulator-qa` for
that). Everything below is either a grep-verified fact about the source
tree, or explicitly marked as **not performed / needs manual QA**.

Scope: every file built for the on-device AI pipeline across #196-#210
— `lib/features/ai_chat/`, `lib/features/ai_engine/`, all
`ai_*`/`embedding_*`/`prompt_click_*`/`quick_prompts*` controllers and
business rules, and their ObjectBox entities/repositories.

## Findings

### 1. Network Traffic Analysis — ✅ verified statically, ⚠️ live sniff not performed

Grepped every file in the audit scope for `package:http`, `package:dio`,
`HttpClient`, `WebSocket`, and any `Uri.parse(...http...)` call: **zero
matches**. Nothing in the AI pipeline holds a network client or ever
constructs an outbound request — consistent with every #196-#210 PR's
own disclosure that no real inference engine, embedding model, or
backend is integrated yet (`MockEmbeddingService`, the stub chat reply,
etc.). `ConnectivityService.isOnline` is read in one place
(`RecordAiFeedback`, to tag a feedback event `is_offline`) but is never
used to gate whether `AiChatController.sendMessage` can run — so the
chat is structurally unable to require a network connection today.

**Not performed**: an actual Proxyman/Charles Proxy capture during a
live session, and a physical Airplane Mode test on a device. Both ACs
should be re-verified once real inference/embedding/RAG network calls
(if any are ever added) exist to sniff — right now there is nothing to
capture.

### 2. Sandbox Data Leakage Audit

**Storage encryption — ⚠️ finding, not fixed.** `ObjectBoxProvider`
(`lib/core/data/objectbox_provider.dart`) opens the store under
`getApplicationDocumentsDirectory()`, not `getApplicationSupportDirectory()`
as the issue's AC asks for. On Android both map to the same app-private,
OS-encrypted internal storage, so there's no practical difference. On
iOS, Documents is included in iTunes/iCloud device backups by default
(Application Support is not) — a real distinction; this is not currently
excluded from backup either. **Not fixed in this PR**: `ObjectBox` is the
single store for all ~130 entities in this app, not just the AI pipeline
— switching the directory would orphan every existing user's local data
(transactions, invoices, everything) on their next app launch with no
migration path. This needs its own dedicated, carefully-planned issue
(migrate-and-verify, not just flip the path), not a change bundled into
an audit PR.

**RAM zeroing — not implementable as specified.** Dart/Flutter is
garbage-collected; there is no API to explicitly zero a memory region on
either the Dart VM or the standard platform channels. The issue's
"immediately after the AI response is rendered" wording maps most
closely to #197's `InferenceEngineLifecycleController.unloadIfStale()`,
which already drops the engine's in-memory state reference after
inactivity — but that's disposal-on-idle, not the deterministic
zero-and-overwrite the AC describes, and there's no real inference
engine yet whose memory would even need clearing. Documented as a known
limitation rather than attempted.

### 3. Log Sanitization — ✅ trivially satisfied

No Crashlytics, Sentry, or Firebase package of any kind is a dependency
in `pubspec.yaml` (grepped, zero matches) — consistent with every
#209/#210 PR's own note that no Firebase Analytics exists in this repo.
There is no crash-reporting pipeline configured at all, so there is
nothing for user strings or financial values to leak through.

## Acceptance Criteria status

| AC | Status |
|---|---|
| AI Chat functions with Wi-Fi/Cellular off | Structurally true (no network call exists to fail) — not device-tested |
| Network logs show 0 bytes during 10 AI queries | Not measured (no traffic capture tool available here) — statically, there is nothing to transmit |
| Models/vector indexes reside in the encrypted sandbox | Partially: Android yes; iOS uses Documents not Application Support — see Finding 2 |
| Privacy Audit Report generated in `/docs/compliance` | ✅ this file |
| Privacy Policy (#168) updated with the on-device statement | Blocked — no Privacy Policy screen/document exists yet in this codebase; add the statement once #168 ships |

## Follow-ups

- Manual: run a real Proxyman/Charles capture and a physical Airplane
  Mode test once any real network-touching AI component exists.
- A dedicated issue to migrate ObjectBox from Documents to Application
  Support (iOS) with a real data-migration path, not a silent path swap.
- Add the required on-device-processing statement to the Privacy Policy
  once Issue #168 exists.
