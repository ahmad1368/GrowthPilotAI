import 'dart:async';

/// Collapses rapid-fire calls into one (Issue #116): each [run] cancels any
/// pending [callback] and reschedules it [duration] out, so e.g. dragging a
/// config slider only triggers a single downstream recompute once input
/// settles, not one per frame.
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer(this.duration);

  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void dispose() => _timer?.cancel();
}
