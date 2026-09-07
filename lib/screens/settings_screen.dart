import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_tab_definitions.dart';

/// [Issue #808] Settings screen, reorganized from one long flat scroll
/// (15 sections stacked in a single ListView) into four grouped tabs —
/// General, Account & Security, Integrations & Billing, More (see
/// [kSettingsTabs]). No setting was removed in the reorganization; see
/// the individual tab files (lib/features/settings/screens/
/// settings_*_tab.dart) for the section-by-section mapping.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selected = 'general';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadTheme(
      data: AppShadTheme.build(theme.brightness),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: ShadTabs<String>(
            value: _selected,
            onChanged: (v) => setState(() => _selected = v),
            scrollable: true,
            // ShadTabs keeps every tab's content mounted by default
            // (maintainState: true) so only the *selected* tab's Expanded
            // wrapper would give its ListView bounded height — the other
            // three would sit as plain non-flex Column children and hit
            // the exact "unbounded ListView" crash fixed project-wide in
            // #791/#793. false unmounts non-selected tabs entirely.
            maintainState: false,
            tabs: kSettingsTabs,
          ),
        ),
      ),
    );
  }
}
