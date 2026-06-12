// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:shadcn_ui/shadcn_ui.dart';
// import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
// import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/ocr_confirmation_form_card.dart';

// void main() {
//   testWidgets(
//       'OcrConfirmationFormCard renders correctly with Shadcn architecture',
//       (WidgetTester tester) async {
//     final mockData = OcrFormData(); // بر اساس مدل پروژه نمونه‌سازی اولیه شود

//     await tester.pumpWidget(
//       ShadApp(
//         home: Scaffold(
//           body: OcrConfirmationFormCard(initialData: mockData),
//         ),
//       ),
//     );

//     expect(find.byType(ShadCard), findsOneWidget);
//     expect(find.text("تایید و ویرایش فاکتور فیسکال"), findsOneWidget);
//     expect(find.text("تایید فاکتور"), findsOneWidget);
//   });
// }
