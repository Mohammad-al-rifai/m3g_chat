import 'package:flutter/material.dart';
import 'components/resources/routes_manager.dart';
import 'components/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // named Constructor

  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // Singleton or Single Instance.

  factory MyApp() => _instance; //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getLightApplicationTheme(),
    );
  }
}
