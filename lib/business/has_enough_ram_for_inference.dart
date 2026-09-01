/// Whether [availableRamMb] clears the issue's "at least 500MB free"
/// pre-flight check before loading the on-device model (Issue #197).
class HasEnoughRamForInference {
  static const requiredFreeMb = 500;

  static bool call(int availableRamMb) => availableRamMb >= requiredFreeMb;
}
