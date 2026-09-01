import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/debouncer.dart';

void main() {
  test('runs the callback once after the configured delay', () async {
    final debouncer = Debouncer(const Duration(milliseconds: 20));
    var calls = 0;

    debouncer.run(() => calls++);
    expect(calls, 0); // hasn't fired yet

    await Future.delayed(const Duration(milliseconds: 40));
    expect(calls, 1);
  });

  test('collapses rapid-fire calls into a single run', () async {
    final debouncer = Debouncer(const Duration(milliseconds: 20));
    var calls = 0;

    debouncer.run(() => calls++);
    debouncer.run(() => calls++);
    debouncer.run(() => calls++);

    await Future.delayed(const Duration(milliseconds: 40));
    expect(calls, 1);
  });

  test('dispose cancels a pending run', () async {
    final debouncer = Debouncer(const Duration(milliseconds: 20));
    var calls = 0;

    debouncer.run(() => calls++);
    debouncer.dispose();

    await Future.delayed(const Duration(milliseconds: 40));
    expect(calls, 0);
  });
}
