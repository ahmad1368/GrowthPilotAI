/// A "High-Sensitivity" action tracked by the security audit trail
/// (Issue #186). Geo-anomaly detection and Plaid-token-access logging
/// from the issue's own list are omitted — this app has no IP/geo
/// signal to observe and no real Plaid token is ever stored (confirmed
/// in #185's audit), so there is nothing genuine to log for either.
enum SecurityAuditActionType {
  loginSuccess,
  loginFailure,
  accountLockout,
  passwordChange,
  twoFactorEnabled,
  twoFactorDisabled,
  emailUpdate,
  dataExport,
  roleChange,
}
