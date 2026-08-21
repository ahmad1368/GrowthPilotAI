import 'package:growth_pilot_ai/core/models/deep_link_route.dart';

/// Maps an incoming `growthpilotai://...` deep link to one of this
/// app's existing named GetX routes (Issue #176's "Deep Link Parser")
/// — reuses the same path strings as both the public link and the
/// internal `Get.toNamed` route name instead of a separate mapping
/// table kept in sync by hand (see PR notes).
class ParseDeepLinkUri {
  static const knownRoutes = {
    '/settings',
    '/settings/branding',
    '/settings/integrations',
    '/settings/connected-accounts',
    '/academy',
    '/ai-engine',
    '/inbox',
    '/business-compass',
    '/requirements/triage',
    '/requirements/dashboard',
    '/requirements/traceability',
    '/requirements/traceability/matrix',
    '/requirements/traceability/report-preview',
    '/requirements/traceability/export-history',
    '/transactions/duplicates',
  };

  /// Returns null for any path this app doesn't recognize (Issue
  /// #176 AC: "Graceful Failure") — the caller simply doesn't
  /// navigate rather than crash or show a broken screen.
  static DeepLinkRoute? call(Uri uri) {
    final path = uri.pathSegments.isEmpty ? '/' : '/${uri.pathSegments.join('/')}';
    if (!knownRoutes.contains(path)) return null;
    return DeepLinkRoute(routeName: path, queryParameters: uri.queryParameters);
  }
}
