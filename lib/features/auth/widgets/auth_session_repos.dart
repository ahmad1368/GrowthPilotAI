import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/auth_session_repository.dart';

/// Bundles the repository the session-lifecycle demo needs (Issue
/// #120).
class AuthSessionRepos {
  final store = Get.find<ObjectBox>().store;
  late final sessions = AuthSessionRepository(store.box<AuthSessionEntity>());
}
