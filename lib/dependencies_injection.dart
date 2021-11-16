import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_clean_archi/providers/data_sources/network/auth_data_source.dart';
import 'package:flutter_clean_archi/providers/repositories/auth_repository.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/signin_notifier.dart';
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
    () => SigninNotifier(signinUseCase: sl()),
  );

  // Domain
  sl.registerFactory(() => SigninUseCase(authRepository: sl()));

  // Providers
  sl.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepository(
      authDataSource: sl(),
    ),
  );
  sl.registerFactory<AuthDataSource>(() => AuthDataSource());
}
