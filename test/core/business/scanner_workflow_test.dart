import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/business/scanner_workflow.dart';

void main() {
  test('ScannerWorkflow lifecycle states initialization and tracking', () {
    final workflow = ScannerWorkflow();
    expect(workflow.currentStepId.value, 'picking');
    expect(workflow.subProgress.value, 0.0);
    workflow.dispose();
  });
}
