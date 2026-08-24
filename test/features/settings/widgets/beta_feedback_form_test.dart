import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/beta_feedback_form.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// BetaFeedbackForm reads ShadTheme.of(context) directly, so it needs a
// ShadTheme ancestor when pumped in isolation.
Widget _wrap(Widget child) => GetMaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  group('BetaFeedbackForm', () {
    testWidgets('submits the default 5-star rating and typed comment', (tester) async {
      int? submittedRating;
      String? submittedComment;

      await tester.pumpWidget(_wrap(
        BetaFeedbackForm(onSubmit: (rating, comment) {
          submittedRating = rating;
          submittedComment = comment;
        }),
      ));

      await tester.enterText(find.byType(ShadInput), 'Great app!');
      await tester.tap(find.text('Send Feedback'));
      await tester.pump();

      expect(submittedRating, 5);
      expect(submittedComment, 'Great app!');
    });

    testWidgets('lowering the rating changes the submitted value', (tester) async {
      int? submittedRating;

      await tester.pumpWidget(_wrap(
        BetaFeedbackForm(onSubmit: (rating, comment) => submittedRating = rating),
      ));

      // Tap the 2nd star to set the rating to 2.
      await tester.tap(find.byIcon(Icons.star_rounded).at(1));
      await tester.pump();
      await tester.tap(find.text('Send Feedback'));
      await tester.pump();

      expect(submittedRating, 2);
    });
  });
}
