import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/merge_widget_preview.dart';

void main() {
  test('adds a new widget entry when none exists yet', () {
    final result = MergeWidgetPreview.call({}, 'RADAR_CHART', 'showBenchmark', false);

    expect(result, {
      'RADAR_CHART': {'showBenchmark': false}
    });
  });

  test('merges into an existing widget entry without dropping other keys', () {
    final result = MergeWidgetPreview.call(
      {
        'RADAR_CHART': {'otherKey': true}
      },
      'RADAR_CHART',
      'showBenchmark',
      false,
    );

    expect(result['RADAR_CHART'], {'otherKey': true, 'showBenchmark': false});
  });

  test('does not mutate the input map', () {
    final input = {
      'RADAR_CHART': {'showBenchmark': true}
    };

    MergeWidgetPreview.call(input, 'RADAR_CHART', 'showBenchmark', false);

    expect(input['RADAR_CHART']!['showBenchmark'], true);
  });
}
