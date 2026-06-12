import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/widgets/picker/image_source_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
      'ImageSourcePicker triggers correct callbacks upon source selection',
      (WidgetTester tester) async {
    ImageSource? selectedSource;

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: ImageSourcePicker(
            onSelected: (source) => selectedSource = source,
          ),
        ),
      ),
    );

    // بررسی وجود دکمه‌ها و متن‌ها
    expect(find.text("Take Photo"), findsOneWidget);
    expect(find.text("Choose from Gallery"), findsOneWidget);

    // تست کلیک روی گزینه دوربین
    await tester.tap(find.text("Take Photo"));
    await tester.pumpAndSettle();
    expect(selectedSource, ImageSource.camera);

    // تست کلیک روی گزینه گالری
    await tester.tap(find.text("Choose from Gallery"));
    await tester.pumpAndSettle();
    expect(selectedSource, ImageSource.gallery);
  });
}
