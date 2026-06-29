import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_bindings.dart';
import 'app/routes/routes.dart';
import 'app/routes/routes_handler.dart';
import 'app/theme/app_theme.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global dependencies (SharedPreferences, Firebase, etc.)
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FieldTrack',
      debugShowCheckedModeBanner: false,

      // Global Bindings
      initialBinding: InitialBindings(),

      // Routing
      initialRoute: BaseRoute.splash,
      getPages: routesHandler,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
