/// [Issue #786] Fixed local demo account for the login gate. This app has
/// no backend — there is nothing to authenticate against remotely — so
/// this is a UI access gate, not a real multi-user auth system. Replace
/// entirely (don't extend) if real remote authentication is ever added.
class DemoCredentials {
  static const email = 'demo@growthpilot.ai';
  static const password = 'GrowthPilot@2026';
}
