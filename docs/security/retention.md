# Data Retention Schedule (Issue #94)

| Data class | Store | Retention | Enforcement |
|---|---|---|---|
| Anonymized shadow records (`AnonymizedListingEntity`, #93) | Local ObjectBox analytics box | 1 year from `recordedAt` (`ComputeAnalyticsRetentionExpiry`) | `PurgeExpiredAnalyticsRecords`, invoked manually/at app start — no cron exists client-side |
| Raw user data (KYC docs, memberships, sessions, etc.) | Local ObjectBox, spread across many entities | Not yet policy-defined | Out of scope for this PR — see below |

## Right to be Forgotten

`PurgeUserAnalyticsData` deletes a user's shadow records from the
analytics store by hashed id. This is the shadow-record half of the
"Right to be Forgotten" AC only — this app has no single raw/production
data store equivalent to purge from (unlike the issue's SQL+MongoDB
split), so a full cross-cutting purge across every entity holding a
user's raw data is left for a dedicated future issue.

## Known limitation

There is no scheduler in this client-only app — `PurgeExpiredAnalyticsRecords`
must be triggered by something in the app itself (e.g. on launch) rather
than running unattended like the issue's NestJS `@Cron` job. A real
deployment with a backend should run the purge server-side on a schedule.
