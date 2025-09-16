import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../core/di/service_locator.dart';
import '../core/env/app_env.dart';
import '../core/logging/app_logger.dart';
import '../core/network/auth_interceptor.dart';
import '../core/network/dio_client.dart';
import '../core/network/logging_interceptor.dart';
import '../core/network/unwrap_interceptor.dart';
import '../core/storage/secure_store.dart';
// Features
import '../features/auth/data/datasources/auth_remote_ds.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/clients/data/datasources/client_remote_ds.dart';
import '../features/clients/data/repositories/client_repository_impl.dart';
import '../features/clients/domain/repositories/client_repository.dart';
import '../features/profile/data/datasources/profile_remote_ds.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/users/data/datasources/user_remote_ds.dart';
import '../features/users/data/repositories/user_repository_impl.dart';
import '../features/users/domain/repositories/user_repository.dart';

class AppConfig {
  AppConfig._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 1) Env
    await AppEnv.initialize();

    // 2) Logger
    AppLogger.init();

    // 3) Core services
    sl.registerLazySingleton<SecureStore>(() => SecureStore());
    final dio = buildDio(baseUrl: AppEnv.apiBaseUrl, secureStore: sl());

    // 4) Interceptors (order: unwrap → log → auth)
    dio.interceptors.add(UnwrapInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(AuthInterceptor(sl()));
    sl.registerLazySingleton<Dio>(() => dio);

    // 5) Features
    // Auth
    sl.registerLazySingleton<IAuthRemoteDS>(() => AuthRemoteDSImpl(sl()));
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
    // Clients
    sl.registerLazySingleton<IClientRemoteDS>(() => ClientRemoteDSImpl(sl()));
    sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(sl()));
    // Users
    sl.registerLazySingleton<IUserRemoteDS>(() => UserRemoteDSImpl(sl()));
    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
    // Profile
    sl.registerLazySingleton<IProfileRemoteDS>(() => ProfileRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  }
}
