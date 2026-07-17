import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

class _SpyChannel implements NotificationChannel {
  bool online;
  int inAppCalls = 0;
  String? lastPushPreview;

  _SpyChannel({this.online = true});

  @override
  OmniResult<bool> isUserOnline() async => OmniResponse.success(online);

  @override
  OmniResult<void> emitInApp(InboxNotificationEntity notification) async {
    inAppCalls++;
    return OmniResponse.success(null);
  }

  @override
  OmniResult<void> sendPush(
      InboxNotificationEntity notification, String previewBody) async {
    lastPushPreview = previewBody;
    return OmniResponse.success(null);
  }
}

InboxNotificationEntity _notification({
  NotificationPriority priority = NotificationPriority.normal,
  String body = 'hello',
}) =>
    InboxNotificationEntity(
      title: 't',
      body: body,
      dbPriority: priority.index,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('online delivery emits in-app and skips push', () async {
    final channel = _SpyChannel(online: true);
    final result = await DispatchNotificationUseCase(channel)
        .dispatch(_notification(), []);

    expect(result, isNotNull);
    expect(channel.inAppCalls, 1);
    expect(channel.lastPushPreview, isNull);
    expect(result!.deliveredViaPush, isFalse);
  });

  test('offline delivery sends a masked push preview', () async {
    final channel = _SpyChannel(online: false);
    final result = await DispatchNotificationUseCase(channel).dispatch(
        _notification(body: 'Charge of \$100.00 detected'), []);

    expect(result!.deliveredViaPush, isTrue);
    expect(channel.lastPushPreview!.contains('\$'), isFalse);
  });

  test('a throttled alert is never sent to the channel', () async {
    final channel = _SpyChannel(online: true);
    final history = List.generate(
        5,
        (_) => InboxNotificationEntity(
            title: 't', body: 'b', createdAt: DateTime.now()));

    final result = await DispatchNotificationUseCase(channel)
        .dispatch(_notification(), history);

    expect(result, isNull);
    expect(channel.inAppCalls, 0);
  });
}
