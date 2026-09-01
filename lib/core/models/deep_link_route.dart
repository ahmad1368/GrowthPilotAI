/// A resolved deep link target (Issue #176) — [routeName] is one of
/// this app's existing `Get.toNamed` route names, [queryParameters]
/// preserves the incoming URL's query string (AC: "Clicking a link
/// with a query like ?from=promo carries that parameter into the
/// Flutter app").
class DeepLinkRoute {
  final String routeName;
  final Map<String, String> queryParameters;

  const DeepLinkRoute({required this.routeName, required this.queryParameters});
}
