import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/check_module_route_access.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';

/// Blocks navigation into a route whose module has been disabled via
/// the Modular Feature Toggle Engine (Issue #339, acceptance criterion
/// 3). Attach to a [GetPage]'s `middlewares` to gate it; toggle state is
/// re-read from ObjectBox on every navigation, so a change made in the
/// admin panel takes effect on the very next attempt to enter the route.
class ModuleAccessMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final toggles =
        Get.find<ObjectBox>().store.box<FeatureModuleToggleEntity>().getAll();
    final allowed = CheckModuleRouteAccess.call(toggles, route);
    return allowed ? null : const RouteSettings(name: '/');
  }
}
