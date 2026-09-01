/// Formats a video's [Duration] as "M:SS" (or "H:MM:SS" past an hour)
/// for the Business Academy card (Issue #163).
class FormatVideoDuration {
  static String call(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:$seconds';
    }
    return '$minutes:$seconds';
  }
}
