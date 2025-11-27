import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../models/calculator_mode.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final calcProvider = context.watch<CalculatorProvider>();
    final historyProvider = context.watch<HistoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme
          ListTile(
            title: const Text("Theme"),
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
                DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
              ],
              onChanged: (mode) {
                if (mode != null) themeProvider.setTheme(mode);
              },
            ),
          ),
          // Angle Mode
          ListTile(
            title: const Text("Angle Mode"),
            trailing: Switch(
                value: calcProvider.angleMode == AngleMode.degrees,
                onChanged: (val) {
                  calcProvider.setAngleMode(val ? AngleMode.degrees : AngleMode.radians);
              },
            ),
          ),
          // Clear History
          ListTile(
            title: const Text("Clear History"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text("Clear all history?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
                if (ok == true) {
                  await historyProvider.clearHistory();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
