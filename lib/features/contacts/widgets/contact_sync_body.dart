import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/contact_sync_result.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_actions.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_repos.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_view.dart';

/// Owns contact-sync state (Issue #541) — a self-contained demo of
/// the hashing/matching pipeline; this app has no native
/// contact-reading plugin, so contacts are entered manually rather
/// than imported from the device address book.
class ContactSyncBody extends StatefulWidget {
  const ContactSyncBody({super.key});
  @override
  State<ContactSyncBody> createState() => _ContactSyncBodyState();
}

class _ContactSyncBodyState extends State<ContactSyncBody> {
  final _repos = ContactSyncRepos();
  late final _actions = ContactSyncActions(_repos);
  late bool _isEnabled = _repos.preference.get().isEnabled;
  ContactSyncResult? _lastResult;

  Future<void> _sync(String pastedContacts) async {
    await _actions.requestPermission();
    setState(() => _lastResult = _actions.sync(pastedContacts));
  }

  void _setEnabled(bool enabled) {
    _actions.setEnabled(enabled);
    setState(() {
      _isEnabled = enabled;
      if (!enabled) _lastResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContactSyncView(
      isEnabled: _isEnabled,
      result: _lastResult,
      onSetEnabled: _setEnabled,
      onSync: _sync,
    );
  }
}
