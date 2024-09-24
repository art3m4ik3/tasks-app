import 'package:tasks_flutter_app/localizations.dart';
import '../viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('settings'))),
      body: Column(
        children: [
          ListTile(
            title:
                Text(AppLocalizations.of(context).translate('theme_selection')),
            trailing: DropdownButton<ThemeMode>(
              value: settingsViewModel.themeMode,
              items: ThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode.toString().split('.').last),
                );
              }).toList(),
              onChanged: (mode) {
                settingsViewModel.setThemeMode(mode!);
              },
            ),
          ),
          ListTile(
            title: Text(
                AppLocalizations.of(context).translate("language_selection")),
            trailing: DropdownButton<String>(
              value: settingsViewModel.locale,
              items: ['en', 'ru'].map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (lang) {
                settingsViewModel.setLocale(lang!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
