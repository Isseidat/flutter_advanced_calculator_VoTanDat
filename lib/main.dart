import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/calculator_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/history_provider.dart';

// Screens / Widgets
import 'screens/settings_screen.dart';
import 'widgets/display_area.dart';
import 'widgets/button_grid.dart';
import 'widgets/mode_selector.dart';
import 'widgets/history_preview.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Calculator',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DisplayArea(),
            const SizedBox(height: 8),
            HistoryPreview(),
            const SizedBox(height: 8),
            ModeSelector(),
            const SizedBox(height: 16),
            Expanded(child: ButtonGrid()),
          ],
        ),
      ),
    );
  }
}
