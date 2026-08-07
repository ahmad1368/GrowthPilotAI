/// Invitation text for an unmatched contact (Issue #541, value-added
/// feature 1: "Quick Chat Invitation").
class BuildQuickInviteMessage {
  static String call(String appName) =>
      "Hey! I'm using $appName to run my business — join me here: "
      'https://growthpilot.ai/invite';
}
