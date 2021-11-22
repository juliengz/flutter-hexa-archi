import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_backend_gateway.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/is_already_signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signout_use_case.dart';
import 'package:flutter_clean_archi/providers/http/http_auth_backend_gateway.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ui state management
  sl.registerFactory(
    () => AuthNotifier(
      signinUseCase: sl(),
      signoutUseCase: sl(),
      isAlreadySigninUseCase: sl(),
    ),
  );

  // Domain
  sl.registerFactory(() => SigninUseCase(authBackendGateway: sl()));
  sl.registerFactory(() => SignoutUseCase(authBackendGateway: sl()));
  sl.registerFactory(() => IsAlreadySigninUseCase(authBackendGateway: sl()));

  // Providers
  sl.registerLazySingleton<AuthBackendGateway>(
    () => HttpAuthBackendGateway(),
  );
}
