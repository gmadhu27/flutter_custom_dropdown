import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'country_selector_example.dart';
import 'theme/example_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  bool get _isDarkMode => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Selector',
      theme: ExampleTheme.light,
      darkTheme: ExampleTheme.dark,
      themeMode: _themeMode,
      home: CountrySelectorExample(
        isDarkMode: _isDarkMode,
        onThemeChanged: (isDarkMode) {
          setState(() {
            _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
          });
        },
      ),
    );
  }
}
