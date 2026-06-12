import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_page.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockEnvironmentService extends GetxService {
  var isRemoteEnabled = false.obs;
  void toggleDataSource(bool val) => isRemoteEnabled.value = val;
}

void main() {
  setUp(() {
    Get.put<EnvironmentService>(MockEnvironmentService() as EnvironmentService);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SettingsPage renders correctly in debug environment mode',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: SettingsPage(),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.byType(ShadCard), findsOneWidget);
  });
}
