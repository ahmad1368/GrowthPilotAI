/// Draft Privacy Policy shown via [LegalDocumentScreen] and required
/// during onboarding (Issue #168/#215). **This is a draft written from a
/// static audit of what the app actually does today — it has not been
/// reviewed by a lawyer and must not be treated as final until it is.**
/// Deliberately does not claim things this app doesn't do yet (a live
/// backend, real Plaid/Sentry integration) — see docs/legal/PRIVACY_POLICY.md
/// for the source-of-truth copy and its own draft notice.
const privacyPolicyText = '''
DRAFT — NOT LEGALLY REVIEWED. Do not publish as final without review by
qualified counsel. See docs/legal/PRIVACY_POLICY.md for change history.

1. Who this covers
This policy covers GrowthPilotAI, a local-first business back-office app
for Canadian small businesses.

2. What data we collect
Business and financial information you enter or scan into the app:
transactions, invoices, receipts, chat messages, and account settings.

3. Where your data lives
GrowthPilotAI is local-first: your data is stored on your device using
an encrypted on-device database. As of this version, there is no live
backend server — nothing you enter is uploaded to us or to any cloud
service by default. Bank and accounting-platform connections (Plaid,
Xero, QuickBooks Online) are currently simulated for development and do
not transmit real banking credentials anywhere.

4. Third-party processors
We do not currently use Sentry, Firebase, or any crash-reporting or
analytics vendor. If any such service is added in the future, this
policy will be updated first, and this section will name the vendor,
what it receives, and why.

5. Your control over your data
You can permanently delete all local app data at any time from
Settings > Account > Delete Account. This immediately erases your data
from this device. Because nothing is stored on a server, there is no
separate server-side deletion step required today.

6. Consent
We log the version of this policy you accepted, the date, and your
choice regarding anonymized data sharing, so we can show you a
re-acceptance prompt whenever this policy materially changes.

7. Jurisdiction
This app is designed for Canadian small businesses and aims to align
with PIPEDA and British Columbia's PIPA. This section requires legal
sign-off before this can be stated as a compliance guarantee.

8. Contact
Privacy questions: [PRIVACY CONTACT EMAIL — not yet configured].
''';
