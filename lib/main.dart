// Main entry point DigiNews Indonesia
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/env_config.dart';
import 'core/database/isar/isar_service.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme_cubit.dart';

import 'features/home/presentation/cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Isar
  await IsarService.init();

  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => locator<HomeCubit>()..loadNews(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => locator<ThemeCubit>(),
        ),
      ],
      child: const FinalProjectApp(),
    ),
  );
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: !EnvConfig.isProduction,
          title: "DigiNews Indonesia",

          themeMode: mode,

          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.light,
          ),

          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.dark,
          ),

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}