import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/navigation/controllers/navigation_controller.dart';

void main() {
  test(
      'NavigationController updates index correctly when not matching ocr workflow',
      () {
    final controller = NavigationController();

    expect(controller.currentIndex.value, 0);
    controller.handleNavigation(1);
    expect(controller.currentIndex.value, 1);

    controller.handleNavigation(3);
    expect(controller.currentIndex.value, 3);
  });
}
