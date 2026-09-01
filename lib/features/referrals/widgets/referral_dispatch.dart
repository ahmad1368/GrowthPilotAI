import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:growth_pilot_ai/business/build_email_invite_uri.dart';
import 'package:growth_pilot_ai/business/build_sms_invite_uri.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';

/// Opens the right device intent for one dispatch channel (Issue
/// #542, acceptance criteria 3 and 6) — split out of
/// [ReferralActions]; every path requires the user to tap Send in
/// their own app, never an automated backend send.
Future<void> dispatchReferralInvite(
  ReferralChannel channel,
  String contactIdentifier,
  String appName,
  String message,
) async {
  switch (channel) {
    case ReferralChannel.smsApi:
      await launchUrl(BuildSmsInviteUri.call(contactIdentifier, message));
    case ReferralChannel.emailApi:
      await launchUrl(BuildEmailInviteUri.call(contactIdentifier, 'Join me on $appName', message));
    case ReferralChannel.shareSheet:
      await SharePlus.instance.share(ShareParams(text: message));
  }
}
