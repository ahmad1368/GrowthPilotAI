import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_realtime_connection_registry.dart';
import 'package:growth_pilot_ai/core/enum/realtime_namespace.dart';

void main() {
  test('user is online after connecting to one namespace', () {
    final registry = MockRealtimeConnectionRegistry();
    registry.connect('u1', RealtimeNamespace.chat);
    expect(registry.isOnline('u1'), isTrue);
  });

  test('stays online while connected to another namespace', () {
    final registry = MockRealtimeConnectionRegistry();
    registry.connect('u1', RealtimeNamespace.chat);
    registry.connect('u1', RealtimeNamespace.market);
    registry.disconnect('u1', RealtimeNamespace.chat);
    expect(registry.isOnline('u1'), isTrue);
  });

  test('goes offline only once every namespace disconnects', () {
    final registry = MockRealtimeConnectionRegistry();
    registry.connect('u1', RealtimeNamespace.chat);
    registry.disconnect('u1', RealtimeNamespace.chat);
    expect(registry.isOnline('u1'), isFalse);
  });

  test('presenceChanges only fires on an actual online/offline flip', () async {
    final registry = MockRealtimeConnectionRegistry();
    final events = <String>[];
    registry.presenceChanges.listen(events.add);

    registry.connect('u1', RealtimeNamespace.chat);
    registry.connect('u1', RealtimeNamespace.market); // already online, no new event
    registry.disconnect('u1', RealtimeNamespace.market); // still online via chat
    registry.disconnect('u1', RealtimeNamespace.chat); // now offline

    await Future<void>.delayed(Duration.zero);
    expect(events, ['u1', 'u1']);
  });
}
