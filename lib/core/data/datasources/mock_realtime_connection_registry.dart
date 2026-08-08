import 'dart:async';

import 'package:growth_pilot_ai/core/enum/realtime_namespace.dart';
import 'package:growth_pilot_ai/core/interfaces/realtime_connection_registry.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// In-process presence tracker (Issue #130) — a user is "online" while
/// connected to at least one namespace, mirroring what a real Redis-backed
/// gateway would compute across sockets. Only emits on [presenceChanges]
/// when the overall online/offline state actually flips, not on every
/// individual namespace connect/disconnect.
class MockRealtimeConnectionRegistry implements RealtimeConnectionRegistry {
  final Map<String, Set<RealtimeNamespace>> _connections = {};
  final _controller = StreamController<String>.broadcast();

  @override
  void connect(String userId, RealtimeNamespace namespace) {
    final wasOnline = isOnline(userId);
    _connections.putIfAbsent(userId, () => {}).add(namespace);
    if (!wasOnline) {
      OmniLogger.info('Gateway: $userId online (${namespace.name})');
      _controller.add(userId);
    }
  }

  @override
  void disconnect(String userId, RealtimeNamespace namespace) {
    final wasOnline = isOnline(userId);
    _connections[userId]?.remove(namespace);
    if (wasOnline && !isOnline(userId)) {
      OmniLogger.info('Gateway: $userId offline');
      _controller.add(userId);
    }
  }

  @override
  bool isOnline(String userId) => _connections[userId]?.isNotEmpty ?? false;

  @override
  Stream<String> get presenceChanges => _controller.stream;
}
