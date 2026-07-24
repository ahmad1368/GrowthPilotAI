import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_apply_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('renders nothing when there is no dirty preview',
      (tester) async {
    await tester.pumpWidget(_wrap(const WidgetConfigApplyBar(
      isPreviewing: false,
      onApply: _noop,
      onReset: _noop,
    )));

    expect(find.byType(ShadButton), findsNothing);
  });

  testWidgets('Apply/Reset call their callbacks while previewing',
      (tester) async {
    var applied = false;
    var reset = false;

    await tester.pumpWidget(_wrap(WidgetConfigApplyBar(
      isPreviewing: true,
      onApply: () => applied = true,
      onReset: () => reset = true,
    )));

    await tester.tap(find.text('Apply'));
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(applied, true);
    expect(reset, true);
  });
}

void _noop() {}
