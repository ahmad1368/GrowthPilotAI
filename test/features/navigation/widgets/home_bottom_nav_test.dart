// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:growth_pilot_ai/features/navigation/controllers/navigation_controller.dart';
// import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shadcn_ui/shadcn_ui.dart';

// @GenerateMocks([NavigationController])

// void main() {
//   late MockNavigationController mockController;

//   setUp(() {
//     mockController = MockNavigationController();
//     Get.put<NavigationController>(mockController);
//   });

//   tearDown(() {
//     Get.clearBinding();
//   });

//   testWidgets('HomeBottomNav triggers handleNavigation on item tap',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const ShadApp(
//         home: Scaffold(
//           bottomNavigationBar: HomeBottomNav(currentIndex: 0),
//         ),
//       ),
//     );

//     // کلیک روی آیتم دوم (Insights)
//     await tester.tap(find.text('Insights'));
//     await tester.pumpAndSettle();

//     // تایید اینکه کنترلر با ایندکس درست صدا زده شده است
//     verify(mockController.handleNavigation(1)).called(1);
//   });
// }
