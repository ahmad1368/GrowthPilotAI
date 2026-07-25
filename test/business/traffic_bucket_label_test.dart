import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/traffic_bucket_label.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';

void main() {
  test('formats hours with AM/PM and no leading zero', () {
    expect(TrafficBucketLabel.call(0, TrafficView.byHour), '12AM');
    expect(TrafficBucketLabel.call(9, TrafficView.byHour), '9AM');
    expect(TrafficBucketLabel.call(12, TrafficView.byHour), '12PM');
    expect(TrafficBucketLabel.call(14, TrafficView.byHour), '2PM');
    expect(TrafficBucketLabel.call(23, TrafficView.byHour), '11PM');
  });

  test('formats weekdays as 3-letter abbreviations, Monday-first', () {
    expect(TrafficBucketLabel.call(0, TrafficView.byDayOfWeek), 'Mon');
    expect(TrafficBucketLabel.call(6, TrafficView.byDayOfWeek), 'Sun');
  });
}
