import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signout_use_case.dart';
import 'package:flutter_clean_archi/providers/auth/jwt_auth_manager.dart';
import 'package:flutter_clean_archi/providers/data_sources/network/auth_data_source.dart';
import 'package:flutter_clean_archi/providers/repositories/auth_repository.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:flutter_clean_archi/ui/home/notifiers/home_notifier.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ui state management
  sl.registerFactory(
    () => HomeNotifier(signinUseCase: sl()),
  );

  sl.registerFactory(
    () => AuthNotifier(
      authManager: sl(),
      signinUseCase: sl(),
      signoutUseCase: sl(),
    ),
  );

  // Domain
  sl.registerFactory(() => SigninUseCase(authManager: sl()));
  sl.registerFactory(() => SignoutUseCase(authManager: sl()));

  // Providers
  sl.registerFactory(() => JwtAuthManager(authRepository: sl()));

  sl.registerLazySingleton<AuthManagerInterface>(
    () => JwtAuthManager(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepository(
      authDataSource: sl(),
    ),
  );
  sl.registerFactory<AuthDataSource>(() => AuthDataSource());
}
