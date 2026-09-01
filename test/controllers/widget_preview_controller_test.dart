import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';

class _InMemoryWidgetConfigStore implements WidgetConfigStore {
  Map<String, Map<String, bool>> saved = {};
  @override
  Future<Map<String, Map<String, bool>>?> load() async => saved;
  @override
  Future<void> save(Map<String, Map<String, bool>> values) async =>
      saved = values;
}

void main() {
  late _InMemoryWidgetConfigStore store;
  late WidgetConfigController config;
  late WidgetPreviewController preview;

  setUp(() {
    store = _InMemoryWidgetConfigStore();
    config = WidgetConfigController(store);
    preview = WidgetPreviewController(config);
  });

  test('valueFor falls back to the saved config value with nothing dirty',
      () async {
    await config.setValue('RADAR_CHART', 'showBenchmark', false);

    expect(preview.valueFor('RADAR_CHART', 'showBenchmark', true), false);
  });

  test('updatePreview is debounced then reflected by valueFor/isPreviewing',
      () async {
    preview.updatePreview('RADAR_CHART', 'showBenchmark', false);
    expect(preview.isPreviewing('RADAR_CHART'), false); // not yet settled

    await Future.delayed(const Duration(milliseconds: 200));

    expect(preview.isPreviewing('RADAR_CHART'), true);
    expect(preview.valueFor('RADAR_CHART', 'showBenchmark', true), false);
  });

  test('apply writes the dirty value to the config store and clears dirty',
      () async {
    preview.updatePreview('RADAR_CHART', 'showBenchmark', false);
    await Future.delayed(const Duration(milliseconds: 200));

    await preview.apply('RADAR_CHART');

    expect(store.saved['RADAR_CHART']?['showBenchmark'], false);
    expect(preview.isPreviewing('RADAR_CHART'), false);
  });

  test('discard reverts to the saved value without writing anything',
      () async {
    await config.setValue('RADAR_CHART', 'showBenchmark', true);
    preview.updatePreview('RADAR_CHART', 'showBenchmark', false);
    await Future.delayed(const Duration(milliseconds: 200));

    preview.discard('RADAR_CHART');

    expect(preview.isPreviewing('RADAR_CHART'), false);
    expect(preview.valueFor('RADAR_CHART', 'showBenchmark', true), true);
  });

  test('discardAll clears every widget\'s dirty preview', () async {
    preview.updatePreview('RADAR_CHART', 'showBenchmark', false);
    preview.updatePreview('OTHER_WIDGET', 'flag', false);
    await Future.delayed(const Duration(milliseconds: 200));

    preview.discardAll();

    expect(preview.isPreviewing('RADAR_CHART'), false);
    expect(preview.isPreviewing('OTHER_WIDGET'), false);
  });
}
