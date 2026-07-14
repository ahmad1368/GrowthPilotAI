/// Connection health of an accounting integration, as tracked client-side.
/// Tokens themselves never reach the client (see [AccountingIntegration]);
/// this only reflects whether the last known refresh attempt succeeded.
enum IntegrationStatus { connected, disconnected }

extension IntegrationStatusInfo on IntegrationStatus {
  /// Whether the UI should surface a "Fix Connection" call to action.
  bool get needsReconnect => this == IntegrationStatus.disconnected;
}
