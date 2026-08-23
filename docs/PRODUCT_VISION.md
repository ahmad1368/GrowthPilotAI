# GrowthPilotAI — Mission, Vision & Product Goals

## 1. Mission

GrowthPilotAI exists to give small and mid-sized Canadian businesses an
AI-assisted, offline-first back office — one app that reconciles bank and
accounting data, protects sensitive financial records on-device, and
surfaces insight without requiring a full-time bookkeeper or a permanent
cloud connection.

Most SMB finance tools assume constant connectivity and centralize raw
transaction data in the vendor's cloud. GrowthPilotAI takes the opposite
default: business data is processed and stored locally first (ObjectBox +
on-device encryption), and cloud/AI services are opt-in enhancements rather
than a hard dependency.

**Target audience:** small business owners, bookkeepers, and B2B teams in
Canada who need bank-to-accounting reconciliation, receipt/document capture,
and compliance-aware data handling (PIPA/PIPEDA) without adopting a heavy
enterprise ERP.

## 2. Product Vision

GrowthPilotAI is becoming a local-first, AI-augmented financial operations
hub for small business:

- **Financial connectivity** — bank aggregation (Plaid) and accounting
  platform sync (Xero, QuickBooks Online) via OAuth, with client-side
  transaction fetch, normalization, and conflict resolution.
- **Automated accounting** — transaction-to-chart-of-accounts mapping using
  user-defined rules and fuzzy matching, reducing manual categorization.
- **Document intelligence** — OCR/document scanning and classification for
  receipts and invoices, feeding structured data back into the transaction
  pipeline.
- **Trust and compliance by default** — field-level encryption, retention
  policies, soft-delete, data anonymization, and residency configuration
  built into the data layer rather than bolted on.
- **Insight, not just storage** — an on-device AI assistant and analytics
  layer that turn reconciled transaction data into actionable business
  insight, without a round-trip to a third-party AI vendor.
- **Business communication** — a local, end-to-end-encrypted chat surface
  (buyer/vendor negotiation, 2FA, self-destructing messages) so growth
  conversations happen in the same app as the financial data they reference.

> **Scope note (Aug 2026):** the open-issue backlog also contains a large,
> independently-generated set of "merchant marketplace admin/ads" and
> "software requirements-traceability" feature epics (100+ issues each) that
> were implemented as local simulations over time but were never explicitly
> scoped against this vision document. They are real, working code — see
> §4 — but a maintainer should decide whether they're a second product line,
> a pivot, or backlog to prune, rather than assuming they're mission-aligned
> by default. This is exactly the kind of ambiguity this document exists to
> resolve going forward (§ Motivation in Issue #306).

## 3. Core Objectives

- Reduce the manual effort of reconciling bank transactions against
  accounting records.
- Keep sensitive financial data under the user's control by defaulting to
  local storage and encryption.
- Make integrations (Plaid, Xero, QuickBooks) resilient — token refresh,
  multi-tenant support, and safe offline fallback are first-class, not
  edge cases.
- Turn captured documents (receipts, invoices) into structured, mapped
  transactions with minimal manual entry.
- Ship every feature as an isolated, independently testable unit so the
  backlog can be worked issue-by-issue without destabilizing the app.

## 4. Key Features

**Implemented today** (see `lib/business/`, `lib/features/`):

*Financial core*
- Bank-link abstraction (Plaid, Canada-first) and incremental transaction
  fetch with category normalization.
- Accounting OAuth for Xero (PKCE + multi-tenant) and QuickBooks Online,
  with token lifecycle heartbeat and refresh-status tracking.
- Source-agnostic `UnifiedTransaction` model bridging bank and accounting
  data.
- Transaction-to-accounting mapper: user rule matching + fuzzy chart-of-
  accounts matching.
- Client-side multi-tenant model (Business/Membership) with data isolation.
- Backup scheduling, restore integrity checks, and point-in-time selection.
- Document scanning, OCR, and document classification pipeline
  (`lib/features/scanner`, `document_classification`, `classifier`,
  `detector`).
- Inventory tracking with low-stock automation.

*Trust & compliance*
- Soft-delete + 30-day retention, anonymization pipeline, input
  validation/sanitization, data-residency (PIPA) configuration,
  Last-Write-Wins conflict resolution.
- Account-level TOTP two-factor authentication, offline audit logging,
  and a System Health diagnostics panel.

*AI & insight*
- On-device AI assistant / chat engine (RAG over local business data —
  no third-party AI vendor round-trip required).
- Analytics/insight dashboards (`lib/features/analytics`, `insight_page.dart`)
  covering revenue, retention, and business KPIs.

*Communication*
- Business chat with Signal-style Safety Number E2EE verification, TOTP
  2FA, self-destructing/silent messages, edit/delete/pin, scheduled sends,
  per-room themes, and a sticker/emoji catalog.
- In-app support chat, notification/inbox system, and a beta-feedback
  channel with daily rate limiting.

*Exploratory (see scope note above — not yet vetted against this Mission)*
- A merchant marketplace admin surface (KYC approval queues, merchant
  trust scoring, geofencing, ad campaigns/commission engines).
- A software requirements-traceability/KPI dashboard suite.

**Planned** (tracked as open GitHub issues): richer reporting/export,
deeper accounting-platform coverage, and broader security-audit tooling.

## 5. Target Users

- Small business owners managing their own books.
- Bookkeepers and accountants serving multiple small-business clients.
- B2B teams needing reconciled, exportable financial data for accounting
  handoff.

## 6. Product Principles

- **Local-first**: on-device storage (ObjectBox) and processing are the
  default; cloud/AI services are additive, not required.
- **Secure by design**: encryption, retention policy, and data isolation
  are part of the data layer, not an afterthought.
- **Modular, SRP architecture**: interfaces → business/usecases →
  controllers → models, each unit small and independently testable
  (see `CLAUDE.md` / architecture skill for the enforced structure).
- **Resilient integrations**: every external connection (bank, accounting)
  assumes token expiry, partial failure, and offline operation.
- **Cross-platform**: the same codebase targets mobile and web (Flutter),
  so platform-only APIs are guarded and degrade gracefully on web.

## 7. Long-Term Roadmap

1. **Foundation** — *delivered* — bank/accounting connectivity, transaction
   sync, mapping engine, data protection primitives, document capture.
2. **Core AI Features** — *delivered* — on-device inference, AI chat
   assistant, analytics/insight dashboards grounded in reconciled
   transaction data.
3. **Business Automation** — *in progress* — inventory low-stock automation
   and audit logging shipped; smarter categorization, anomaly detection,
   and scheduled reporting/export still open.
4. **Integrations** — deeper accounting/payment platform coverage,
   webhook-driven sync. *(not started)*
5. **Enterprise / Team Features** — multi-user organizations, RBAC,
   white-labeling. *(not started; audit logging already delivered under
   Trust & Compliance, §4)*
6. **Scope consolidation** — decide the fate of the exploratory marketplace-
   admin and requirements-traceability surfaces (§4): fold them into a
   formal roadmap phase, or prune them from the backlog. This should happen
   before either surface grows further.

This document is descriptive of the current codebase and directional for
the backlog — it should be updated as major capabilities land, and new
feature issues should reference the relevant section here when proposing
scope.
