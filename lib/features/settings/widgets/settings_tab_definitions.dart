import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/features/settings/screens/settings_account_tab.dart';
import 'package:growth_pilot_ai/features/settings/screens/settings_general_tab.dart';
import 'package:growth_pilot_ai/features/settings/screens/settings_integrations_tab.dart';
import 'package:growth_pilot_ai/features/settings/screens/settings_more_tab.dart';

/// [Issue #808] The four Settings tabs, extracted out of SettingsScreen
/// to keep that file under this repo's ~50-line-per-file budget.
/// `expandContent: true` gives each tab's ListView the bounded height it
/// needs (see SettingsScreen's doc comment for why).
const List<ShadTab<String>> kSettingsTabs = [
  ShadTab(
    value: 'general',
    expandContent: true,
    child: Text('General'),
    content: SettingsGeneralTab(),
  ),
  ShadTab(
    value: 'account',
    expandContent: true,
    child: Text('Account'),
    content: SettingsAccountTab(),
  ),
  ShadTab(
    value: 'integrations',
    expandContent: true,
    child: Text('Integrations'),
    content: SettingsIntegrationsTab(),
  ),
  ShadTab(
    value: 'more',
    expandContent: true,
    child: Text('More'),
    content: SettingsMoreTab(),
  ),
];
