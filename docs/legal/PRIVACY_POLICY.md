# Privacy Policy (DRAFT — not legally reviewed)

Issue #168 asks for a PIPEDA/BC-PIPA-compliant Privacy Policy. This is a
first draft written from a static audit of what the app actually does
today (see `docs/compliance/zero-cloud-ai-audit.md`), not aspirational
copy — **it has not been reviewed by a lawyer and must not be published
or relied on as final until it is.** A real Data Processing Agreement
with sub-processors and an active Privacy Officer contact email are
business/legal steps outside what this repository's code can produce.

The text actually shown in-app lives in
[`lib/core/legal/privacy_policy_text.dart`](../../lib/core/legal/privacy_policy_text.dart)
— this file exists so the policy has a reviewable, diffable home outside
the Dart source too. Keep both in sync; the Dart constant is what users
actually see.

## Current content

1. **Who this covers** — GrowthPilotAI, a local-first business
   back-office app for Canadian small businesses.
2. **What we collect** — transactions, invoices, receipts, chat
   messages, account settings you enter or scan into the app.
3. **Where it lives** — on-device, encrypted local storage (ADR 0001).
   No live backend exists in this version; nothing is uploaded by
   default. Plaid/Xero/QuickBooks connections are currently simulated
   for development and never transmit real banking credentials.
4. **Third-party processors** — none today (no Sentry/Firebase/analytics
   vendor is a dependency — verified, not assumed). This section gets
   filled in the moment any such vendor is actually added.
5. **User control** — in-app "Delete Account" (Settings > Account)
   wipes all local data immediately.
6. **Consent** — accepted policy version, date, and data-sharing choice
   are logged locally for re-acceptance-on-change.
7. **Jurisdiction** — targets PIPEDA/BC PIPA alignment; the compliance
   *guarantee* language needs real legal sign-off before publication.
8. **Contact** — placeholder; needs a real, monitored privacy contact
   address before this is publishable.

## Explicitly not attempted here (needs a human, not code)

- Legal review and sign-off by qualified counsel.
- A real Data Processing Agreement with any sub-processor.
- Provisioning and monitoring a real `privacy@` contact address.
- Any claim that infrastructure (AWS, MongoDB Atlas, Sentry) exists,
  since none of it does in this repository yet — update this policy
  *when* real infrastructure is added, not before.
