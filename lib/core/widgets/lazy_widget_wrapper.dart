import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/widgets/widget_shimmer_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// "Wake" cycle for one report widget (Issue #119): shows [WidgetShimmerLoader]
/// until [widgetId] has scrolled at least 10% into the viewport, then builds
/// [child] permanently — [AutomaticKeepAliveClientMixin] keeps it built (not
/// torn back down to a shimmer) if the tile is later scrolled off-screen.
class LazyWidgetWrapper extends StatefulWidget {
  final String widgetId;
  final Widget child;

  const LazyWidgetWrapper({super.key, required this.widgetId, required this.child});

  @override
  State<LazyWidgetWrapper> createState() => _LazyWidgetWrapperState();
}

class _LazyWidgetWrapperState extends State<LazyWidgetWrapper>
    with AutomaticKeepAliveClientMixin {
  bool _hasBeenVisible = false;

  @override
  bool get wantKeepAlive => _hasBeenVisible;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: Key('lazy-${widget.widgetId}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_hasBeenVisible) {
          setState(() => _hasBeenVisible = true);
        }
      },
      child: _hasBeenVisible ? widget.child : const WidgetShimmerLoader(),
    );
  }
}
