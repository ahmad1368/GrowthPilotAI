/// Guards batch actions (Issue #76): confirmation is required before
/// archiving/deleting more than [threshold] items at once, so a stray
/// "Select All" + "Archive" can't wipe out the inbox by accident.
class RequiresBulkConfirmation {
  static const int threshold = 50;

  static bool call(int itemCount) => itemCount > threshold;
}
