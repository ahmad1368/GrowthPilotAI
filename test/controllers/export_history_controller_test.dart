import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/export_history_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';

class _FakeExportEventRepository implements ExportEventRepository {
  final rows = <ExportEventEntity>[];

  @override
  void append(ExportEventEntity event) => rows.add(event);

  @override
  List<ExportEventEntity> getAll() => rows;
}

void main() {
  group('ExportHistoryController', () {
    test('refreshEvents loads events from the repository', () {
      final repo = _FakeExportEventRepository()
        ..rows.add(ExportEventEntity(format: 'pdf', filename: 'a.pdf', occurredAt: DateTime.now()));
      final controller = ExportHistoryController(repo);

      controller.refreshEvents();

      expect(controller.events.length, 1);
    });

    test('treats an event with no captured bytes as expired', () {
      final controller = ExportHistoryController(_FakeExportEventRepository());
      final event = ExportEventEntity(format: 'pdf', filename: 'a.pdf', occurredAt: DateTime.now());

      expect(controller.isExpired(event), isTrue);
    });

    test('treats a recent event with bytes as not expired', () {
      final controller = ExportHistoryController(_FakeExportEventRepository());
      final event = ExportEventEntity(
        format: 'pdf',
        filename: 'a.pdf',
        fileBytes: Uint8List.fromList([1, 2, 3]),
        occurredAt: DateTime.now(),
      );

      expect(controller.isExpired(event), isFalse);
    });

    test('treats an event older than 48h as expired even with bytes', () {
      final controller = ExportHistoryController(_FakeExportEventRepository());
      final event = ExportEventEntity(
        format: 'pdf',
        filename: 'a.pdf',
        fileBytes: Uint8List.fromList([1, 2, 3]),
        occurredAt: DateTime.now().subtract(const Duration(hours: 49)),
      );

      expect(controller.isExpired(event), isTrue);
    });

    test('reshare is a no-op for an expired event (no bytes to share)', () async {
      final controller = ExportHistoryController(_FakeExportEventRepository());
      final event = ExportEventEntity(format: 'pdf', filename: 'a.pdf', occurredAt: DateTime.now());

      await controller.reshare(event);
    });
  });
}
