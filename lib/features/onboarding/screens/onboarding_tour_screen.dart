import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_onboarding_steps.dart';
import 'package:growth_pilot_ai/controllers/onboarding_controller.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_page_view.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_skip_bar.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_tour_bottom_bar.dart';

/// First-launch feature tour (Issue #162), flat and platform-specific.
class OnboardingTourScreen extends StatefulWidget {
  final VoidCallback onDone;
  const OnboardingTourScreen({super.key, required this.onDone});

  @override
  State<OnboardingTourScreen> createState() => _OnboardingTourScreenState();
}

class _OnboardingTourScreenState extends State<OnboardingTourScreen> {
  final _pageController = PageController();
  final _steps = BuildOnboardingSteps.call(isWeb: kIsWeb);
  int _index = 0;

  Future<void> _finish() async {
    await Get.find<OnboardingController>().finish();
    widget.onDone();
  }

  bool get _isLast => _index == _steps.length - 1;

  void _next() => _isLast
      ? _finish()
      : _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: OnboardingSkipBar(onSkip: _finish),
        body: SafeArea(
          child: Column(children: [
            Expanded(
                child: OnboardingPageView(
                    controller: _pageController, steps: _steps, onPageChanged: (i) => setState(() => _index = i))),
            OnboardingTourBottomBar(stepCount: _steps.length, activeIndex: _index, isLast: _isLast, onNext: _next),
          ]),
        ),
      );
}
