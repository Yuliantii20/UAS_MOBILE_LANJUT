import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../config/env_config.dart';
import '../database/isar/isar_service.dart';
import '../theme/theme_cubit.dart';

import '../../features/home/data/datasource/news_remote_datasource.dart';
import '../../features/home/data/local/favorite_local_datasource.dart';
import '../../features/home/data/local/news_local_datasource.dart';
import '../../features/home/data/repository/news_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {

  // ============================
  // Isar
  // ============================
  locator.registerLazySingleton<Isar>(
    () => IsarService.isar,
  );

  // ============================
  // Dio
  // ============================
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );

  // ============================
  // Datasource
  // ============================
  locator.registerLazySingleton<NewsRemoteDatasource>(
    () => NewsRemoteDatasource(),
  );

  locator.registerLazySingleton<NewsLocalDatasource>(
    () => NewsLocalDatasource(),
  );

  locator.registerLazySingleton<FavoriteLocalDatasource>(
    () => FavoriteLocalDatasource(),
  );

  // ============================
  // Repository
  // ============================
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepository(
      locator<NewsRemoteDatasource>(),
      locator<NewsLocalDatasource>(),
    ),
  );

  // ============================
  // Cubit
  // ============================
  locator.registerFactory<HomeCubit>(
    () => HomeCubit(
      locator<NewsRepository>(),
    ),
  );

  // ============================
  // Theme Cubit
  // ============================
  locator.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(),
  );
}