/// "Deep-Linking" AC (Issue #137): resolves a dispatched notification's
/// metadata into a navigable target. Execution (actually pushing a
/// route) is deferred until chat has a registered app route — see the
/// [ChatRoomView] "not yet wired into navigation" note.
typedef NotificationDeepLink = ({String routeName, Map<String, String> args});

class ResolveNotificationDeepLink {
  static NotificationDeepLink? call(String? metadataRefType, String? metadataRefId) {
    if (metadataRefType == 'ChatRoom' && metadataRefId != null) {
      return (routeName: '/chat', args: {'roomId': metadataRefId});
    }
    return null;
  }
}
