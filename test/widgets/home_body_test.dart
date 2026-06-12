import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/widgets/home_body.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

class MockConnectivityService extends GetxService {
  final isOnline = true.obs;
  void onUserInteraction() {}
}

void main() {
  setUp(() {
    Get.put<ConnectivityService>(
        MockConnectivityService() as ConnectivityService);
  });

  testWidgets(
      'HomeBody renders flat dashboard integration and passes child contract',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: HomeBody(controller: ScrollController()),
      ),
    ));

    expect(find.text("داشبورد مدیریتی GrowthPilot"), findsOneWidget);
    expect(find.text("وضعیت سیستم"), findsOneWidget);
  });
}
