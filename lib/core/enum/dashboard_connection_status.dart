/// Connection state shown per provider on the Integrations Dashboard
/// (Issue #61). Richer than [IntegrationStatus] (connected/disconnected)
/// because the dashboard also needs "not yet connected" and "in progress"
/// states for its status chip.
enum DashboardConnectionStatus { notConnected, connected, expired, syncing }
