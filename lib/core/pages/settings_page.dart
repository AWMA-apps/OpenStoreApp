import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_store/core/settings_providers/settings_providers.dart';
import 'package:open_store/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(tr.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(tr.language),
            trailing: DropdownButton(
              items: const [
                DropdownMenuItem(child: Text("English"), value: "en"),
                DropdownMenuItem(child: Text("العربيَة"), value: "ar"),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(localProvider.notifier).setLocalLanguage(value);
                }
              },
            ),
          ),
          const Divider(),
          SwitchListTile(
            value: themeMode == ThemeMode.dark,
            title: Text(tr.darkMode),
            onChanged: (value) {
              ref.read(themeProvider.notifier).toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}
