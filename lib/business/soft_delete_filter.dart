/// Client mirror of the backend soft-delete query middleware: by default lists
/// exclude records flagged as deleted; [trashed] returns only the recoverable
/// "Trash" for a restore view.
class SoftDeleteFilter {
  static List<T> active<T>(Iterable<T> items, bool Function(T) isDeleted) =>
      items.where((e) => !isDeleted(e)).toList();

  static List<T> trashed<T>(Iterable<T> items, bool Function(T) isDeleted) =>
      items.where(isDeleted).toList();
}
