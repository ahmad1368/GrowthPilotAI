import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/widgets/grid_layout_service.dart';

void main() {
  test('radar-style widgets take the full row', () {
    expect(GridLayoutService.getCrossAxisCellCount('RADAR_CHART', 4), 4);
    expect(
        GridLayoutService.getCrossAxisCellCount('MAPPED_RADAR_CHART', 2), 2);
  });

  test('other widgets take half the row so two fit side by side', () {
    expect(GridLayoutService.getCrossAxisCellCount('METRIC_LEGEND', 4), 2);
    expect(GridLayoutService.getCrossAxisCellCount('INSIGHT_TEXT', 2), 1);
  });

  test('an unknown widget id falls back to half-width, not full', () {
    expect(GridLayoutService.getCrossAxisCellCount('SOME_NEW_ID', 4), 2);
  });
}
