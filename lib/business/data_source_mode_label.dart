/// Human-readable label for the Environment-Aware Data Source Switcher
/// (Issue #264/#265): shared between the settings toggle and the app-bar
/// status dot so both read the same wording.
class DataSourceModeLabel {
  static String call(bool isRemoteEnabled) => isRemoteEnabled ? 'Remote Mode' : 'Local Mode';
}
