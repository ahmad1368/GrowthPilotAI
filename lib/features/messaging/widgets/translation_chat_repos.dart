import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_message_repository.dart';

/// Bundles the repository the on-device translation chat demo needs
/// (Issue #430).
class TranslationChatRepos {
  final store = Get.find<ObjectBox>().store;
  late final messages = ChatMessageRepository(store.box<ChatMessageEntity>());
}
