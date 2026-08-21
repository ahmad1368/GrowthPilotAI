import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/parse_deep_link_uri.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Listens for incoming `growthpilotai://...` deep links (Issue
/// #176's "Intelligent Handler") and routes them through the app's
/// existing named GetX routes via [ParseDeepLinkUri]. Native-only —
/// on Web, GetX's own browser-URL routing already owns navigation,
/// and a custom (non-`https`) scheme has no meaning there anyway
/// (see PR notes).
class DeepLinkController extends GetxController {
  final _appLinks = AppLinks();

  @override
  void onInit() {
    super.onInit();
    if (kIsWeb) return;
    _handleInitialLink();
    _appLinks.uriLinkStream.listen(_route, onError: _logError);
  }

  Future<void> _handleInitialLink() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) _route(uri);
    } catch (e, stack) {
      _logError(e, stack);
    }
  }

  void _route(Uri uri) {
    final route = ParseDeepLinkUri.call(uri);
    if (route == null) return;
    Get.toNamed(route.routeName, parameters: route.queryParameters);
  }

  void _logError(Object error, [StackTrace? stack]) {
    OmniLogger.error(
      title: 'Deep link handling failed',
      widgetName: 'DeepLinkController',
      message: error,
      stackTrace: stack ?? StackTrace.current,
    );
  }
}
