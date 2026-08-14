import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/dashboard_template.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _template = DashboardTemplate(
  id: 'trend_watcher',
  name: 'The Trend Watcher',
  description: 'Leads with the AI strategy narrative.',
  layout: [],
);

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows the template name and description', (tester) async {
    await tester.pumpWidget(_wrap(DashboardTemplateCard(
      template: _template,
      isApplied: false,
      onTap: () {},
    )));

    expect(find.text('The Trend Watcher'), findsOneWidget);
    expect(find.text('Leads with the AI strategy narrative.'), findsOneWidget);
    expect(find.text('Applied'), findsNothing);
  });

  testWidgets('shows an Applied footer when isApplied is true', (tester) async {
    await tester.pumpWidget(_wrap(DashboardTemplateCard(
      template: _template,
      isApplied: true,
      onTap: () {},
    )));

    expect(find.text('Applied'), findsOneWidget);
  });

  testWidgets('tapping the card calls onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_wrap(DashboardTemplateCard(
      template: _template,
      isApplied: false,
      onTap: () => tapped = true,
    )));

    await tester.tap(find.byType(DashboardTemplateCard));
    expect(tapped, true);
  });
}
