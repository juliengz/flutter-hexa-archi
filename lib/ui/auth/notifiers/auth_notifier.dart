import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signout_use_case.dart';

class AuthNotifier with ChangeNotifier {
  final AuthManagerInterface authManager;
  final SigninUseCase signinUseCase;
  final SignoutUseCase signoutUseCase;

  AuthNotifier({
    required this.authManager,
    required this.signinUseCase,
    required this.signoutUseCase,
  });

  bool isLoading = false;
  String? error;

  Future<void> signin(
      BuildContext context, String login, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await signinUseCase(login, password);

    result.fold(
      (failure) {
        error = (failure is BadCredentialFailure)
            ? "Bad credentials"
            : "Something's wrong";
        isLoading = false;
      },
      (data) {
        error = null;
        isLoading = false;
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );

    notifyListeners();
  }

  Future<void> signout(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await signoutUseCase();

    isLoading = false;

    Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);

    notifyListeners();
  }
}
