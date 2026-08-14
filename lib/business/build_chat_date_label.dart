/// "Today"/"Yesterday"/date "Sticky Date Header" label (Issue #123/#136 AC).
class BuildChatDateLabel {
  static String call(DateTime sentAt, DateTime now) {
    final date = DateTime(sentAt.year, sentAt.month, sentAt.day);
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
