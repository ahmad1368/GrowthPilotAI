import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/capture_boundary_image.dart';

void main() {
  testWidgets('captures a RepaintBoundary subtree as PNG bytes',
      (tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(width: 40, height: 40, color: Colors.blue),
        ),
      ),
    ));

    // toImage()'s GPU rasterization needs a real async gap, which the fake
    // test zone otherwise deadlocks on — same as the #115 screenshot tests.
    final bytes = await tester.runAsync(() => CaptureBoundaryImage.call(key));

    // PNG magic header: 89 50 4E 47.
    expect(bytes!.sublist(0, 4), [0x89, 0x50, 0x4E, 0x47]);
  });
}
