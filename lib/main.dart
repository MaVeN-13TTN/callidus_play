// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/core/theme/app_theme.dart';
import 'app_binding.dart';
import 'app/core/values/strings.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize required services
    await initServices();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    runApp(const CallidusPlayApp());
  } catch (error) {
    print('Error during initialization: $error');
    // You might want to show some error UI here
  }
}

Future<void> initServices() async {
  try {
    // Initialize storage first
    await GetStorage.init();

    // Initialize AppBinding
    final appBinding = AppBinding();
    appBinding.dependencies();

    print('All services started...');
  } catch (e) {
    print('Error initializing services: $e');
    rethrow;
  }
}

class CallidusPlayApp extends StatelessWidget {
  const CallidusPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      theme: AppTheme.lightTheme,
      //darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
            overscroll: false,
          ),
          child: child!,
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
      },
      navigatorObservers: const [],
    );
  }
}
