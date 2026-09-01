import 'package:growth_pilot_ai/core/enum/realtime_namespace.dart';

/// Contract for the shared realtime gateway backbone (Issue #130). A real
/// backend would be a NestJS `AppGateway` with a Redis pub/sub adapter
/// tracking "Online" status across server instances; this app has none,
/// so a single in-process registry tracks presence for every namespace
/// (chat, market, notifications) that plugs into it.
abstract class RealtimeConnectionRegistry {
  void connect(String userId, RealtimeNamespace namespace);

  void disconnect(String userId, RealtimeNamespace namespace);

  bool isOnline(String userId);

  Stream<String> get presenceChanges;
}
