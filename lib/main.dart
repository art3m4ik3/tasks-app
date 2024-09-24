import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tasks_flutter_app/localizations.dart';
import 'package:tasks_flutter_app/task_manager.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'screens/settings_screen.dart';
import 'screens/home_screen.dart';
import 'screens/bin_screen.dart';

void main() {
  runApp(const TasksApp());
}

class TasksApp extends StatelessWidget {
  const TasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => TaskManager())
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Task App',
            themeMode: settings.themeMode,
            locale: Locale(settings.locale),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/bin': (context) => const BinScreen(),
            },
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ru', 'RU'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
