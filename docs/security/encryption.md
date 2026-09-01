# Encryption-at-rest & in-transit audit (Issue #185)

A static code audit (grep-based, same methodology as #202's audit — no
live network-sniffing tools like Proxyman/Charles Proxy are available in
this pipeline) of this repo's current encryption posture, run alongside
#262's field-encryption work.

## Encryption-at-rest: findings

- **Field-level AES-256 already exists.** `lib/core/utils/field_cipher.dart`
  (`FieldCipher`, from #106/#428) encrypts individual string fields with a
  key stored via `SecureStorageService` (the OS secure enclave), never in
  the ObjectBox database itself. #262 scoped this to transaction fields
  (`TransactionFieldCipher`).
- **No plaintext banking/accounting tokens are stored anywhere in this
  app.** Audited `IntegrationConnectionEntity` (#61) and
  `LinkedAccountEntity` (#68) — neither has an `accessToken`/
  `refreshToken` field. `MockBankLinkService` (#68) is a mock: it never
  persists a real Plaid `access_token`, and its own doc comments already
  state tokens "must never be logged in plain text." There is currently
  no `plaid_access_token`/`quickbooks_refresh_token`-equivalent field to
  encrypt.
- **ObjectBox itself has no native encryption-at-rest** in the
  Community/free edition this app uses (documented previously in
  `db_status_panel.dart`) — this is why `FieldCipher` exists as an
  application-level workaround rather than relying on database-level
  encryption.

## Encryption-in-transit: findings

- **This repo has no real network client.** Grepping the whole `lib/`
  tree for `Dio(`, `http.Client(`, and `HttpClient(` returns zero
  matches, and no literal `http://` URL appears anywhere in `lib/`. Every
  backend interaction in this app (Plaid, QuickBooks/Xero, AI inference,
  etc.) is a local mock/stub — a recurring, already-disclosed pattern
  across this codebase. There is therefore no TLS configuration to audit
  yet, because there is no outbound connection to configure.
- Added `IsUrlSecure` (`lib/business/is_url_secure.dart`) as a guard the
  first real network client can use to reject a non-`https://` endpoint
  at construction time, rather than leaving that check to be remembered
  later.

## Out of scope — this repo has no backend or cloud infrastructure

The issue's technical requirements are almost entirely a NestJS/MongoDB
Atlas/AWS-KMS system this repo does not have:

- TLS 1.3 enforcement, HSTS, and cipher-suite hardening on a load
  balancer (Nginx/AWS ELB) — no load balancer or backend server exists
  in this repo.
- SSL Labs A+ scoring of an API endpoint — there is no deployed API to
  score.
- MongoDB Atlas storage encryption — this app uses ObjectBox locally,
  not MongoDB.
- AWS KMS / Google Cloud KMS-managed key rotation every 90 days — no
  cloud KMS integration exists; `SecureStorageService` uses the device's
  own OS-level secure storage, which has no equivalent "90-day rotation"
  API to call.
- SSL/TLS certificate issuance and auto-renewal (Let's Encrypt/ACM) — no
  server-side certificate to manage.
- Certificate pinning in the Flutter app — evaluated as a future
  hardening step *once* a real network client exists to pin against;
  premature to add today.
- KMS audit logging for unauthorized decryption attempts, separation of
  duties between app and KMS administrators — both presuppose a KMS that
  does not exist here.
