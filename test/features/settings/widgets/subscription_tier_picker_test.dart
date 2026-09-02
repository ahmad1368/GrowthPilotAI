import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/subscription_tier_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// SubscriptionTierPicker reads ShadTheme.of(context) directly, so it needs
// a ShadTheme ancestor when pumped in isolation.
Widget _wrap(Widget child) => GetMaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  group('SubscriptionTierPicker', () {
    testWidgets('tapping a tier invokes onSelected with that tier (Issue #171)', (tester) async {
      SubscriptionTier? picked;

      await tester.pumpWidget(_wrap(
        SubscriptionTierPicker(
          selected: SubscriptionTier.starter,
          onSelected: (tier) => picked = tier,
        ),
      ));

      await tester.tap(find.text('pro'));
      await tester.pump();

      expect(picked, SubscriptionTier.pro);
    });

    testWidgets('shows a check mark next to the currently selected tier', (tester) async {
      await tester.pumpWidget(_wrap(
        SubscriptionTierPicker(selected: SubscriptionTier.enterprise, onSelected: (_) {}),
      ));

      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });
  });
}
