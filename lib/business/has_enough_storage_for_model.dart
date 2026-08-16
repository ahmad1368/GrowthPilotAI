/// Whether [freeBytes] clears the issue's "at least 4GB free" AC before
/// starting the model download (Issue #196) — a real implementation
/// would source [freeBytes] from a device-storage plugin; this scaffold
/// only covers the comparison itself (see PR notes).
class HasEnoughStorageForModel {
  static const requiredFreeBytes = 4 * 1024 * 1024 * 1024;

  static bool call(int freeBytes) => freeBytes >= requiredFreeBytes;
}
